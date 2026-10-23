///|
test "bspline_basis_degree0" {
  let knots = [0.0, 1.0, 2.0, 3.0]
  assert_true((bspline_basis(0, knots, 0, 0.5) - 1.0).abs() < 0.001)
  assert_true((bspline_basis(0, knots, 0, 1.5) - 0.0).abs() < 0.001)
}

///|
test "bspline_eval" {
  let cps = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 2.0),
  ]
  let knots = uniform_knots(4, 2)
  let pt = bspline_eval(cps, 2, knots, 2.0)
  assert_true(pt.x() >= 0.0)
}

///|
test "uniform_knots" {
  let knots = uniform_knots(4, 2)
  assert_true(knots.length() == 7)
  assert_true((knots[0] - 0.0).abs() < 0.001)
  assert_true((knots[6] - 6.0).abs() < 0.001)
}

///|
test "bspline_points" {
  let cps = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 2.0),
  ]
  let pts = bspline_points(cps, 2, 20)
  assert_true(pts.length() == 20)
}

///|
test "bspline_points_short" {
  let cps = [@core.Point2D::new(0.0, 0.0)]
  let pts = bspline_points(cps, 2, 20)
  assert_true(pts.length() == 0)
}
