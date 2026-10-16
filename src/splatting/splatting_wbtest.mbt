test "gaussian_splat center" {
  let v = gaussian_splat(0.0, 0.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
test "splat_radius" {
  let r = splat_radius(10.0, 2.0)
  assert_true(r > 4.99 && r < 5.01)
}
test "splat_coverage outside" {
  let c = splat_coverage(10.0, 0.0, 0.0, 0.0, 1.0)
  assert_true(c.abs() < 0.001)
}
