///|
test "voronoi_3d empty" {
  let v = voronoi_3d([])
  assert_eq(v.cell_count(), 0)
  assert_eq(v.vertex_count(), 0)
}

///|
test "voronoi_3d tetrahedron" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let v = voronoi_3d(pts)
  assert_eq(v.cell_count(), 4)
  assert_true(v.vertex_count() >= 1)
}

///|
test "voronoi_3d five points" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 2.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 2.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  let v = voronoi_3d(pts)
  assert_eq(v.cell_count(), 5)
}

///|
test "voronoi_cell_3d" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let v = voronoi_3d(pts)
  let cell = voronoi_cell_3d(v, 0)
  assert_eq(cell.site_idx, 0)
  assert_true(cell.vertices.length() >= 0)
}

///|
test "voronoi_cell_3d invalid" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let v = voronoi_3d(pts)
  let cell = voronoi_cell_3d(v, 99)
  assert_eq(cell.site_idx, 99)
  assert_eq(cell.vertices.length(), 0)
}

///|
test "voronoi_cell_count" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  assert_eq(voronoi_cell_count(pts), 3)
}

///|
test "voronoi_vertex_count" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let cnt = voronoi_vertex_count(pts)
  assert_true(cnt >= 1)
}

///|
test "dual_delaunay" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let d = dual_delaunay(pts)
  assert_eq(d.vertex_count(), 4)
  assert_true(d.tetrahedron_count() >= 1)
}

///|
test "Voronoi3D::new" {
  let v = Voronoi3D::new()
  assert_eq(v.cell_count(), 0)
  assert_eq(v.vertex_count(), 0)
}
