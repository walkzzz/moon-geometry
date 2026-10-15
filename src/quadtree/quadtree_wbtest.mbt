test "quadtree_build" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(3.0, 7.0),
    @core.Point2D::new(8.0, 2.0),
  ]
  let bounds = @core.Rectangle::new(0.0, 0.0, 10.0, 10.0)
  let nodes = build_quadtree(points, bounds)
  assert_eq(quadtree_count(nodes), 4)
}

test "quadtree_range_query" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(8.0, 8.0),
    @core.Point2D::new(3.0, 2.0),
  ]
  let bounds = @core.Rectangle::new(0.0, 0.0, 10.0, 10.0)
  let nodes = build_quadtree(points, bounds)
  let rect = @core.Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let result = quadtree_range_query(nodes, rect)
  assert_eq(result.length(), 3)
}

test "quadtree_empty" {
  let points : Array[@core.Point2D] = []
  let bounds = @core.Rectangle::new(0.0, 0.0, 10.0, 10.0)
  let nodes = build_quadtree(points, bounds)
  assert_eq(quadtree_count(nodes), 0)
}

test "quadtree_single" {
  let points = [@core.Point2D::new(5.0, 5.0)]
  let bounds = @core.Rectangle::new(0.0, 0.0, 10.0, 10.0)
  let nodes = build_quadtree(points, bounds)
  assert_eq(quadtree_count(nodes), 1)
  let rect = @core.Rectangle::new(0.0, 0.0, 10.0, 10.0)
  let result = quadtree_range_query(nodes, rect)
  assert_eq(result.length(), 1)
}