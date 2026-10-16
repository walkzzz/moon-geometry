test "DCEL basic" {
  let d = DCEL::new()
  assert_eq(DCEL::vertex_count(d), 0)
  assert_eq(DCEL::edge_count(d), 0)
  assert_eq(DCEL::face_count(d), 0)
}

test "DCEL add vertex" {
  let d = DCEL::new()
  let i0 = d.add_vertex(@core.Point2D::new(0.0, 0.0))
  let i1 = d.add_vertex(@core.Point2D::new(1.0, 0.0))
  let i2 = d.add_vertex(@core.Point2D::new(0.0, 1.0))
  assert_eq(i0, 0)
  assert_eq(i1, 1)
  assert_eq(i2, 2)
  assert_eq(DCEL::vertex_count(d), 3)
}

test "DCEL add edge" {
  let d = DCEL::new()
  let v0 = d.add_vertex(@core.Point2D::new(0.0, 0.0))
  let v1 = d.add_vertex(@core.Point2D::new(1.0, 0.0))
  let e = d.add_edge(v0, v1)
  assert_eq(e, 0)
  assert_eq(DCEL::edge_count(d), 2)
  assert_eq(d.half_edges[0].twin, 1)
  assert_eq(d.half_edges[1].twin, 0)
}

test "DCEL from polygon" {
  let d = DCEL::new()
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let d2 = DCEL::from_polygon(d, poly)
  assert_eq(DCEL::vertex_count(d2), 4)
  assert_eq(DCEL::edge_count(d2), 8)
  assert_eq(DCEL::face_count(d2), 1)
}

test "DCEL trace face" {
  let d = DCEL::new()
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let poly = @core.Polygon::new(pts)
  let d2 = DCEL::from_polygon(d, poly)
  let boundary = DCEL::trace_face(d2, 0)
  assert_eq(boundary.length(), 4)
}