///|
test "polar_dual_point" {
  let p = @core.Point2D::new(2.0, 0.0)
  let d = polar_dual_point(p)
  assert_true(@core.approx_eq(d.x(), 0.5, 0.000000000001))
  assert_true(@core.approx_eq(d.y(), 0.0, 0.000000000001))
}

///|
test "polar_dual_polygon" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(0.0, -2.0),
  ])
  let result = polar_dual(poly)
  assert_eq(result.length(), 4)
}

///|
test "polar_dual_origin_inside" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(0.0, -2.0),
  ])
  assert_true(origin_inside(poly))
}

///|
test "polar_dual_origin_outside" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(7.0, 5.0),
    @core.Point2D::new(7.0, 7.0),
    @core.Point2D::new(5.0, 7.0),
  ])
  assert_false(origin_inside(poly))
}

///|
test "polar_dual_dual_area" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(0.0, -2.0),
  ])
  let da = dual_area(poly)
  assert_true(da > 0.0)
}
