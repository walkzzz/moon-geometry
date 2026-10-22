test "obj empty mesh" {
  let m = ObjMesh::new()
  assert_eq(ObjMesh::vertex_count(m), 0)
  assert_eq(ObjMesh::face_count(m), 0)
}

test "obj write vertices" {
  let m = ObjMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.vertices.push(@core.Point3D::new(4.0, 5.0, 6.0))
  let s = obj_write(m)
  assert_true(s.contains("v 1 2 3"))
  assert_true(s.contains("v 4 5 6"))
}

test "obj write texcoords" {
  let m = ObjMesh::new()
  m.texcoords.push((0.5, 0.25))
  let s = obj_write(m)
  assert_true(s.contains("vt 0.5 0.25"))
}

test "obj write normals" {
  let m = ObjMesh::new()
  m.normals.push(@core.Point3D::new(0.0, 0.0, 1.0))
  let s = obj_write(m)
  assert_true(s.contains("vn 0 0 1"))
}

test "obj write face full" {
  let m = ObjMesh::new()
  m.faces.push(
    ObjFace::new([ObjFaceVertex::new(1, 2, 3), ObjFaceVertex::new(2, 3, 4)]),
  )
  let s = obj_write(m)
  assert_true(s.contains("f 1/2/3 2/3/4"))
}

test "obj write face v only" {
  let m = ObjMesh::new()
  m.faces.push(
    ObjFace::new([ObjFaceVertex::new(1, 0, 0), ObjFaceVertex::new(2, 0, 0)]),
  )
  let s = obj_write(m)
  assert_true(s.contains("f 1 2"))
}

test "obj parse vertices" {
  let text = "v 1 2 3\nv 4 5 6\n"
  let m = obj_parse(text)
  assert_eq(ObjMesh::vertex_count(m), 2)
  assert_true(@core.approx_eq(m.vertices[0].x, 1.0, 0.000001))
  assert_true(@core.approx_eq(m.vertices[1].z, 6.0, 0.000001))
}

test "obj parse face" {
  let text = "v 0 0 0\nv 1 0 0\nv 0 1 0\nf 1 2 3\n"
  let m = obj_parse(text)
  assert_eq(ObjMesh::face_count(m), 1)
  assert_eq(m.faces[0].verts.length(), 3)
  assert_eq(m.faces[0].verts[0].v, 1)
}

test "obj parse face with texcoord and normal" {
  let text = "f 1/1/1 2/2/2 3/3/3\n"
  let m = obj_parse(text)
  assert_eq(ObjMesh::face_count(m), 1)
  assert_eq(m.faces[0].verts[0].v, 1)
  assert_eq(m.faces[0].verts[0].vt, 1)
  assert_eq(m.faces[0].verts[0].vn, 1)
}

test "obj roundtrip" {
  let m = ObjMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.vertices.push(@core.Point3D::new(4.0, 5.0, 6.0))
  m.vertices.push(@core.Point3D::new(7.0, 8.0, 9.0))
  m.faces.push(ObjFace::new([ObjFaceVertex::new(1, 0, 0), ObjFaceVertex::new(2, 0, 0), ObjFaceVertex::new(3, 0, 0)]))
  let text = obj_write(m)
  let m2 = obj_parse(text)
  assert_eq(ObjMesh::vertex_count(m2), 3)
  assert_eq(ObjMesh::face_count(m2), 1)
  assert_true(@core.approx_eq(m2.vertices[2].z, 9.0, 0.000001))
}

test "obj parse negative coords" {
  let text = "v -1.5 -2.5 -3.5\n"
  let m = obj_parse(text)
  assert_eq(ObjMesh::vertex_count(m), 1)
  assert_true(@core.approx_eq(m.vertices[0].x, -1.5, 0.000001))
  assert_true(@core.approx_eq(m.vertices[0].y, -2.5, 0.000001))
}
test "parse double sv integer" {
  let d = parse_double_sv("42".to_string_view())
  assert_true((d - 42.0).abs() < 0.000001)
}

test "parse double sv decimal" {
  let d = parse_double_sv("3.14".to_string_view())
  assert_true((d - 3.14).abs() < 0.001)
}

test "parse double sv negative" {
  let d = parse_double_sv("-2.5".to_string_view())
  assert_true((d + 2.5).abs() < 0.000001)
}

test "parse double sv scientific" {
  let d = parse_double_sv("1e3".to_string_view())
  assert_true((d - 1000.0).abs() < 0.000001)
}

test "parse double sv negative exp" {
  let d = parse_double_sv("1e-2".to_string_view())
  assert_true((d - 0.01).abs() < 0.000001)
}

test "parse double sv empty" {
  let d = parse_double_sv("".to_string_view())
  assert_true(d.abs() < 0.000001)
}

test "obj parse texcoords" {
  let text = "vt 0.5 0.25\nvt 0.75 0.5\n"
  let m = obj_parse(text)
  assert_eq(m.texcoords.length(), 2)
  assert_true((m.texcoords[0].0 - 0.5).abs() < 0.000001)
  assert_true((m.texcoords[1].1 - 0.5).abs() < 0.000001)
}

test "obj parse normals" {
  let text = "vn 0 0 1\nvn 1 0 0\n"
  let m = obj_parse(text)
  assert_eq(m.normals.length(), 2)
  assert_true((m.normals[0].z - 1.0).abs() < 0.000001)
}

test "obj write face vt only" {
  let m = ObjMesh::new()
  m.faces.push(
    ObjFace::new([ObjFaceVertex::new(1, 2, 0), ObjFaceVertex::new(2, 3, 0)]),
  )
  let s = obj_write(m)
  assert_true(s.contains("f 1/2 2/3"))
}

test "obj write face vn only" {
  let m = ObjMesh::new()
  m.faces.push(
    ObjFace::new([ObjFaceVertex::new(1, 0, 2), ObjFaceVertex::new(2, 0, 3)]),
  )
  let s = obj_write(m)
  assert_true(s.contains("f 1//2 2//3"))
}

test "obj parse comment lines" {
  let text = "# this is a comment\nv 1 2 3\n# another\n"
  let m = obj_parse(text)
  assert_eq(ObjMesh::vertex_count(m), 1)
}

test "obj parse face vn only" {
  let text = "f 1//1 2//2 3//3\n"
  let m = obj_parse(text)
  assert_eq(ObjMesh::face_count(m), 1)
  assert_eq(m.faces[0].verts[0].v, 1)
  assert_eq(m.faces[0].verts[0].vn, 1)
  assert_eq(m.faces[0].verts[0].vt, 0)
}

test "obj parse empty lines" {
  let text = "\n\nv 1 2 3\n\n"
  let m = obj_parse(text)
  assert_eq(ObjMesh::vertex_count(m), 1)
}

test "obj parse scientific coords" {
  let text = "v 1e2 2e-1 3.5e1\n"
  let m = obj_parse(text)
  assert_eq(ObjMesh::vertex_count(m), 1)
  assert_true((m.vertices[0].x - 100.0).abs() < 0.001)
  assert_true((m.vertices[0].y - 0.2).abs() < 0.001)
}

test "obj full mesh roundtrip" {
  let m = ObjMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.vertices.push(@core.Point3D::new(4.0, 5.0, 6.0))
  m.vertices.push(@core.Point3D::new(7.0, 8.0, 9.0))
  m.texcoords.push((0.0, 0.0))
  m.texcoords.push((1.0, 0.0))
  m.texcoords.push((0.0, 1.0))
  m.normals.push(@core.Point3D::new(0.0, 0.0, 1.0))
  m.faces.push(ObjFace::new([
    ObjFaceVertex::new(1, 1, 1),
    ObjFaceVertex::new(2, 2, 1),
    ObjFaceVertex::new(3, 3, 1),
  ]))
  let text = obj_write(m)
  let m2 = obj_parse(text)
  assert_eq(ObjMesh::vertex_count(m2), 3)
  assert_eq(m2.texcoords.length(), 3)
  assert_eq(m2.normals.length(), 1)
  assert_eq(ObjMesh::face_count(m2), 1)
}

test "obj face vertex construct" {
  let fv = ObjFaceVertex::new(3, 4, 5)
  assert_eq(fv.v, 3)
  assert_eq(fv.vt, 4)
  assert_eq(fv.vn, 5)
}

test "obj face construct" {
  let f = ObjFace::new([ObjFaceVertex::new(1, 0, 0), ObjFaceVertex::new(2, 0, 0)])
  assert_eq(f.verts.length(), 2)
}