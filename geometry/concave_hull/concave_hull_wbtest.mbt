test "concave hull basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let hull = concave_hull(pts, 3)
  assert_true(hull.length() >= 3)
}

test "concave hull default" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let hull = concave_hull_default(pts)
  assert_true(hull.length() >= 3)
}

test "concave hull small" {
  let pts = [@core.Point2D::new(1.0, 1.0)]
  let hull = concave_hull(pts, 3)
  assert_eq(hull.length(), 1)
}

test "concave hull triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let hull = concave_hull(pts, 3)
  assert_eq(hull.length(), 3)
}

test "concave hull with interior" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(8.0, 8.0),
    @core.Point2D::new(0.0, 8.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let hull = concave_hull(pts, 3)
  assert_true(hull.length() >= 3)
}