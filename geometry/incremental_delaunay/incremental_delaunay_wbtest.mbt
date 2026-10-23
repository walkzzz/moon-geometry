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
