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
