test "estimate_mean_curvature flat" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [@core.Point3D::new(1.0, 0.0, 0.0), @core.Point3D::new(0.0, 1.0, 0.0)]
  let nms = [@core.Point3D::new(0.0, 0.0, 1.0), @core.Point3D::new(0.0, 0.0, 1.0)]
  let h = estimate_mean_curvature(c, nb, nms, @core.Point3D::new(0.0, 0.0, 1.0))
  assert_true(h.abs() < 0.001)
}

test "estimate_gaussian_curvature flat" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [@core.Point3D::new(1.0, 0.0, 0.0), @core.Point3D::new(0.0, 1.0, 0.0), @core.Point3D::new(-1.0, 0.0, 0.0), @core.Point3D::new(0.0, -1.0, 0.0)]
  let k = estimate_gaussian_curvature(c, nb)
  assert_true(k.abs() < 0.1)
}

test "principal_curvatures" {
  let (k1, k2) = principal_curvatures(1.0, 2.0)
  assert_true((k1 + k2 - 4.0).abs() < 0.001)
  assert_true((k1 * k2 - 1.0).abs() < 0.001)
}
