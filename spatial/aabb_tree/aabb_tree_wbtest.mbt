///|
test "aabb_tree_build_single" {
  let rects = [@core.Rectangle::new(0.0, 0.0, 1.0, 1.0)]
  let nodes = build_aabb_tree(rects)
  assert_eq(nodes.length(), 1)
  assert_eq(count_leaves(nodes), 1)
}

///|
test "aabb_tree_build_multiple" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 1.0, 1.0),
    @core.Rectangle::new(2.0, 2.0, 3.0, 3.0),
    @core.Rectangle::new(4.0, 0.0, 5.0, 1.0),
    @core.Rectangle::new(0.0, 4.0, 1.0, 5.0),
  ]
  let nodes = build_aabb_tree(rects)
  assert_eq(count_leaves(nodes), 4)
}

///|
test "aabb_tree_query_overlap" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(3.0, 3.0, 5.0, 5.0),
    @core.Rectangle::new(1.0, 1.0, 4.0, 4.0),
  ]
  let nodes = build_aabb_tree(rects)
  let query = @core.Rectangle::new(1.5, 1.5, 2.5, 2.5)
  let result = query_aabb(nodes, query)
  assert_true(result.contains(0))
  assert_true(result.contains(2))
}

///|
test "aabb_tree_query_point" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(1.0, 1.0, 3.0, 3.0),
    @core.Rectangle::new(5.0, 5.0, 6.0, 6.0),
  ]
  let nodes = build_aabb_tree(rects)
  let p = @core.Point2D::new(1.5, 1.5)
  let result = query_point_aabb(nodes, p)
  assert_true(result.contains(0))
  assert_true(result.contains(1))
}

///|
test "aabb_tree_empty" {
  let rects : Array[@core.Rectangle] = []
  let nodes = build_aabb_tree(rects)
  assert_eq(nodes.length(), 0)
  let result = query_aabb(nodes, @core.Rectangle::new(0.0, 0.0, 1.0, 1.0))
  assert_eq(result.length(), 0)
}

///|
test "aabb_tree_query_no_overlap" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 1.0, 1.0),
    @core.Rectangle::new(2.0, 2.0, 3.0, 3.0),
  ]
  let nodes = build_aabb_tree(rects)
  let query = @core.Rectangle::new(10.0, 10.0, 11.0, 11.0)
  let result = query_aabb(nodes, query)
  assert_eq(result.length(), 0)
}

///|
test "aabb_tree_query_point_miss" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 1.0, 1.0),
    @core.Rectangle::new(2.0, 2.0, 3.0, 3.0),
  ]
  let nodes = build_aabb_tree(rects)
  let p = @core.Point2D::new(5.0, 5.0)
  let result = query_point_aabb(nodes, p)
  assert_eq(result.length(), 0)
}

///|
test "aabb_tree_split_y_direction" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 1.0, 4.0),
    @core.Rectangle::new(0.0, 6.0, 1.0, 10.0),
  ]
  let nodes = build_aabb_tree(rects)
  assert_eq(count_leaves(nodes), 2)
}

///|
test "aabb_tree_left_empty_branch" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 10.0, 1.0),
    @core.Rectangle::new(1.0, 0.0, 9.0, 1.0),
  ]
  let nodes = build_aabb_tree(rects)
  assert_eq(count_leaves(nodes), 2)
}

///|
test "aabb_tree_count_leaves_empty" {
  let rects : Array[@core.Rectangle] = []
  let nodes = build_aabb_tree(rects)
  assert_eq(count_leaves(nodes), 0)
}

///|
test "aabb_tree_query_point_empty" {
  let rects : Array[@core.Rectangle] = []
  let nodes = build_aabb_tree(rects)
  let p = @core.Point2D::new(0.0, 0.0)
  let result = query_point_aabb(nodes, p)
  assert_eq(result.length(), 0)
}

///|
test "aabb_tree_build_three" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 1.0, 1.0),
    @core.Rectangle::new(2.0, 0.0, 3.0, 1.0),
    @core.Rectangle::new(4.0, 0.0, 5.0, 1.0),
  ]
  let nodes = build_aabb_tree(rects)
  assert_eq(count_leaves(nodes), 3)
}

///|
test "aabb_tree_query_recursive_invalid_index" {
  // Cover defensive guard `node_idx < 0 || node_idx >= nodes.length()`
  // in query_recursive by passing out-of-range indices directly.
  let rects = [@core.Rectangle::new(0.0, 0.0, 1.0, 1.0)]
  let nodes = build_aabb_tree(rects)
  let result : Array[Int32] = []
  query_recursive(nodes, -1, @core.Rectangle::new(0.0, 0.0, 2.0, 2.0), result)
  assert_eq(result.length(), 0)
  query_recursive(nodes, 100, @core.Rectangle::new(0.0, 0.0, 2.0, 2.0), result)
  assert_eq(result.length(), 0)
}

///|
test "aabb_tree_query_point_recursive_invalid_index" {
  // Cover defensive guard `node_idx < 0 || node_idx >= nodes.length()`
  // in query_point_recursive by passing out-of-range indices directly.
  let rects = [@core.Rectangle::new(0.0, 0.0, 1.0, 1.0)]
  let nodes = build_aabb_tree(rects)
  let result : Array[Int32] = []
  query_point_recursive(nodes, -1, @core.Point2D::new(0.5, 0.5), result)
  assert_eq(result.length(), 0)
  query_point_recursive(nodes, 100, @core.Point2D::new(0.5, 0.5), result)
  assert_eq(result.length(), 0)
}
