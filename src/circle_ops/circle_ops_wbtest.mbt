///|
test "circle_segment_intersect two points" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 5.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(-10.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
  )
  let pts = circle_segment_intersect(c, seg)
  assert_eq(pts.length(), 2)
  assert_true(@core.approx_eq(pts[0].x, -5.0, 0.000000001))
  assert_true(@core.approx_eq(pts[1].x, 5.0, 0.000000001))
}

///|
test "circle_segment_intersect one point tangent" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 5.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(-10.0, 5.0),
    @core.Point2D::new(10.0, 5.0),
  )
  let pts = circle_segment_intersect(c, seg)
  assert_true(pts.length() <= 2)
  assert_true(pts.length() >= 1)
}

///|
test "circle_segment_intersect no intersection" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 5.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(-10.0, 10.0),
    @core.Point2D::new(10.0, 10.0),
  )
  let pts = circle_segment_intersect(c, seg)
  assert_eq(pts.length(), 0)
}

///|
test "circle_segment_intersect outside segment" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 1.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
  )
  let pts = circle_segment_intersect(c, seg)
  assert_eq(pts.length(), 0)
}

///|
test "circle_circle_intersect two points" {
  let c1 = @core.Circle::new(@core.Point2D::new(-3.0, 0.0), 5.0)
  let c2 = @core.Circle::new(@core.Point2D::new(3.0, 0.0), 5.0)
  let pts = circle_circle_intersect(c1, c2)
  assert_eq(pts.length(), 2)
  assert_true(@core.approx_eq(pts[0].x, 0.0, 0.000000001))
  assert_true(@core.approx_eq(pts[1].x, 0.0, 0.000000001))
}

///|
test "circle_circle_intersect one point tangent" {
  let c1 = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 3.0)
  let c2 = @core.Circle::new(@core.Point2D::new(5.0, 0.0), 2.0)
  let pts = circle_circle_intersect(c1, c2)
  assert_eq(pts.length(), 1)
  assert_true(@core.approx_eq(pts[0].x, 3.0, 0.000000001))
}

///|
test "circle_circle_intersect no intersection" {
  let c1 = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 1.0)
  let c2 = @core.Circle::new(@core.Point2D::new(10.0, 0.0), 1.0)
  let pts = circle_circle_intersect(c1, c2)
  assert_eq(pts.length(), 0)
}

///|
test "circle_circle_intersect concentric" {
  let c1 = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 3.0)
  let c2 = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 5.0)
  let pts = circle_circle_intersect(c1, c2)
  assert_eq(pts.length(), 0)
}

///|
test "circle_line_intersect two points" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 5.0)
  let line = @core.Line::new(0.0, 1.0, 0.0)
  let pts = circle_line_intersect(c, line)
  assert_eq(pts.length(), 2)
}

///|
test "circle_line_intersect tangent" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 5.0)
  let line = @core.Line::new(0.0, 1.0, -5.0)
  let pts = circle_line_intersect(c, line)
  assert_eq(pts.length(), 1)
}

///|
test "circle_line_intersect no intersection" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 1.0)
  let line = @core.Line::new(0.0, 1.0, -10.0)
  let pts = circle_line_intersect(c, line)
  assert_eq(pts.length(), 0)
}

///|
test "circle_polygon_intersect basic" {
  let c = @core.Circle::new(@core.Point2D::new(2.0, 0.0), 1.0)
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let pts = circle_polygon_intersect(c, poly)
  assert_eq(pts.length(), 2)
}

///|
test "circle_polygon_intersect no intersection" {
  let c = @core.Circle::new(@core.Point2D::new(100.0, 100.0), 1.0)
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let pts = circle_polygon_intersect(c, poly)
  assert_eq(pts.length(), 0)
}
