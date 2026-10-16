test "statistical_filter" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(1.0, 0.0, 0.0), @core.Point3D::new(0.0, 1.0, 0.0), @core.Point3D::new(100.0, 100.0, 100.0)]
  let kept = statistical_filter(pts, 2, 50.0)
  assert_true(kept.length() == 3)
}

test "radius_filter" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(0.5, 0.0, 0.0), @core.Point3D::new(0.0, 0.5, 0.0), @core.Point3D::new(50.0, 50.0, 50.0)]
  let kept = radius_filter(pts, 2.0, 1)
  assert_true(kept.length() == 3)
}

test "removed_count" {
  assert_eq(removed_count(10, 7), 3)
}
