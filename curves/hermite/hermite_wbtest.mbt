///|
test "hermite_eval_endpoints" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(1.0, 1.0)
  let m0 = @core.Point2D::new(1.0, 0.0)
  let m1 = @core.Point2D::new(1.0, 0.0)
  let at0 = hermite_eval(p0, p1, m0, m1, 0.0)
  assert_true((at0.x() - 0.0).abs() < 0.001)
  assert_true((at0.y() - 0.0).abs() < 0.001)
  let at1 = hermite_eval(p0, p1, m0, m1, 1.0)
  assert_true((at1.x() - 1.0).abs() < 0.001)
  assert_true((at1.y() - 1.0).abs() < 0.001)
}

///|
test "hermite_points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let mags = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, -2.0),
    @core.Point2D::new(2.0, -2.0),
  ]
  let result = hermite_points(pts, mags, 10)
  assert_true(result.length() > 0)
}

///|
test "hermite_derivative" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(1.0, 1.0)
  let m0 = @core.Point2D::new(1.0, 0.0)
  let m1 = @core.Point2D::new(1.0, 0.0)
  let d = hermite_derivative(p0, p1, m0, m1, 0.0)
  assert_true((d.x() - 1.0).abs() < 0.001)
  assert_true((d.y() - 0.0).abs() < 0.001)
}

///|
test "cardinal_tangents" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let tans = cardinal_tangents(pts, 0.0)
  assert_true(tans.length() == 3)
}

///|
test "hermite_points_short" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let mags = [@core.Point2D::new(1.0, 0.0)]
  let result = hermite_points(pts, mags, 10)
  assert_true(result.length() == 0)
}
