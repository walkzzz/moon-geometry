test "robust segment intersect" {
  let (x, y, ok) = robust_segment_intersect(0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0)
  assert_true(ok)
  assert_true(x > 0.49 && x < 0.51)
}

test "robust line line" {
  let (x, y, ok) = robust_line_line(1.0, 1.0, 3.0, 1.0, -1.0, 1.0)
  assert_true(ok)
  assert_eq(x, 2.0)
}

test "robust point on segment" {
  assert_true(robust_point_on_segment(0.5, 0.5, 0.0, 0.0, 1.0, 1.0))
}
