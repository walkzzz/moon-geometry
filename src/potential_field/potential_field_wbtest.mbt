test "attractive_force" {
  let f = attractive_force((0.0, 0.0), (1.0, 0.0), 1.0)
  assert_true(f.0 > 0.99 && f.0 < 1.01)
}
test "repulsive_force far" {
  let f = repulsive_force((0.0, 0.0), (10.0, 0.0), 1.0, 1.0)
  assert_true(f.0.abs() < 0.0001)
}
test "force_magnitude" {
  let m = force_magnitude((3.0, 4.0))
  assert_true(m > 4.99 && m < 5.01)
}
