///|
test "skip_quadtree basic" {
  let tree = skip_quadtree_new(50.0, 50.0, 100.0, 8)
  skip_quadtree_insert(tree, @core.Point2D::new(10.0, 10.0))
  skip_quadtree_insert(tree, @core.Point2D::new(50.0, 50.0))
  skip_quadtree_insert(tree, @core.Point2D::new(90.0, 90.0))
  assert_eq(skip_quadtree_count(tree), 3)
}

///|
test "skip_quadtree query" {
  let tree = skip_quadtree_new(50.0, 50.0, 100.0, 8)
  skip_quadtree_insert(tree, @core.Point2D::new(10.0, 10.0))
  skip_quadtree_insert(tree, @core.Point2D::new(50.0, 50.0))
  skip_quadtree_insert(tree, @core.Point2D::new(90.0, 90.0))
  let result = skip_quadtree_query(tree, 0.0, 0.0, 60.0, 60.0)
  assert_eq(result.length(), 2)
}

///|
test "skip_quadtree subdivision" {
  let tree = skip_quadtree_new(50.0, 50.0, 100.0, 8)
  for i in 0..<10 {
    skip_quadtree_insert(
      tree,
      @core.Point2D::new(i.to_double() * 10.0, i.to_double() * 10.0),
    )
  }
  assert_eq(skip_quadtree_count(tree), 10)
}

///|
test "skip_quadtree empty query" {
  let tree = skip_quadtree_new(50.0, 50.0, 100.0, 8)
  let result = skip_quadtree_query(tree, 0.0, 0.0, 100.0, 100.0)
  assert_eq(result.length(), 0)
}

///|
test "skip_quadtree many points" {
  let tree = skip_quadtree_new(50.0, 50.0, 100.0, 10)
  for i in 0..<30 {
    skip_quadtree_insert(
      tree,
      @core.Point2D::new(i.to_double() * 3.0, i.to_double() * 3.0),
    )
  }
  assert_eq(skip_quadtree_count(tree), 30)
}

///|
test "skip_quadtree empty tree insert" {
  let tree : SkipQuadtree = { root: None, max_level: 10, }
  skip_quadtree_insert(tree, @core.Point2D::new(1.0, 1.0))
  assert_eq(skip_quadtree_count(tree), 0)
}

///|
test "skip_quadtree empty tree query" {
  let tree : SkipQuadtree = { root: None, max_level: 10, }
  let result = skip_quadtree_query(tree, 0.0, 0.0, 100.0, 100.0)
  assert_eq(result.length(), 0)
}

///|
test "skip_quadtree empty tree count" {
  let tree : SkipQuadtree = { root: None, max_level: 10, }
  assert_eq(skip_quadtree_count(tree), 0)
}

///|
test "skip_quadtree query outside bounds" {
  let tree = skip_quadtree_new(50.0, 50.0, 100.0, 8)
  skip_quadtree_insert(tree, @core.Point2D::new(10.0, 10.0))
  skip_quadtree_insert(tree, @core.Point2D::new(50.0, 50.0))
  // Query completely outside tree bounds
  let result = skip_quadtree_query(tree, 200.0, 200.0, 300.0, 300.0)
  assert_eq(result.length(), 0)
}

///|
test "skip_quadtree query with subdivision" {
  let tree = skip_quadtree_new(50.0, 50.0, 100.0, 8)
  // Insert enough points to trigger subdivision
  for i in 0..<20 {
    skip_quadtree_insert(
      tree,
      @core.Point2D::new(10.0 + i.to_double() * 4.0, 10.0 + i.to_double() * 4.0),
    )
  }
  // Query that overlaps with subdivided children
  let result = skip_quadtree_query(tree, 0.0, 0.0, 100.0, 100.0)
  assert_eq(result.length(), 20)
}

///|
test "skip_quadtree max level reached" {
  let tree = skip_quadtree_new(50.0, 50.0, 100.0, 2)
  // Insert many points at same location to force deep subdivision
  for _ in 0..<20 {
    skip_quadtree_insert(tree, @core.Point2D::new(25.0, 25.0))
  }
  assert_eq(skip_quadtree_count(tree), 20)
}
