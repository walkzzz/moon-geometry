///|
test "support_point_set" {
  let points = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let dir = @core.Point2D::new(1.0, 0.0)
  match support_point_set(points, dir) {
    Some(idx) => assert_eq(idx, 1)
    None => assert_true(false)
  }
}

///|
test "support_circle" {
  let center = @core.Point2D::new(1.0, 1.0)
  let dir = @core.Point2D::new(1.0, 0.0)
  let p = support_circle(center, 2.0, dir)
  assert_true(@core.approx_eq(p.x(), 3.0, 0.000000000001))
  assert_true(@core.approx_eq(p.y(), 1.0, 0.000000000001))
}

///|
test "support_value" {
  let points = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(3.0, 4.0)]
  let dir = @core.Point2D::new(1.0, 1.0)
  match support_value(points, dir) {
    Some(v) => assert_true(@core.approx_eq(v, 7.0, 0.000000000001))
    None => assert_true(false)
  }
}

///|
test "support_segment" {
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  )
  let dir = @core.Point2D::new(1.0, 1.0)
  let p = support_segment(seg, dir)
  assert_true(@core.approx_eq(p.x(), 3.0, 0.000000000001))
}

///|
test "support_width" {
  let points = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  let dir = @core.Point2D::new(1.0, 0.0)
  let w = width_in_direction(points, dir)
  assert_true(@core.approx_eq(w, 4.0, 0.000000000001))
}
