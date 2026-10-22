test "poisson_jacobi" {
  let u = poisson_jacobi([0.0, 0.0, 0.0], [1.0, 1.0, 1.0], 1.0)
  assert_eq(u.length(), 3)
}
test "poisson_residual zero" {
  let r = poisson_residual([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], 1.0)
  assert_true(r.abs() < 0.001)
}
