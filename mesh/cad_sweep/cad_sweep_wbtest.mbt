///|
test "sweep profile" {
  let profile = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let path = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let (v, f) = sweep_profile(profile, path)
  assert_eq(v.length(), 4)
  assert_eq(f.length(), 4)
}

///|
test "sweep profile longer path" {
  let profile = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let path = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 2.0),
  ]
  let (v, f) = sweep_profile(profile, path)
  assert_eq(v.length(), 6)
  assert_eq(f.length(), 8)
}

///|
test "revolve profile" {
  let profile = [@core.Point2D::new(1.0, 0.0), @core.Point2D::new(2.0, 0.0)]
  let axis = @core.Point3D::new(0.0, 0.0, 1.0)
  let (v, f) = revolve_profile(profile, axis, 2.0 * @math.PI)
  assert_eq(v.length(), 34)
  assert_eq(f.length(), 64)
}
