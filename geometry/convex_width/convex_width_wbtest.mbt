///|
test "convex width square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let w = convex_width(poly)
  assert_true((w - 4.0).abs() < 0.01)
}

///|
test "convex max width" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let w = convex_max_width(poly)
  assert_true((w - 6.0).abs() < 0.01)
}

///|
test "convex aspect ratio" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(8.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let r = convex_aspect_ratio(poly)
  assert_true((r - 2.0).abs() < 0.01)
}

///|
test "convex width triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let w = convex_width(poly)
  assert_true(w > 0.0)
}

///|
test "convex width degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let poly = @core.Polygon::new(pts)
  assert_true(convex_width(poly) == 0.0)
}
