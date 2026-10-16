test "visibility_graph no obstacles" {
  let obstacles : Array[Array[@core.Point2D]] = []
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let adj = build_visibility_graph(obstacles, start, goal)
  assert_eq(adj.length(), 2)
  assert_eq(adj[0].length(), 1)
}

test "visibility_vertices basic" {
  let obstacles : Array[Array[@core.Point2D]] = [[
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(7.0, 3.0),
    @core.Point2D::new(5.0, 7.0),
  ]]
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let verts = visibility_vertices(obstacles, start, goal)
  assert_eq(verts.length(), 5)
}

test "visibility_edge_count no obstacles" {
  let obstacles : Array[Array[@core.Point2D]] = []
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let count = visibility_edge_count(obstacles, start, goal)
  assert_eq(count, 1)
}

test "visibility_graph with obstacle" {
  let obstacles : Array[Array[@core.Point2D]] = [[
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 6.0),
  ]]
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let adj = build_visibility_graph(obstacles, start, goal)
  assert_true(adj.length() == 6)
}

test "visibility_edge_count with obstacle" {
  let obstacles : Array[Array[@core.Point2D]] = [[
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 6.0),
  ]]
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let count = visibility_edge_count(obstacles, start, goal)
  assert_true(count >= 1)
}