test "spherical_mapping" {
  let (u, v) = spherical_mapping((0.0, 0.0, 1.0))
  assert_true(v.abs() < 0.01)
}
test "cylindrical_mapping" {
  let (u, v) = cylindrical_mapping((1.0, 0.0, 0.5))
  assert_true(u.abs() < 0.01)
  assert_true(v > 0.49 && v < 0.51)
}
