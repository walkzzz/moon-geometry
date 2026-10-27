///|
test "extrude polygon quad" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let (v, f) = extrude_polygon(pts, 2.0)
  assert_eq(v.length(), 8)
  assert_eq(f.length(), 12)
}

///|
test "extrude polygon triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let (v, f) = extrude_polygon(pts, 1.0)
  assert_eq(v.length(), 6)
  assert_eq(f.length(), 8)
}

///|
test "extrude profile" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let dir = @core.Point3D::new(0.0, 0.0, 1.0)
  let (v, f) = extrude_profile(pts, dir, 2.0)
  assert_eq(v.length(), 6)
  assert_eq(f.length(), 8)
}
