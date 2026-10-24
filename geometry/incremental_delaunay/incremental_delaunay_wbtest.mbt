///|
test "incremental delaunay insert" {
  let d = IncrementalDelaunay::new()
  d.insert(@core.Point2D::new(0.0, 0.0))
  d.insert(@core.Point2D::new(1.0, 0.0))
  d.insert(@core.Point2D::new(0.0, 1.0))
  assert_eq(d.triangle_count(), 1)
  d.insert(@core.Point2D::new(1.0, 1.0))
  assert_true(d.triangle_count() >= 2)
}

///|
test "incremental delaunay from points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let d = IncrementalDelaunay::from_points(pts)
  assert_eq(d.vertex_count(), 4)
  assert_true(d.triangle_count() >= 2)
}

///|
test "incremental delaunay remove" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let d = IncrementalDelaunay::from_points(pts)
  assert_eq(d.vertex_count(), 4)
  d.remove(3)
  assert_eq(d.vertex_count(), 3)
}

///|
test "incremental delaunay new empty" {
  let d = IncrementalDelaunay::new()
  assert_eq(d.vertex_count(), 0)
  assert_eq(d.triangle_count(), 0)
}

///|
test "incremental delaunay get vertices" {
  let d = IncrementalDelaunay::new()
  d.insert(@core.Point2D::new(0.0, 0.0))
  d.insert(@core.Point2D::new(1.0, 0.0))
  let vs = d.get_vertices()
  assert_eq(vs.length(), 2)
}

///|
test "incremental delaunay get triangles" {
  let d = IncrementalDelaunay::new()
  d.insert(@core.Point2D::new(0.0, 0.0))
  d.insert(@core.Point2D::new(1.0, 0.0))
  d.insert(@core.Point2D::new(0.0, 1.0))
  let ts = d.get_triangles()
  assert_eq(ts.length(), 1)
}

///|
test "incremental delaunay insert five points" {
  let d = IncrementalDelaunay::new()
  d.insert(@core.Point2D::new(0.0, 0.0))
  d.insert(@core.Point2D::new(2.0, 0.0))
  d.insert(@core.Point2D::new(1.0, 2.0))
  d.insert(@core.Point2D::new(1.0, 1.0))
  d.insert(@core.Point2D::new(3.0, 3.0))
  assert_eq(d.vertex_count(), 5)
  assert_true(d.triangle_count() >= 3)
}

///|
test "incremental delaunay remove invalid index" {
  let d = IncrementalDelaunay::new()
  d.insert(@core.Point2D::new(0.0, 0.0))
  d.insert(@core.Point2D::new(1.0, 0.0))
  d.insert(@core.Point2D::new(0.0, 1.0))
  d.remove(10)
  assert_eq(d.vertex_count(), 3)
}
