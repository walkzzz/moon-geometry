///|
test "equilateral triangle quality" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.5, 0.8660254037844386, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true((q.aspect_ratio - 2.0).abs() < 0.01)
  assert_true((q.edge_ratio - 1.0).abs() < 0.01)
  assert_true((q.min_angle - 1.0471975511965976).abs() < 0.01)
}

///|
test "degenerate triangle" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(2.0, 0.0, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.aspect_ratio > 100.0)
}

///|
test "right triangle quality" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(3.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.0, 4.0, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.edge_ratio > 1.0)
  assert_true(q.max_angle > q.min_angle)
}

///|
test "mesh average quality" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (1, 3, 2)]
  let q = mesh_average_quality(verts, faces)
  assert_true(q.aspect_ratio > 0.0)
}

///|
test "count degenerate" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 1, 3)]
  let count = count_degenerate(verts, faces, 0.0001)
  assert_eq(count, 1)
}

///|
test "isoceles triangle" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(2.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(1.0, 1.0, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.min_angle > 0.0)
  assert_true(q.max_angle < 3.14159265358979323846)
}

///|
test "thin sliver" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.5, 0.01, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.aspect_ratio > 10.0)
}

///|
test "area ratio equilateral" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.5, 0.8660254037844386, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true((q.area_ratio - 1.0).abs() < 0.01)
}

///|
test "empty mesh quality" {
  let q = mesh_average_quality([], [])
  assert_eq(q.aspect_ratio, 0.0)
}
