///|
test "curvature_at" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(1.0, 0.0)
  let p3 = @core.Point2D::new(1.0, 1.0)
  let k = curvature_at(p1, p2, p3)
  assert_true(k > 0.0)
}

///|
test "curvature_signed" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(1.41421356, 1.41421356)
  let p3 = @core.Point2D::new(0.0, 2.82842712)
  let k = curvature_signed(p1, p2, p3)
  assert_true(k > 0.0)
}

///|
test "curvature_profile" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let profile = curvature_profile(pts)
  assert_true(profile.length() == 2)
}

///|
test "curvature_radius" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(1.0, 0.0)
  let p3 = @core.Point2D::new(1.0, 1.0)
  let r = curvature_radius(p1, p2, p3)
  assert_true(r > 0.0)
}

///|
test "curvature_total" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let total = curvature_total(pts)
  assert_true(total > 0.0)
}
