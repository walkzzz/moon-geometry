///|
test "planar graph basic" {
  let g = PlanarGraph::new()
  assert_eq(PlanarGraph::vertex_count(g), 0)
  assert_eq(PlanarGraph::edge_count(g), 0)
}

///|
test "planar graph add vertex and edge" {
  let g = PlanarGraph::new()
  let v0 = g.add_vertex(@core.Point2D::new(0.0, 0.0))
  let v1 = g.add_vertex(@core.Point2D::new(1.0, 0.0))
  let v2 = g.add_vertex(@core.Point2D::new(0.0, 1.0))
  g.add_edge(v0, v1)
  g.add_edge(v1, v2)
  g.add_edge(v0, v2)
  assert_eq(PlanarGraph::vertex_count(g), 3)
  assert_eq(PlanarGraph::edge_count(g), 3)
}

///|
test "planar graph is planar" {
  let g = PlanarGraph::new()
  for i in 0..<4 {
    ignore(g.add_vertex(@core.Point2D::new(i.to_double(), 0.0)))
  }
  for i in 0..<4 {
    g.add_edge(i, (i + 1) % 4)
  }
  assert_true(PlanarGraph::is_planar(g))
}

///|
test "planar graph connected" {
  let g = PlanarGraph::new()
  let v0 = g.add_vertex(@core.Point2D::new(0.0, 0.0))
  let v1 = g.add_vertex(@core.Point2D::new(1.0, 0.0))
  let v2 = g.add_vertex(@core.Point2D::new(2.0, 0.0))
  g.add_edge(v0, v1)
  g.add_edge(v1, v2)
  assert_true(PlanarGraph::is_connected(g))
}

///|
test "planar graph from polygon" {
  let g = PlanarGraph::new()
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let g2 = PlanarGraph::from_polygon(g, poly)
  assert_eq(PlanarGraph::vertex_count(g2), 4)
  assert_eq(PlanarGraph::edge_count(g2), 4)
  assert_eq(PlanarGraph::face_count(g2), 2)
}
