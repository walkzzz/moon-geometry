test "point_cloud_centroid" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(2.0, 4.0, 6.0)]
  let c = point_cloud_centroid(pts)
  assert_true((c.x - 1.0).abs() < 0.0001)
  assert_true((c.y - 2.0).abs() < 0.0001)
  assert_true((c.z - 3.0).abs() < 0.0001)
}

test "point_cloud_aabb" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0), @core.Point3D::new(-1.0, 5.0, 0.0)]
  let (lo, hi) = point_cloud_aabb(pts)
  assert_true((lo.x - (-1.0)).abs() < 0.0001)
  assert_true((hi.x - 1.0).abs() < 0.0001)
  assert_true((hi.y - 5.0).abs() < 0.0001)
}

test "voxel_downsample" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.1, 0.1, 0.1),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  let result = voxel_downsample(pts, 0.5)
  assert_true(result.length() == 2)
}

test "avg_nearest_neighbor_dist" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(1.0, 0.0, 0.0)]
  let d = avg_nearest_neighbor_dist(pts)
  assert_true((d - 1.0).abs() < 0.0001)
}

test "point_cloud_size" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(1.0, 1.0, 1.0)]
  assert_eq(point_cloud_size(pts), 2)
}
