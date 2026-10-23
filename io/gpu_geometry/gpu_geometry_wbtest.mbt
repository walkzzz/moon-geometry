///|
test "morton_code_2d" {
  let m = morton_code_2d(1, 0)
  assert_eq(m, 1)
}

///|
test "morton_code_2d both" {
  let m = morton_code_2d(1, 1)
  assert_eq(m, 3)
}

///|
test "meshlet_bounds" {
  let (center, r) = meshlet_bounds([(0.0, 0.0, 0.0), (2.0, 0.0, 0.0)])
  assert_true(center.0 > 0.99 && center.0 < 1.01)
  assert_true(r > 0.99 && r < 1.01)
}
