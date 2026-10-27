///|
test "face normal" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 1.0, 0.0))
  m.add_face(v0, v1, v2)
  let n = face_normal(m, 0)
  assert_true((n.z - 1.0).abs() < 0.001)
}

///|
test "normalize" {
  let v = @core.Point3D::new(3.0, 0.0, 0.0)
  let n = normalize(v)
  assert_true((n.x - 1.0).abs() < 0.001)
}

///|
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

///|
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

///|
test "face area" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(4.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 4.0, 0.0))
  m.add_face(v0, v1, v2)
  let area = face_area(m, 0)
  assert_true((area - 8.0).abs() < 0.001)
}

///|
test "face normal normalized" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(2.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 2.0, 0.0))
  m.add_face(v0, v1, v2)
  let n = face_normal_normalized(m, 0)
  let mag = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((mag - 1.0).abs() < 0.001)
  assert_true((n.z - 1.0).abs() < 0.001)
}

///|
test "all vertex normals" {
  let m = @mesh_data.Mesh::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let normals = all_vertex_normals(m)
  assert_eq(normals.length(), 4)
}

///|
test "area weighted normal" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(2.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 2.0, 0.0))
  m.add_face(v0, v1, v2)
  let n = area_weighted_normal(m, 0)
  let expected = face_normal(m, 0)
  assert_true((n.x - expected.x).abs() < 0.001)
  assert_true((n.y - expected.y).abs() < 0.001)
  assert_true((n.z - expected.z).abs() < 0.001)
}

///|
test "normalize zero vector" {
  let v = @core.Point3D::new(0.0, 0.0, 0.0)
  let n = normalize(v)
  assert_true(n.x.abs() < 0.001)
  assert_true(n.y.abs() < 0.001)
  assert_true(n.z.abs() < 0.001)
}

///|
test "normalize general vector" {
  let v = @core.Point3D::new(1.0, 2.0, 2.0)
  let n = normalize(v)
  let mag = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((mag - 1.0).abs() < 0.001)
}

///|
test "face normal 3d triangle" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 1.0))
  m.add_face(v0, v1, v2)
  let n = face_normal(m, 0)
  assert_true((n.y + 1.0).abs() < 0.001)
}

///|
test "vertex normal isolated vertex" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 1.0, 0.0))
  let v3 = m.add_vertex(@core.Point3D::new(5.0, 5.0, 5.0))
  ignore(v3)
  m.add_face(v0, v1, v2)
  let n = vertex_normal(m, 0)
  let len = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((len - 1.0).abs() < 0.001)
}

///|
test "face area unit triangle" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.0, 1.0, 0.0))
  m.add_face(v0, v1, v2)
  let area = face_area(m, 0)
  assert_true((area - 0.5).abs() < 0.001)
}
