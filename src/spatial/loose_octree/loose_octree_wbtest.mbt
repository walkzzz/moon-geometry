test "loose_octree basic" {
  let tree = loose_octree_new(50.0, 50.0, 50.0, 100.0, 2.0, 6)
  loose_octree_insert(tree, @core.Point3D::new(10.0, 10.0, 10.0))
  loose_octree_insert(tree, @core.Point3D::new(50.0, 50.0, 50.0))
  loose_octree_insert(tree, @core.Point3D::new(90.0, 90.0, 90.0))
  assert_eq(loose_octree_count(tree), 3)
}

test "loose_octree query" {
  let tree = loose_octree_new(50.0, 50.0, 50.0, 100.0, 2.0, 6)
  loose_octree_insert(tree, @core.Point3D::new(10.0, 10.0, 10.0))
  loose_octree_insert(tree, @core.Point3D::new(50.0, 50.0, 50.0))
  loose_octree_insert(tree, @core.Point3D::new(90.0, 90.0, 90.0))
  let result = loose_octree_query(tree, 0.0, 0.0, 0.0, 60.0, 60.0, 60.0)
  assert_eq(result.length(), 2)
}

test "loose_octree subdivision" {
  let tree = loose_octree_new(50.0, 50.0, 50.0, 100.0, 2.0, 6)
  for i in 0..<12 {
    loose_octree_insert(tree, @core.Point3D::new(i.to_double() * 8.0, i.to_double() * 8.0, i.to_double() * 8.0))
  }
  assert_eq(loose_octree_count(tree), 12)
}

test "loose_octree empty query" {
  let tree = loose_octree_new(50.0, 50.0, 50.0, 100.0, 2.0, 6)
  let result = loose_octree_query(tree, 0.0, 0.0, 0.0, 100.0, 100.0, 100.0)
  assert_eq(result.length(), 0)
}

test "loose_octree many points" {
  let tree = loose_octree_new(50.0, 50.0, 50.0, 100.0, 2.0, 8)
  for i in 0..<25 {
    loose_octree_insert(tree, @core.Point3D::new(i.to_double() * 4.0, i.to_double() * 3.0, i.to_double() * 2.0))
  }
  assert_eq(loose_octree_count(tree), 25)
}