test "power_iteration identity" {
  let (lambda, _) = power_iteration([[1.0, 0.0], [0.0, 1.0]], [1.0, 0.0], 10)
  assert_true(lambda > 0.99 && lambda < 1.01)
}
test "rayleigh_quotient" {
  let r = rayleigh_quotient([[2.0, 0.0], [0.0, 3.0]], [1.0, 0.0])
  assert_true(r > 1.99 && r < 2.01)
}
test "gershgorin_bounds" {
  let (lo, hi) = gershgorin_bounds([[2.0, 0.0], [0.0, 3.0]])
  assert_true(lo <= 2.0)
  assert_true(hi >= 3.0)
}
