///|
test "convex_clip_by_line" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let line = @core.Line::new(1.0, 0.0, -2.0)
  let result = clip_convex_by_line(poly, line)
  assert_eq(result.length(), 4)
}

///|
test "convex_clip_by_half_plane" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let result = clip_convex_by_half_plane(poly, 0.0, 1.0, -2.0)
  assert_eq(result.length(), 4)
}

///|
test "convex_clip_area" {
  let verts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = convex_area(verts)
  assert_true(@core.approx_eq(area, 16.0, 0.000000000001))
}

///|
test "convex_clip_points_by_line" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(5.0, 1.0),
  ]
  let line = @core.Line::new(1.0, 0.0, -4.0)
  let result = clip_points_by_line(points, line)
  assert_eq(result.length(), 2)
}
