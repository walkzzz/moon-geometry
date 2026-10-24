///|
test "estimate_mean_curvature flat" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let nms = [
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let h = estimate_mean_curvature(c, nb, nms, @core.Point3D::new(0.0, 0.0, 1.0))
  assert_true(h.abs() < 0.001)
}

///|
test "estimate_gaussian_curvature flat" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(-1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, -1.0, 0.0),
  ]
  let k = estimate_gaussian_curvature(c, nb)
  assert_true(k.abs() < 0.1)
}

///|
test "principal_curvatures" {
  let (k1, k2) = principal_curvatures(1.0, 2.0)
  assert_true((k1 + k2 - 4.0).abs() < 0.001)
  assert_true((k1 * k2 - 1.0).abs() < 0.001)
}

///|
test "estimate_gaussian_curvature few neighbors" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let k = estimate_gaussian_curvature(c, nb)
  assert_true(k.abs() < 0.0001)
}

///|
test "estimate_gaussian_curvature collinear" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(3.0, 0.0, 0.0),
  ]
  let k = estimate_gaussian_curvature(c, nb)
  assert_true(k > 5.0)
}

///|
test "estimate_mean_curvature empty" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let h = estimate_mean_curvature(c, [], [], @core.Point3D::new(0.0, 0.0, 1.0))
  assert_true(h.abs() < 0.0001)
}

///|
test "estimate_mean_curvature mismatched normals" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let nms = [@core.Point3D::new(0.0, 0.0, 1.0)]
  let h = estimate_mean_curvature(c, nb, nms, @core.Point3D::new(0.0, 0.0, 1.0))
  assert_true(h.abs() < 0.0001)
}

///|
test "estimate_mean_curvature coincident neighbor" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  ]
  let nms = [
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let h = estimate_mean_curvature(c, nb, nms, @core.Point3D::new(0.0, 0.0, 1.0))
  assert_true(h.abs() < 0.001)
}

///|
test "principal_curvatures complex" {
  let (k1, k2) = principal_curvatures(2.0, 1.0)
  assert_true((k1 - 1.0).abs() < 0.0001)
  assert_true((k2 - 1.0).abs() < 0.0001)
}
