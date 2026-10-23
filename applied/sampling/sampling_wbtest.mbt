///|
test "grid sample" {
  let pts = grid_sample(0.0, 4.0, 0.0, 4.0, 2, 2)
  assert_eq(pts.length(), 4)
}

///|
test "circle sample" {
  let pts = circle_sample(@core.Point2D::new(0.0, 0.0), 1.0, 8)
  assert_eq(pts.length(), 8)
}

///|
test "circle interior sample" {
  let pts = circle_interior_sample(@core.Point2D::new(0.0, 0.0), 2.0, 10)
  assert_eq(pts.length(), 10)
  for p in pts {
    assert_true(p.x() * p.x() + p.y() * p.y() <= 4.001)
  }
}

///|
test "segment sample" {
  let pts = segment_sample(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    5,
  )
  assert_eq(pts.length(), 5)
  assert_true((pts[0].x() - 0.0).abs() < 0.001)
  assert_true((pts[4].x() - 4.0).abs() < 0.001)
}

///|
test "halton sample" {
  let pts = halton_sample(2, 3, 10)
  assert_eq(pts.length(), 10)
  for p in pts {
    assert_true(p.x() >= 0.0 && p.x() < 1.0)
    assert_true(p.y() >= 0.0 && p.y() < 1.0)
  }
}
