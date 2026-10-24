///|
test "polyline_length" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  assert_true((polyline_length(pts) - 7.0).abs() < 0.001)
}

///|
test "polyline_simplify" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let simplified = polyline_simplify(pts, 0.1)
  assert_true(simplified.length() <= pts.length())
}

///|
test "polyline_subdivide" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  let subdivided = polyline_subdivide(pts, 0, 0.5)
  assert_true(subdivided.length() == 3)
  assert_true((subdivided[1].x() - 2.0).abs() < 0.001)
}

///|
test "polyline_segment_count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  assert_true(polyline_segment_count(pts) == 2)
}

///|
test "polyline_length_empty" {
  let pts : Array[@core.Point2D] = []
  assert_true(polyline_length(pts) == 0.0)
}

///|
test "polyline_simplify less than three points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let simplified = polyline_simplify(pts, 0.1)
  assert_true(simplified.length() == 2)
}

///|
test "polyline_simplify single point" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let simplified = polyline_simplify(pts, 0.1)
  assert_true(simplified.length() == 1)
}

///|
test "polyline_simplify removes collinear points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let simplified = polyline_simplify(pts, 0.01)
  assert_true(simplified.length() == 2)
}

///|
test "polyline_simplify keeps non-collinear points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let simplified = polyline_simplify(pts, 0.01)
  assert_true(simplified.length() == 3)
}

///|
test "polyline_subdivide out of bounds negative" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  let subdivided = polyline_subdivide(pts, -1, 0.5)
  assert_true(subdivided.length() == 2)
}

///|
test "polyline_subdivide out of bounds too large" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  let subdivided = polyline_subdivide(pts, 5, 0.5)
  assert_true(subdivided.length() == 2)
}

///|
test "polyline_subdivide middle segment" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
  ]
  let subdivided = polyline_subdivide(pts, 1, 0.5)
  assert_true(subdivided.length() == 4)
  assert_true((subdivided[2].x() - 6.0).abs() < 0.001)
}

///|
test "polyline_subdivide at t zero" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0)]
  let subdivided = polyline_subdivide(pts, 0, 0.0)
  assert_true(subdivided.length() == 3)
  assert_true((subdivided[1].x() - 0.0).abs() < 0.001)
  assert_true((subdivided[1].y() - 0.0).abs() < 0.001)
}

///|
test "polyline_segment_count empty" {
  let pts : Array[@core.Point2D] = []
  assert_true(polyline_segment_count(pts) == 0)
}

///|
test "polyline_segment_count single point" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  assert_true(polyline_segment_count(pts) == 0)
}

///|
test "polyline_length single point" {
  let pts = [@core.Point2D::new(5.0, 5.0)]
  assert_true(polyline_length(pts) == 0.0)
}

///|
test "polyline_simplify empty" {
  let pts : Array[@core.Point2D] = []
  let simplified = polyline_simplify(pts, 0.1)
  assert_true(simplified.length() == 0)
}
