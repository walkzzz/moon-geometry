test "octree basic insert" {
  let tree = octree_new(5.0, 5.0, 5.0, 10.0, 4, 5)
  octree_insert(tree, @core.Point3D::new(1.0, 1.0, 1.0))
  octree_insert(tree, @core.Point3D::new(5.0, 5.0, 5.0))
  octree_insert(tree, @core.Point3D::new(9.0, 9.0, 9.0))
  assert_eq(octree_size(tree), 3)
}

test "octree range query" {
  let tree = octree_new(5.0, 5.0, 5.0, 10.0, 2, 5)
  octree_insert(tree, @core.Point3D::new(1.0, 1.0, 1.0))
  octree_insert(tree, @core.Point3D::new(5.0, 5.0, 5.0))
  octree_insert(tree, @core.Point3D::new(9.0, 9.0, 9.0))
  let result = octree_range_query(tree, 0.0, 0.0, 0.0, 6.0, 6.0, 6.0)
  assert_eq(result.length(), 2)
}

test "octree subdivision" {
  let tree = octree_new(5.0, 5.0, 5.0, 10.0, 2, 5)
  octree_insert(tree, @core.Point3D::new(1.0, 1.0, 1.0))
  octree_insert(tree, @core.Point3D::new(2.0, 2.0, 2.0))
  octree_insert(tree, @core.Point3D::new(3.0, 3.0, 3.0))
  assert_eq(octree_size(tree), 3)
}

test "octree empty query" {
  let tree = octree_new(5.0, 5.0, 5.0, 10.0, 4, 5)
  let result = octree_range_query(tree, 0.0, 0.0, 0.0, 10.0, 10.0, 10.0)
  assert_eq(result.length(), 0)
}

test "octree many points" {
  let tree = octree_new(50.0, 50.0, 50.0, 100.0, 4, 8)
  for i in 0..<20 {
    octree_insert(tree, @core.Point3D::new(i.to_double(), i.to_double(), i.to_double()))
  }
  assert_eq(octree_size(tree), 20)
}