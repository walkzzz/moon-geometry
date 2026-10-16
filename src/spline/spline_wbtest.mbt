test "spline_length" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let len = spline_length(pts)
  assert_true((len - 7.0).abs() < 0.001)
}

test "spline_curvature" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let k = spline_curvature(pts, 1)
  assert_true(k > 0.0)
}

test "spline_curvature_profile" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let profile = spline_curvature_profile(pts)
  assert_true(profile.length() == 2)
}

test "spline_total_curvature" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let total = spline_total_curvature(pts)
  assert_true(total > 0.0)
}

test "spline_max_curvature_point" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let idx = spline_max_curvature_point(pts)
  assert_true(idx.is_some())
}