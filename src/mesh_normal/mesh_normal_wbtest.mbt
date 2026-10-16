test "face normal" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 1.0, 0.0))
  m.add_face(v0, v1, v2)
  let n = face_normal(m, 0)
  assert_true((n.z - 1.0).abs() < 0.001)
}

test "normalize" {
  let v = @core.Point3D::new(3.0, 0.0, 0.0)
  let n = normalize(v)
  assert_true((n.x - 1.0).abs() < 0.001)
}

test "vertex normal" {
  let m = @mesh_data.Mesh::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let n = vertex_normal(m, 0)
  let len = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((len - 1.0).abs() < 0.001 || len.abs() < 0.001)
}

test "all face normals" {
  let m = @mesh_data.Mesh::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let normals = all_face_normals(m)
  assert_eq(normals.length(), 4)
}

test "face area" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(4.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 4.0, 0.0))
  m.add_face(v0, v1, v2)
  let area = face_area(m, 0)
  assert_true((area - 8.0).abs() < 0.001)
}