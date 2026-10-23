///|
test "ply empty mesh" {
  let m = PlyMesh::new()
  assert_eq(PlyMesh::vertex_count(m), 0)
  assert_eq(PlyMesh::face_count(m), 0)
}

///|
test "ply write ascii header" {
  let m = PlyMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  let s = ply_write_ascii(m)
  assert_true(s.contains("ply"))
  assert_true(s.contains("format ascii 1.0"))
  assert_true(s.contains("element vertex 1"))
  assert_true(s.contains("end_header"))
}

///|
test "ply write ascii vertices and faces" {
  let m = PlyMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.vertices.push(@core.Point3D::new(4.0, 5.0, 6.0))
  m.vertices.push(@core.Point3D::new(7.0, 8.0, 9.0))
  m.faces.push([0, 1, 2])
  let s = ply_write_ascii(m)
  assert_true(s.contains("element face 1"))
  assert_true(s.contains("3 0 1 2"))
}

///|
test "ply parse ascii" {
  let text = "ply\nformat ascii 1.0\nelement vertex 3\nproperty float x\nproperty float y\nproperty float z\nelement face 1\nproperty list uchar int vertex_indices\nend_header\n1 2 3\n4 5 6\n7 8 9\n3 0 1 2\n"
  let m = ply_parse_ascii(text)
  assert_eq(PlyMesh::vertex_count(m), 3)
  assert_eq(PlyMesh::face_count(m), 1)
  assert_true(@core.approx_eq(m.vertices[0].x, 1.0, 0.000001))
  assert_eq(m.faces[0].length(), 3)
}

///|
test "ply parse ascii no faces" {
  let text = "ply\nformat ascii 1.0\nelement vertex 2\nproperty float x\nproperty float y\nproperty float z\nelement face 0\nproperty list uchar int vertex_indices\nend_header\n1 2 3\n4 5 6\n"
  let m = ply_parse_ascii(text)
  assert_eq(PlyMesh::vertex_count(m), 2)
  assert_eq(PlyMesh::face_count(m), 0)
}

///|
test "ply binary roundtrip" {
  let m = PlyMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.vertices.push(@core.Point3D::new(4.0, 5.0, 6.0))
  m.faces.push([0, 1])
  let bytes = ply_write_binary(m)
  let m2 = ply_parse_binary(bytes)
  assert_eq(PlyMesh::vertex_count(m2), 2)
  assert_eq(PlyMesh::face_count(m2), 1)
  assert_true(@core.approx_eq(m2.vertices[0].x, 1.0, 0.01))
  assert_true(@core.approx_eq(m2.vertices[1].z, 6.0, 0.01))
  assert_eq(m2.faces[0].length(), 2)
}

///|
test "ply binary empty" {
  let m = PlyMesh::new()
  let bytes = ply_write_binary(m)
  let m2 = ply_parse_binary(bytes)
  assert_eq(PlyMesh::vertex_count(m2), 0)
  assert_eq(PlyMesh::face_count(m2), 0)
}

///|
test "ply ascii roundtrip" {
  let m = PlyMesh::new()
  m.vertices.push(@core.Point3D::new(1.5, 2.5, 3.5))
  m.vertices.push(@core.Point3D::new(4.5, 5.5, 6.5))
  m.vertices.push(@core.Point3D::new(7.5, 8.5, 9.5))
  m.faces.push([0, 1, 2])
  let text = ply_write_ascii(m)
  let m2 = ply_parse_ascii(text)
  assert_eq(PlyMesh::vertex_count(m2), 3)
  assert_true(@core.approx_eq(m2.vertices[2].z, 9.5, 0.000001))
}

///|
test "ply binary quad face" {
  let m = PlyMesh::new()
  m.vertices.push(@core.Point3D::new(0.0, 0.0, 0.0))
  m.vertices.push(@core.Point3D::new(1.0, 0.0, 0.0))
  m.vertices.push(@core.Point3D::new(1.0, 1.0, 0.0))
  m.vertices.push(@core.Point3D::new(0.0, 1.0, 0.0))
  m.faces.push([0, 1, 2, 3])
  let bytes = ply_write_binary(m)
  let m2 = ply_parse_binary(bytes)
  assert_eq(m2.faces[0].length(), 4)
  assert_eq(m2.faces[0][3], 3)
}
