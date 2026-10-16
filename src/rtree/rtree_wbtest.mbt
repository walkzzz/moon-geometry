test "rtree basic insert and query" {
  let tree = rtree_new(8)
  rtree_insert(tree, @core.Point2D::new(1.0, 1.0))
  rtree_insert(tree, @core.Point2D::new(5.0, 5.0))
  rtree_insert(tree, @core.Point2D::new(10.0, 10.0))
  assert_eq(rtree_size(tree), 3)
}

test "rtree range query" {
  let tree = rtree_new(8)
  rtree_insert(tree, @core.Point2D::new(1.0, 1.0))
  rtree_insert(tree, @core.Point2D::new(5.0, 5.0))
  rtree_insert(tree, @core.Point2D::new(10.0, 10.0))
  let result = rtree_range_query(tree, 0.0, 0.0, 6.0, 6.0)
  assert_eq(result.length(), 2)
}

test "rtree empty query" {
  let tree = rtree_new(8)
  let result = rtree_range_query(tree, 0.0, 0.0, 10.0, 10.0)
  assert_eq(result.length(), 0)
}

test "rtree get all" {
  let tree = rtree_new(8)
  rtree_insert(tree, @core.Point2D::new(1.0, 1.0))
  rtree_insert(tree, @core.Point2D::new(5.0, 5.0))
  let all = rtree_get_all(tree)
  assert_eq(all.length(), 2)
}

test "rtree size empty" {
  let tree = rtree_new(8)
  assert_eq(rtree_size(tree), 0)
}