///|
test "segments_cross" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(4.0, 4.0)
  let p3 = @core.Point2D::new(0.0, 4.0)
  let p4 = @core.Point2D::new(4.0, 0.0)
  assert_true(segments_cross(p1, p2, p3, p4))
}

///|
test "segments_no_cross" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(1.0, 1.0)
  let p3 = @core.Point2D::new(3.0, 3.0)
  let p4 = @core.Point2D::new(4.0, 4.0)
  assert_false(segments_cross(p1, p2, p3, p4))
}

///|
test "curve_self_intersect" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(curve_self_intersect(pts))
}

///|
test "curve_self_intersect_count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(curve_self_intersect_count(pts) == 1)
}

///|
test "curves_intersect" {
  let c1 = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0)]
  let c2 = [@core.Point2D::new(0.0, 4.0), @core.Point2D::new(4.0, 0.0)]
  assert_true(curves_intersect(c1, c2))
}
