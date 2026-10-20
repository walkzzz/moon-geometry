test "mesh basic" {
  let m = Mesh::new()
  assert_eq(Mesh::vertex_count(m), 0)
  assert_eq(Mesh::face_count(m), 0)
}

test "mesh add vertex" {
  let m = Mesh::new()
  let i0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let i1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  assert_eq(i0, 0)
  assert_eq(i1, 1)
  assert_eq(Mesh::vertex_count(m), 2)
}

test "mesh add face" {
  let m = Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 1.0, 0.0))
  m.add_face(v0, v1, v2)
  assert_eq(Mesh::face_count(m), 1)
  assert_eq(Mesh::edge_count(m), 3)
}

test "mesh tetrahedron" {
  let m = Mesh::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  assert_eq(Mesh::vertex_count(m), 4)
  assert_eq(Mesh::face_count(m), 4)
}

test "mesh bounding box" {
  let m = Mesh::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 3.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 4.0),
  )
  let (mn, mx) = Mesh::bounding_box(m)
  assert_true((mn.x - 0.0).abs() < 0.0001)
  assert_true((mx.x - 2.0).abs() < 0.0001)
  assert_true((mx.y - 3.0).abs() < 0.0001)
  assert_true((mx.z - 4.0).abs() < 0.0001)
}