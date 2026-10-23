///|
test "local_density" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.5, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let d = local_density(pts, @core.Point3D::new(0.0, 0.0, 0.0), 1.0)
  assert_eq(d, 2)
}

///|
test "curvature_feature" {
  let f = curvature_feature([3.0, 1.0, 0.1])
  assert_true(f > 0.0 && f < 1.0)
}

///|
test "planarity_feature" {
  let f = planarity_feature([3.0, 2.0, 0.1])
  assert_true(f > 0.0)
}

///|
test "scattering_feature" {
  let f = scattering_feature([1.0, 1.0, 1.0])
  assert_true((f - 0.333333).abs() < 0.01)
}
