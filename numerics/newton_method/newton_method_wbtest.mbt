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
