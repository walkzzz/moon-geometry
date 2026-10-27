///|
test "bvh_build" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(3.0, 3.0, 5.0, 5.0),
    @core.Rectangle::new(1.0, 1.0, 4.0, 4.0),
    @core.Rectangle::new(6.0, 6.0, 8.0, 8.0),
  ]
  let nodes = build_bvh(rects)
  assert_eq(bvh_count_leaves(nodes), 4)
}

///|
test "bvh_query" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(3.0, 3.0, 5.0, 5.0),
    @core.Rectangle::new(1.0, 1.0, 4.0, 4.0),
  ]
  let nodes = build_bvh(rects)
  let query = @core.Rectangle::new(1.5, 1.5, 2.5, 2.5)
  let result = bvh_query(nodes, query)
  assert_true(result.contains(0))
  assert_true(result.contains(2))
}

///|
test "bvh_query_point" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(1.0, 1.0, 3.0, 3.0),
    @core.Rectangle::new(5.0, 5.0, 6.0, 6.0),
  ]
  let nodes = build_bvh(rects)
  let p = @core.Point2D::new(1.5, 1.5)
  let result = bvh_query_point(nodes, p)
  assert_true(result.contains(0))
  assert_true(result.contains(1))
}

///|
test "bvh_empty" {
  let rects : Array[@core.Rectangle] = []
  let nodes = build_bvh(rects)
  assert_eq(nodes.length(), 0)
}

///|
test "bvh_single" {
  let rects = [@core.Rectangle::new(0.0, 0.0, 1.0, 1.0)]
  let nodes = build_bvh(rects)
  assert_eq(bvh_count_leaves(nodes), 1)
  let p = @core.Point2D::new(0.5, 0.5)
  let result = bvh_query_point(nodes, p)
  assert_eq(result.length(), 1)
}

///|
test "bvh_build descending order" {
  // Rects with decreasing min_x and min_y to cover update branches
  let rects = [
    @core.Rectangle::new(10.0, 10.0, 12.0, 12.0),
    @core.Rectangle::new(5.0, 5.0, 7.0, 7.0),
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
  ]
  let nodes = build_bvh(rects)
  assert_eq(bvh_count_leaves(nodes), 3)
}

///|
test "bvh_build split y axis" {
  // Rects where y range > x range to cover split_y branch
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(1.0, 10.0, 3.0, 12.0),
    @core.Rectangle::new(0.0, 20.0, 2.0, 22.0),
  ]
  let nodes = build_bvh(rects)
  assert_eq(bvh_count_leaves(nodes), 3)
}

///|
test "bvh_build equal centers" {
  // Rects with same center to cover sort_by else branch (ca == cb)
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 4.0, 4.0),
    @core.Rectangle::new(1.0, 1.0, 3.0, 3.0),
    @core.Rectangle::new(0.0, 0.0, 4.0, 4.0),
  ]
  let nodes = build_bvh(rects)
  assert_eq(bvh_count_leaves(nodes), 3)
}

///|
test "bvh_query empty nodes" {
  let rects : Array[@core.Rectangle] = []
  let nodes = build_bvh(rects)
  let query = @core.Rectangle::new(0.0, 0.0, 10.0, 10.0)
  let result = bvh_query(nodes, query)
  assert_eq(result.length(), 0)
}

///|
test "bvh_query_point empty nodes" {
  let rects : Array[@core.Rectangle] = []
  let nodes = build_bvh(rects)
  let p = @core.Point2D::new(0.5, 0.5)
  let result = bvh_query_point(nodes, p)
  assert_eq(result.length(), 0)
}

///|
test "bvh_query no overlap" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(10.0, 10.0, 12.0, 12.0),
  ]
  let nodes = build_bvh(rects)
  let query = @core.Rectangle::new(50.0, 50.0, 60.0, 60.0)
  let result = bvh_query(nodes, query)
  assert_eq(result.length(), 0)
}

///|
test "bvh_query_point outside all" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(10.0, 10.0, 12.0, 12.0),
  ]
  let nodes = build_bvh(rects)
  let p = @core.Point2D::new(50.0, 50.0)
  let result = bvh_query_point(nodes, p)
  assert_eq(result.length(), 0)
}

///|
test "bvh_build four rects mixed" {
  // Mix of rects to cover both split_x and split_y paths
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 1.0, 10.0),
    @core.Rectangle::new(2.0, 0.0, 3.0, 10.0),
    @core.Rectangle::new(0.0, 0.0, 3.0, 1.0),
    @core.Rectangle::new(0.0, 2.0, 3.0, 3.0),
  ]
  let nodes = build_bvh(rects)
  assert_eq(bvh_count_leaves(nodes), 4)
}

///|
test "bvh_query_rec invalid node index" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(3.0, 3.0, 5.0, 5.0),
  ]
  let nodes = build_bvh(rects)
  let result : Array[Int32] = []
  // Call with invalid node_idx (< 0)
  bvh_query_rec(nodes, -1, @core.Rectangle::new(0.0, 0.0, 10.0, 10.0), result)
  assert_eq(result.length(), 0)
  // Call with invalid node_idx (>= nodes.length())
  bvh_query_rec(nodes, 100, @core.Rectangle::new(0.0, 0.0, 10.0, 10.0), result)
  assert_eq(result.length(), 0)
}

///|
test "bvh_point_rec invalid node index" {
  let rects = [
    @core.Rectangle::new(0.0, 0.0, 2.0, 2.0),
    @core.Rectangle::new(3.0, 3.0, 5.0, 5.0),
  ]
  let nodes = build_bvh(rects)
  let p = @core.Point2D::new(1.0, 1.0)
  let result : Array[Int32] = []
  // Call with invalid node_idx (< 0)
  bvh_point_rec(nodes, -1, p, result)
  assert_eq(result.length(), 0)
  // Call with invalid node_idx (>= nodes.length())
  bvh_point_rec(nodes, 100, p, result)
  assert_eq(result.length(), 0)
}
