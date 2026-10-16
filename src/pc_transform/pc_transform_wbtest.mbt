test "translate_cloud" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0)]
  let r = translate_cloud(pts, 1.0, 2.0, 3.0)
  assert_true((r[0].x - 1.0).abs() < 0.001)
  assert_true((r[0].y - 2.0).abs() < 0.001)
}

test "scale_cloud" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let r = scale_cloud(pts, 2.0)
  assert_true((r[0].x - 2.0).abs() < 0.001)
}

test "center_cloud" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(2.0, 0.0, 0.0)]
  let r = center_cloud(pts)
  assert_true((r[0].x + 1.0).abs() < 0.001)
  assert_true((r[1].x - 1.0).abs() < 0.001)
}
