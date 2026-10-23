///|
test "estimate_normal planar" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(-1.0, 0.0, 0.0),
  ]
  let n = estimate_normal(c, nb)
  assert_true((n.z - 1.0).abs() < 0.001)
}

///|
test "normalize_normal" {
  let n = normalize_normal(@core.Point3D::new(3.0, 0.0, 0.0))
  assert_true((n.x - 1.0).abs() < 0.001)
}

///|
test "orient_normal" {
  let n = orient_normal(
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, -1.0),
  )
  assert_true(n.z < 0.0)
}
