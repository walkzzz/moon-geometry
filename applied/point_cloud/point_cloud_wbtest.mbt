///|
test "point_cloud_centroid" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 4.0, 6.0),
  ]
  let c = point_cloud_centroid(pts)
  assert_true((c.x - 1.0).abs() < 0.0001)
  assert_true((c.y - 2.0).abs() < 0.0001)
  assert_true((c.z - 3.0).abs() < 0.0001)
}

///|
test "point_cloud_aabb" {
  let pts = [
    @core.Point3D::new(1.0, 2.0, 3.0),
    @core.Point3D::new(-1.0, 5.0, 0.0),
  ]
  let (lo, hi) = point_cloud_aabb(pts)
  assert_true((lo.x - -1.0).abs() < 0.0001)
  assert_true((hi.x - 1.0).abs() < 0.0001)
  assert_true((hi.y - 5.0).abs() < 0.0001)
}

///|
test "voxel_downsample" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.1, 0.1, 0.1),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  let result = voxel_downsample(pts, 0.5)
  assert_true(result.length() == 2)
}

///|
test "avg_nearest_neighbor_dist" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  ]
  let d = avg_nearest_neighbor_dist(pts)
  assert_true((d - 1.0).abs() < 0.0001)
}

///|
test "point_cloud_size" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  assert_eq(point_cloud_size(pts), 2)
}

///|
test "point_cloud_centroid empty" {
  let c = point_cloud_centroid([])
  assert_true(c.x.abs() < 0.0001)
  assert_true(c.y.abs() < 0.0001)
  assert_true(c.z.abs() < 0.0001)
}

///|
test "point_cloud_centroid single" {
  let c = point_cloud_centroid([@core.Point3D::new(3.0, 5.0, 7.0)])
  assert_true((c.x - 3.0).abs() < 0.0001)
  assert_true((c.y - 5.0).abs() < 0.0001)
  assert_true((c.z - 7.0).abs() < 0.0001)
}

///|
test "point_cloud_centroid negative" {
  let pts = [
    @core.Point3D::new(-2.0, -4.0, -6.0),
    @core.Point3D::new(2.0, 4.0, 6.0),
  ]
  let c = point_cloud_centroid(pts)
  assert_true(c.x.abs() < 0.0001)
  assert_true(c.y.abs() < 0.0001)
  assert_true(c.z.abs() < 0.0001)
}

///|
test "point_cloud_aabb empty" {
  let (lo, hi) = point_cloud_aabb([])
  assert_true(lo.x.abs() < 0.0001)
  assert_true(hi.x.abs() < 0.0001)
}

///|
test "point_cloud_aabb single" {
  let (lo, hi) = point_cloud_aabb([@core.Point3D::new(3.0, 5.0, 7.0)])
  assert_true((lo.x - 3.0).abs() < 0.0001)
  assert_true((hi.x - 3.0).abs() < 0.0001)
  assert_true((lo.y - 5.0).abs() < 0.0001)
  assert_true((hi.z - 7.0).abs() < 0.0001)
}

///|
test "point_cloud_aabb negative" {
  let pts = [
    @core.Point3D::new(-5.0, -10.0, -15.0),
    @core.Point3D::new(5.0, 10.0, 15.0),
  ]
  let (lo, hi) = point_cloud_aabb(pts)
  assert_true((lo.x - -5.0).abs() < 0.0001)
  assert_true((hi.x - 5.0).abs() < 0.0001)
  assert_true((lo.z - -15.0).abs() < 0.0001)
}

///|
test "voxel_downsample empty" {
  let result = voxel_downsample([], 1.0)
  assert_eq(result.length(), 0)
}

///|
test "voxel_downsample zero voxel size" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  let result = voxel_downsample(pts, 0.0)
  assert_eq(result.length(), 2)
}

///|
test "voxel_downsample negative voxel size" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  let result = voxel_downsample(pts, -1.0)
  assert_eq(result.length(), 2)
}

///|
test "voxel_downsample single" {
  let result = voxel_downsample([@core.Point3D::new(1.0, 2.0, 3.0)], 0.5)
  assert_eq(result.length(), 1)
}

///|
test "voxel_downsample large voxel" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.1, 0.1, 0.1),
    @core.Point3D::new(0.2, 0.2, 0.2),
  ]
  let result = voxel_downsample(pts, 10.0)
  assert_eq(result.length(), 1)
}

///|
test "avg_nearest_neighbor_dist empty" {
  let d = avg_nearest_neighbor_dist([])
  assert_true(d.abs() < 0.0001)
}

///|
test "avg_nearest_neighbor_dist single" {
  let d = avg_nearest_neighbor_dist([@core.Point3D::new(1.0, 2.0, 3.0)])
  assert_true(d.abs() < 0.0001)
}

///|
test "avg_nearest_neighbor_dist three" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let d = avg_nearest_neighbor_dist(pts)
  assert_true(d > 0.0)
  assert_true((d - 1.0).abs() < 0.001)
}

///|
test "point_cloud_size empty" {
  assert_eq(point_cloud_size([]), 0)
}

///|
test "point_cloud_size single" {
  assert_eq(point_cloud_size([@core.Point3D::new(1.0, 2.0, 3.0)]), 1)
}
