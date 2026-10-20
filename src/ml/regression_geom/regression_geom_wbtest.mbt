test "linear_regression perfect" {
  let (slope, intercept) = linear_regression([0.0, 1.0, 2.0], [0.0, 1.0, 2.0])
  assert_true(slope > 0.99 && slope < 1.01)
  assert_true(intercept.abs() < 0.01)
}
test "r_squared perfect" {
  let r2 = r_squared([0.0, 1.0, 2.0], [0.0, 1.0, 2.0], 1.0, 0.0)
  assert_true(r2 > 0.99)
}
test "residual_norm zero" {
  let r = residual_norm([0.0, 1.0], [0.0, 1.0], 1.0, 0.0)
  assert_true(r < 0.001)
}
