///|
test "range_tree_build" {
  let points = [
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(5.0, 1.0),
  ]
  let tree = build_range_tree(points)
  assert_eq(range_tree_size(tree), 4)
}

///|
test "range_tree_query" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(8.0, 8.0),
    @core.Point2D::new(3.0, 2.0),
  ]
  let tree = build_range_tree(points)
  let result = range_query(tree, 0.0, 4.0, 0.0, 4.0)
  assert_eq(result.length(), 3)
}

///|
test "range_tree_query_x" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(8.0, 8.0),
  ]
  let tree = build_range_tree(points)
  let result = range_query_x(tree, 0.0, 3.0)
  assert_eq(result.length(), 2)
}

///|
test "range_tree_query_y" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(8.0, 8.0),
  ]
  let tree = build_range_tree(points)
  let result = range_query_y(tree, 0.0, 4.0)
  assert_eq(result.length(), 2)
}

///|
test "range_tree_empty" {
  let points : Array[@core.Point2D] = []
  let tree = build_range_tree(points)
  assert_eq(range_tree_size(tree), 0)
}
