test "adaptive orient2d" {
  let r = adaptive_orient2d(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

test "adaptive orient2d collinear" {
  let r = adaptive_orient2d(0.0, 0.0, 1.0, 1.0, 2.0, 2.0)
  assert_eq(r, 0)
}

test "precision level" {
  assert_eq(precision_level(200.0, 1.0), 0)
  assert_eq(precision_level(50.0, 1.0), 1)
}
