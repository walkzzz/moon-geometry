///|
test "convex centroid" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 6.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = convex_centroid(poly)
  assert_true((c.x() - 3.0).abs() < 0.01)
  assert_true((c.y() - 2.0).abs() < 0.01)
}

///|
test "chebyshev center" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = chebyshev_center(poly)
  assert_true((c.x() - 2.0).abs() < 0.1)
}

///|
test "bbox center" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = bbox_center(poly)
  assert_true((c.x() - 3.0).abs() < 0.01)
  assert_true((c.y() - 2.0).abs() < 0.01)
}

///|
test "vertex center" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = vertex_center(poly)
  assert_true((c.x() - 2.0).abs() < 0.01)
}

///|
test "inradius" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let r = inradius(poly)
  assert_true(r > 0.0)
}
