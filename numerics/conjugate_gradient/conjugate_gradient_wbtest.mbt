///|
test "cg_linear identity" {
  let a = [[1.0, 0.0], [0.0, 1.0]]
  let b = [3.0, 5.0]
  let x = cg_linear(a, b, [0.0, 0.0], 50)
  assert_true((x[0] - 3.0).abs() < 0.000001)
  assert_true((x[1] - 5.0).abs() < 0.000001)
}

///|
test "cg_linear spd" {
  let a = [[4.0, 1.0], [1.0, 3.0]]
  let b = [1.0, 2.0]
  let x = cg_linear(a, b, [0.0, 0.0], 100)
  let r0 = 4.0 * x[0] + 1.0 * x[1] - 1.0
  let r1 = 1.0 * x[0] + 3.0 * x[1] - 2.0
  assert_true(r0.abs() < 0.0001)
  assert_true(r1.abs() < 0.0001)
}

///|
test "cg_linear 3x3" {
  let a = [[4.0, 0.0, 0.0], [0.0, 5.0, 0.0], [0.0, 0.0, 6.0]]
  let b = [8.0, 10.0, 12.0]
  let x = cg_linear(a, b, [0.0, 0.0, 0.0], 50)
  assert_true((x[0] - 2.0).abs() < 0.000001)
  assert_true((x[1] - 2.0).abs() < 0.000001)
  assert_true((x[2] - 2.0).abs() < 0.000001)
}

///|
test "pcg_linear with jacobi" {
  let a = [[4.0, 1.0], [1.0, 3.0]]
  let b = [1.0, 2.0]
  let m_inv = jacobi_preconditioner(a, 2)
  let x = pcg_linear(a, b, m_inv, [0.0, 0.0], 100)
  let r0 = 4.0 * x[0] + 1.0 * x[1] - 1.0
  let r1 = 1.0 * x[0] + 3.0 * x[1] - 2.0
  assert_true(r0.abs() < 0.0001)
  assert_true(r1.abs() < 0.0001)
}

///|
test "pcg_linear identity precond" {
  let a = [[2.0, 0.0], [0.0, 2.0]]
  let b = [4.0, 6.0]
  let m_inv = fn(r : Array[Double]) -> Array[Double] { [r[0], r[1]] }
  let x = pcg_linear(a, b, m_inv, [0.0, 0.0], 50)
  assert_true((x[0] - 2.0).abs() < 0.000001)
  assert_true((x[1] - 3.0).abs() < 0.000001)
}

///|
test "nonlinear_cg quadratic" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] + x[1] * x[1] }
  let grad = fn(x : Array[Double]) -> Array[Double] { [2.0 * x[0], 2.0 * x[1]] }
  let x = nonlinear_cg(f, grad, [1.0, 1.0], 100)
  assert_true(x[0].abs() < 0.01)
  assert_true(x[1].abs() < 0.01)
}

///|
test "nonlinear_cg shifted" {
  let f = fn(x : Array[Double]) -> Double {
    (x[0] - 3.0) * (x[0] - 3.0) + (x[1] + 2.0) * (x[1] + 2.0)
  }
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * (x[0] - 3.0), 2.0 * (x[1] + 2.0)]
  }
  let x = nonlinear_cg(f, grad, [0.0, 0.0], 100)
  assert_true((x[0] - 3.0).abs() < 0.01)
  assert_true((x[1] + 2.0).abs() < 0.01)
}

///|
test "nonlinear_cg_2d basic" {
  let f = fn(x : Double, y : Double) -> Double { x * x + y * y }
  let grad = fn(x : Double, y : Double) -> (Double, Double) {
    (2.0 * x, 2.0 * y)
  }
  let p = nonlinear_cg_2d(f, grad, 1.0, 1.0, 100)
  assert_true(p.x().abs() < 0.01)
  assert_true(p.y().abs() < 0.01)
}

///|
test "cg_linear already solved" {
  let a = [[2.0, 0.0], [0.0, 2.0]]
  let b = [4.0, 6.0]
  let x = cg_linear(a, b, [2.0, 3.0], 50)
  assert_true((x[0] - 2.0).abs() < 0.000001)
  assert_true((x[1] - 3.0).abs() < 0.000001)
}

///|
test "jacobi_preconditioner basic" {
  let a = [[4.0, 1.0], [1.0, 3.0]]
  let m_inv = jacobi_preconditioner(a, 2)
  let z = m_inv([4.0, 3.0])
  assert_true((z[0] - 1.0).abs() < 0.000001)
  assert_true((z[1] - 1.0).abs() < 0.000001)
}
