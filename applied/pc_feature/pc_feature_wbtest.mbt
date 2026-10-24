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

///|
test "curvature_feature too few eigenvalues" {
  assert_eq(curvature_feature([1.0, 2.0]), 0.0)
  assert_eq(curvature_feature([]), 0.0)
}

///|
test "curvature_feature zero sum" {
  assert_eq(curvature_feature([1.0, 1.0, -2.0]), 0.0)
}

///|
test "planarity_feature too few eigenvalues" {
  assert_eq(planarity_feature([1.0]), 0.0)
  assert_eq(planarity_feature([]), 0.0)
}

///|
test "planarity_feature zero sum" {
  assert_eq(planarity_feature([2.0, -1.0, -1.0]), 0.0)
}

///|
test "scattering_feature too few eigenvalues" {
  assert_eq(scattering_feature([1.0, 2.0]), 0.0)
  assert_eq(scattering_feature([]), 0.0)
}

///|
test "scattering_feature zero sum" {
  assert_eq(scattering_feature([1.0, 1.0, -2.0]), 0.0)
}

///|
test "local_density empty points" {
  let d = local_density([], @core.Point3D::new(0.0, 0.0, 0.0), 1.0)
  assert_eq(d, 0)
}

///|
test "local_density zero radius" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0)]
  let d = local_density(pts, @core.Point3D::new(0.0, 0.0, 0.0), 0.0)
  assert_eq(d, 0)
}

///|
test "curvature_feature exact value" {
  // l3 / (l1+l2+l3) = 1 / (1+2+1) = 0.25
  let f = curvature_feature([1.0, 2.0, 1.0])
  assert_true((f - 0.25).abs() < 0.001)
}

///|
test "planarity_feature exact value" {
  // (l2 - l3) / sum = (2 - 1) / (1+2+1) = 0.25
  let f = planarity_feature([1.0, 2.0, 1.0])
  assert_true((f - 0.25).abs() < 0.001)
}
