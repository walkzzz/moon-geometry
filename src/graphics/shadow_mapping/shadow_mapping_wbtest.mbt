test "shadow_factor lit" {
  let s = shadow_factor(0.5, 0.8, 0.001)
  assert_true(s > 0.99)
}
test "shadow_factor shadowed" {
  let s = shadow_factor(0.8, 0.5, 0.001)
  assert_true(s.abs() < 0.01)
}
test "vsm_chebyshev" {
  let p = vsm_chebyshev(0.5, 0.3, 0.01)
  assert_true(p > 0.0 && p < 1.0)
}
