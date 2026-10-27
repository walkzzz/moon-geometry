///|
test "newton_1d sqrt" {
  let f = fn(x : Double) -> Double { x * x - 2.0 }
  let fp = fn(x : Double) -> Double { 2.0 * x }
  let root = newton_1d(f, fp, 1.0, 0.0000000001, 50)
  assert_true((root - 1.41421356237).abs() < 0.000001)
}

///|
test "newton_1d cube" {
  let f = fn(x : Double) -> Double { x * x * x - 27.0 }
  let fp = fn(x : Double) -> Double { 3.0 * x * x }
  let root = newton_1d(f, fp, 2.0, 0.0000000001, 50)
  assert_true((root - 3.0).abs() < 0.000001)
}

///|
test "newton_multi quadratic" {
  let grad = fn(x : Array[Double]) -> Array[Double] { [2.0 * x[0], 2.0 * x[1]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[2.0, 0.0], [0.0, 2.0]]
  }
  let x = newton_multi(grad, hess, [1.0, 1.0], 0.0000000001, 50)
  assert_true(x[0].abs() < 0.000001)
  assert_true(x[1].abs() < 0.000001)
}

///|
test "newton_multi shifted" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * (x[0] - 3.0), 4.0 * (x[1] + 1.0)]
  }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[2.0, 0.0], [0.0, 4.0]]
  }
  let x = newton_multi(grad, hess, [0.0, 0.0], 0.0000000001, 50)
  assert_true((x[0] - 3.0).abs() < 0.000001)
  assert_true((x[1] + 1.0).abs() < 0.000001)
}

///|
test "newton_line_search quadratic" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] + x[1] * x[1] }
  let grad = fn(x : Array[Double]) -> Array[Double] { [2.0 * x[0], 2.0 * x[1]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[2.0, 0.0], [0.0, 2.0]]
  }
  let x = newton_line_search(f, grad, hess, [1.0, 1.0], 50)
  assert_true(x[0].abs() < 0.001)
  assert_true(x[1].abs() < 0.001)
}

///|
test "newton_trust_region quadratic" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] + x[1] * x[1] }
  let grad = fn(x : Array[Double]) -> Array[Double] { [2.0 * x[0], 2.0 * x[1]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[2.0, 0.0], [0.0, 2.0]]
  }
  let x = newton_trust_region(f, grad, hess, [1.0, 1.0], 10.0, 50)
  assert_true(x[0].abs() < 0.01)
  assert_true(x[1].abs() < 0.01)
}

///|
test "newton_2d basic" {
  let grad = fn(x : Double, y : Double) -> (Double, Double) {
    (2.0 * x, 2.0 * y)
  }
  let hess = fn(
    _x : Double,
    _y : Double,
  ) -> ((Double, Double), (Double, Double)) {
    ((2.0, 0.0), (0.0, 2.0))
  }
  let p = newton_2d(grad, hess, 1.0, 1.0, 50)
  assert_true(p.x().abs() < 0.000001)
  assert_true(p.y().abs() < 0.000001)
}

///|
test "newton_1d converges fast" {
  let f = fn(x : Double) -> Double { x * x - 4.0 }
  let fp = fn(x : Double) -> Double { 2.0 * x }
  let root = newton_1d(f, fp, 1.0, 0.0000000001, 10)
  assert_true((root - 2.0).abs() < 0.000001)
}

///|
test "newton_multi rosenbrock_approx" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [
      -400.0 * x[0] * (x[1] - x[0] * x[0]) - 2.0 * (1.0 - x[0]),
      200.0 * (x[1] - x[0] * x[0]),
    ]
  }
  let hess = fn(x : Array[Double]) -> Array[Array[Double]] {
    let h00 = -400.0 * (x[1] - 3.0 * x[0] * x[0]) + 2.0
    [[h00, -400.0 * x[0]], [-400.0 * x[0], 200.0]]
  }
  let x = newton_multi(grad, hess, [0.5, 0.5], 0.0000000001, 100)
  assert_true((x[0] - 1.0).abs() < 0.01)
  assert_true((x[1] - 1.0).abs() < 0.01)
}

///|
test "newton_1d zero derivative returns x" {
  // f(x)=x^2+1 has no real root; at x0=0 the derivative is 0, so the
  // `fpx.abs() < 1e-16` early-return branch is exercised.
  let f = fn(x : Double) -> Double { x * x + 1.0 }
  let fp = fn(x : Double) -> Double { 2.0 * x }
  let root = newton_1d(f, fp, 0.0, 0.0000000001, 50)
  assert_true(root.abs() < 0.000001)
}

///|
test "solve_linear singular returns none" {
  // All-zero matrix is singular: `max_val < 1e-16` triggers `return None`.
  let a = [[0.0, 0.0], [0.0, 0.0]]
  let result = solve_linear(a, [1.0, 2.0], 2)
  assert_true(result is None)
}

///|
test "solve_linear partial pivoting" {
  // Matrix needing a row swap (first pivot is 0) to cover `pivot != col`.
  let a = [[0.0, 1.0], [1.0, 0.0]]
  let result = solve_linear(a, [2.0, 3.0], 2)
  match result {
    Some(x) => {
      assert_true((x[0] - 3.0).abs() < 0.000001)
      assert_true((x[1] - 2.0).abs() < 0.000001)
    }
    None => assert_true(false)
  }
}

///|
test "newton_multi singular hessian breaks" {
  // Singular Hessian makes solve_linear return None -> `None => break`.
  let grad = fn(x : Array[Double]) -> Array[Double] { [2.0 * x[0], 2.0 * x[1]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[0.0, 0.0], [0.0, 0.0]]
  }
  let x = newton_multi(grad, hess, [1.0, 1.0], 0.0000000001, 50)
  assert_true((x[0] - 1.0).abs() < 0.000001)
  assert_true((x[1] - 1.0).abs() < 0.000001)
}

///|
test "newton_line_search singular hessian fallback" {
  // Singular Hessian -> None branch uses steepest descent direction -g.
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] + x[1] * x[1] }
  let grad = fn(x : Array[Double]) -> Array[Double] { [2.0 * x[0], 2.0 * x[1]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[0.0, 0.0], [0.0, 0.0]]
  }
  let x = newton_line_search(f, grad, hess, [1.0, 1.0], 50)
  assert_true(x[0].abs() < 0.001)
  assert_true(x[1].abs() < 0.001)
}

///|
test "newton_line_search not accepted breaks" {
  // Concave f=-x^2: Newton step is an ascent direction, Armijo never
  // accepts, so `!accepted` -> break and x stays at the initial point.
  let f = fn(x : Array[Double]) -> Double { -x[0] * x[0] }
  let grad = fn(x : Array[Double]) -> Array[Double] { [-2.0 * x[0]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] { [[-2.0]] }
  let x = newton_line_search(f, grad, hess, [1.0], 50)
  assert_true((x[0] - 1.0).abs() < 0.000001)
}

///|
test "newton_trust_region singular hessian fallback" {
  // Singular Hessian -> None branch falls back to -g as the step.
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] + x[1] * x[1] }
  let grad = fn(x : Array[Double]) -> Array[Double] { [2.0 * x[0], 2.0 * x[1]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[0.0, 0.0], [0.0, 0.0]]
  }
  let x = newton_trust_region(f, grad, hess, [1.0, 1.0], 10.0, 1)
  // One step with d=-g=[-2,-2]; ratio=0 so x is not updated.
  assert_true((x[0] - 1.0).abs() < 0.000001)
  assert_true((x[1] - 1.0).abs() < 0.000001)
}

///|
test "newton_trust_region step scaling and grow delta" {
  // Large gradient with small trust region triggers `d_norm > delta`
  // scaling; on a quadratic the ratio ~1 > 0.75 with a boundary step,
  // so delta is grown (`delta = (2*delta).min(max_delta)`).
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] + x[1] * x[1] }
  let grad = fn(x : Array[Double]) -> Array[Double] { [2.0 * x[0], 2.0 * x[1]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[2.0, 0.0], [0.0, 2.0]]
  }
  let x = newton_trust_region(f, grad, hess, [1.0, 1.0], 0.1, 100)
  assert_true(x[0].abs() < 0.1)
  assert_true(x[1].abs() < 0.1)
}

///|
test "newton_trust_region zero predicted breaks" {
  // Indefinite Hessian with grad=[1,1] gives d=[-1,1] and predicted
  // reduction pred = 0, hitting the `pred.abs() < 1e-16` break.
  let f = fn(_x : Array[Double]) -> Double { 0.0 }
  let grad = fn(_x : Array[Double]) -> Array[Double] { [1.0, 1.0] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] {
    [[1.0, 0.0], [0.0, -1.0]]
  }
  let x = newton_trust_region(f, grad, hess, [0.0, 0.0], 10.0, 50)
  assert_true(x[0].abs() < 0.000001)
  assert_true(x[1].abs() < 0.000001)
}

///|
test "newton_trust_region shrink delta" {
  // Exaggerated gradient makes the predicted reduction far larger than
  // the actual one, so ratio < 0.25 and delta is shrunk (`delta *= 0.5`).
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] }
  let grad = fn(x : Array[Double]) -> Array[Double] { [100.0 * x[0]] }
  let hess = fn(_x : Array[Double]) -> Array[Array[Double]] { [[1.0]] }
  let x = newton_trust_region(f, grad, hess, [1.0], 1.0, 1)
  // Step taken (ratio > 0), x moves from 1 toward 0.
  assert_true((x[0] - 1.0).abs() > 0.0)
  assert_true(x[0] < 1.0)
}
