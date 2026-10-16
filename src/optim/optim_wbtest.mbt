test "smallest enclosing circle single" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  let c = smallest_enclosing_circle(pts)
  assert_true((c.center.x() - 1.0).abs() < 0.001)
  assert_true((c.center.y() - 2.0).abs() < 0.001)
}

test "smallest enclosing circle two" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let c = smallest_enclosing_circle(pts)
  assert_true((c.center.x() - 2.0).abs() < 0.001)
  assert_true((c.radius - 2.0).abs() < 0.001)
}

test "smallest enclosing circle three" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let c = smallest_enclosing_circle(pts)
  assert_true(c.radius > 0.0)
}

test "min area rect" {
  let pts = [
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(3.0, 7.0),
  ]
  let r = min_area_rect(pts)
  assert_true((r.min_x - 1.0).abs() < 0.001)
  assert_true((r.max_x - 5.0).abs() < 0.001)
}

test "centroid" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(0.0, 6.0),
  ]
  let c = centroid(pts)
  assert_true((c.x() - 2.0).abs() < 0.001)
  assert_true((c.y() - 2.0).abs() < 0.001)
}