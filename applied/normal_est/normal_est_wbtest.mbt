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

///|
test "estimate_normal empty neighbors" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb : Array[@core.Point3D] = []
  let n = estimate_normal(c, nb)
  assert_true((n.z - 1.0).abs() < 0.000000001)
}

///|
test "estimate_normal coincident neighbors" {
  let c = @core.Point3D::new(1.0, 2.0, 3.0)
  let nb = [
    @core.Point3D::new(1.0, 2.0, 3.0),
    @core.Point3D::new(1.0, 2.0, 3.0),
  ]
  let n = estimate_normal(c, nb)
  assert_true((n.z - 1.0).abs() < 0.000000001)
}

///|
test "estimate_normal y axis min" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(10.0, 0.0, 0.0),
    @core.Point3D::new(-10.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 10.0),
    @core.Point3D::new(0.0, 0.0, -10.0),
  ]
  let n = estimate_normal(c, nb)
  assert_true((n.y - 1.0).abs() < 0.000000001)
}

///|
test "estimate_normal x axis min" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(0.0, 10.0, 0.0),
    @core.Point3D::new(0.0, -10.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 10.0),
    @core.Point3D::new(0.0, 0.0, -10.0),
  ]
  let n = estimate_normal(c, nb)
  assert_true((n.x - 1.0).abs() < 0.000000001)
}

///|
test "normalize_normal zero vector" {
  let n = normalize_normal(@core.Point3D::new(0.0, 0.0, 0.0))
  assert_true((n.z - 1.0).abs() < 0.000000001)
}

///|
test "normalize_normal unit already" {
  let n = normalize_normal(@core.Point3D::new(0.0, 0.0, 1.0))
  assert_true((n.z - 1.0).abs() < 0.000000001)
}

///|
test "orient_normal same direction" {
  let n = orient_normal(
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  assert_true((n.z - 1.0).abs() < 0.000000001)
}
