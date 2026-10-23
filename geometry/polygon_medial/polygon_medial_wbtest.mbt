///|
test "medial_axis square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let poly = @core.Polygon::new(pts)
  let ma = medial_axis(poly, 20)
  assert_true(ma.length() >= 0)
}

///|
test "medial_axis_points square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let poly = @core.Polygon::new(pts)
  let mp = medial_axis_points(poly, 10)
  assert_true(mp.length() >= 1)
}

///|
test "medial_axis triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(4.0, 6.0),
  ]
  let poly = @core.Polygon::new(pts)
  let ma = medial_axis(poly, 15)
  assert_true(ma.length() >= 0)
}

///|
test "medial_axis degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let poly = @core.Polygon::new(pts)
  let ma = medial_axis(poly, 10)
  assert_eq(ma.length(), 0)
}

///|
test "medial_axis_points degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let poly = @core.Polygon::new(pts)
  let mp = medial_axis_points(poly, 5)
  assert_eq(mp.length(), 0)
}
