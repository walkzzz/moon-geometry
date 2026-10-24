///|
test "poisson_jacobi" {
  let u = poisson_jacobi([0.0, 0.0, 0.0], [1.0, 1.0, 1.0], 1.0)
  assert_eq(u.length(), 3)
}

///|
test "poisson_residual zero" {
  let r = poisson_residual([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], 1.0)
  assert_true(r.abs() < 0.001)
}
///|
test "poisson_gauss_seidel" {
  let u = poisson_gauss_seidel([0.0, 0.0, 0.0], [1.0, 1.0, 1.0], 1.0)
  assert_eq(u.length(), 3)
  assert_true((u[0] - (-0.5)).abs() < 0.001)
  assert_true((u[1] - (-0.75)).abs() < 0.001)
  assert_true((u[2] - (-0.875)).abs() < 0.001)
}

///|
test "poisson_jacobi nonzero" {
  let u = poisson_jacobi([1.0, 2.0, 3.0], [0.0, 0.0, 0.0], 1.0)
  assert_true((u[0] - 1.0).abs() < 0.001)
  assert_true((u[1] - 2.0).abs() < 0.001)
  assert_true((u[2] - 1.0).abs() < 0.001)
}

///|
test "poisson_residual nonzero" {
  let r = poisson_residual([1.0, 0.0, 1.0], [0.0, 0.0, 0.0], 1.0)
  assert_true((r - 2.0).abs() < 0.001)
}
