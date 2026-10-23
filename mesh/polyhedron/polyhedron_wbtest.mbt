///|
test "polyhedron empty" {
  let p = Polyhedron::new()
  assert_eq(Polyhedron::vertex_count(p), 0)
  assert_eq(Polyhedron::face_count(p), 0)
}

///|
test "polyhedron cube" {
  let c = Polyhedron::cube(0.0, 0.0, 0.0, 1.0, 1.0, 1.0)
  assert_eq(Polyhedron::vertex_count(c), 8)
  assert_eq(Polyhedron::face_count(c), 6)
  assert_eq(Polyhedron::edge_count(c), 12)
}

///|
test "polyhedron cube volume" {
  let c = Polyhedron::cube(0.0, 0.0, 0.0, 2.0, 3.0, 4.0)
  let v = Polyhedron::volume(c)
  assert_true(v.abs() > 0.0)
}

///|
test "polyhedron cube surface area" {
  let c = Polyhedron::cube(0.0, 0.0, 0.0, 1.0, 1.0, 1.0)
  let a = Polyhedron::surface_area(c)
  assert_true((a - 6.0).abs() < 0.001)
}

///|
test "polyhedron tetrahedron" {
  let t = Polyhedron::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  assert_eq(Polyhedron::vertex_count(t), 4)
  assert_eq(Polyhedron::face_count(t), 4)
  assert_eq(Polyhedron::edge_count(t), 6)
}

///|
test "polyhedron tetrahedron volume" {
  let t = Polyhedron::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let v = Polyhedron::volume(t)
  assert_true((v.abs() - 0.16666666666666666).abs() < 0.001)
}

///|
test "polyhedron add vertex face" {
  let p = Polyhedron::new()
  let v0 = p.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = p.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = p.add_vertex(@core.Point3D::new(0.0, 1.0, 0.0))
  p.add_face([v0, v1, v2])
  assert_eq(Polyhedron::vertex_count(p), 3)
  assert_eq(Polyhedron::face_count(p), 1)
  assert_eq(Polyhedron::edge_count(p), 3)
}

///|
test "polyhedron centroid" {
  let c = Polyhedron::cube(0.0, 0.0, 0.0, 2.0, 2.0, 2.0)
  let center = Polyhedron::centroid(c)
  assert_true(center.x.abs() < 0.01 || (center.x - 1.0).abs() < 0.01)
}

///|
test "polyhedron edge count" {
  let t = Polyhedron::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 2.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 2.0),
  )
  assert_eq(Polyhedron::edge_count(t), 6)
}
