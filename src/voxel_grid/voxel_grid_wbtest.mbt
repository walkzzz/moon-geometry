test "VoxelGrid::new" {
  let g = VoxelGrid::new(@core.Point3D::new(0.0, 0.0, 0.0), 1.0, 10, 10, 10)
  assert_eq(g.nx, 10)
  assert_eq(voxel_count_occupied(g), 0)
}

test "voxel_set and occupied" {
  let g = VoxelGrid::new(@core.Point3D::new(0.0, 0.0, 0.0), 1.0, 10, 10, 10)
  let g2 = voxel_set(g, @core.Point3D::new(0.5, 0.5, 0.5))
  assert_true(voxel_occupied(g2, @core.Point3D::new(0.5, 0.5, 0.5)))
  assert_eq(voxel_count_occupied(g2), 1)
}

test "voxel_index out of bounds" {
  let g = VoxelGrid::new(@core.Point3D::new(0.0, 0.0, 0.0), 1.0, 5, 5, 5)
  assert_eq(voxel_index(g, @core.Point3D::new(10.0, 10.0, 10.0)), -1)
}
