///|
test "loop subdivide" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(2.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(1.0, 2.0, 0.0))
  m.add_face(v0, v1, v2)
  let sub = loop_subdivide(m)
  assert_eq(@mesh_data.Mesh::face_count(sub), 4)
  assert_eq(@mesh_data.Mesh::vertex_count(sub), 6)
}

///|
test "edge bisection" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(2.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(1.0, 2.0, 0.0))
  m.add_face(v0, v1, v2)
  let sub = edge_bisection(m)
  assert_eq(@mesh_data.Mesh::face_count(sub), 4)
}

///|
test "catmull clark" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 1.0, 0.0))
  m.add_face(v0, v1, v2)
  let sub = catmull_clark_subdivide(m)
  assert_eq(@mesh_data.Mesh::face_count(sub), 4)
}

///|
test "subdivided face count" {
  let m = @mesh_data.Mesh::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  assert_eq(subdivided_face_count(m), 16)
}

///|
test "subdivided vertex count" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 1.0, 0.0))
  m.add_face(v0, v1, v2)
  let vc = subdivided_vertex_count(m)
  assert_true(vc >= 4)
}
