test "squared_exp_kernel" {
  let v = squared_exp_kernel(0.0, 0.0, 1.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
test "matern_kernel zero" {
  let v = matern_kernel(0.0, 0.0, 1.0, 1.5)
  assert_true(v > 0.99 && v < 1.01)
}
test "rational_quad_kernel" {
  let v = rational_quad_kernel(0.0, 0.0, 1.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
