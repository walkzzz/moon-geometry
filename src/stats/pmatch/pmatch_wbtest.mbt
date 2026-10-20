test "point_match" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0)]
  let b = [@core.Point2D::new(0.1, 0.0), @core.Point2D::new(2.1, 0.0)]
  let m = point_match(a, b, 0.5)
  assert_true(m.length() == 2)
}

test "match_count" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(5.0, 0.0)]
  let b = [@core.Point2D::new(0.1, 0.0)]
  assert_true(match_count(a, b, 0.5) == 1)
}

test "match_ratio" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0)]
  let b = [@core.Point2D::new(0.1, 0.0), @core.Point2D::new(2.1, 0.0)]
  assert_true((match_ratio(a, b, 0.5) - 1.0).abs() < 0.001)
}

test "unmatched_a" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(5.0, 0.0)]
  let b = [@core.Point2D::new(0.1, 0.0)]
  assert_true(unmatched_a(a, b, 0.5) == 1)
}

test "unmatched_b" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(0.1, 0.0), @core.Point2D::new(5.0, 0.0)]
  assert_true(unmatched_b(a, b, 0.5) == 1)
}