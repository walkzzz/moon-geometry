///|
test "stl empty mesh" {
  let m = StlMesh::new("test")
  assert_eq(StlMesh::triangle_count(m), 0)
}

///|
test "stl write ascii" {
  let m = StlMesh::new("cube")
  m.triangles.push(
    StlTriangle::new(
      @core.Point3D::new(0.0, 0.0, 1.0),
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(1.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
    ),
  )
  let s = stl_write_ascii(m)
  assert_true(s.contains("solid cube"))
  assert_true(s.contains("endsolid cube"))
  assert_true(s.contains("facet normal 0 0 1"))
  assert_true(s.contains("vertex 0 0 0"))
}

///|
test "stl parse ascii" {
  let text = "solid cube\nfacet normal 0 0 1\nouter loop\nvertex 0 0 0\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid cube\n"
  let m = stl_parse_ascii(text)
  assert_eq(m.name, "cube")
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].v1.x, 1.0, 0.000001))
}

///|
test "stl parse ascii multiple" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex 0 0 0\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nfacet normal 0 0 -1\nouter loop\nvertex 0 0 0\nvertex 0 1 0\nvertex 1 0 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 2)
}

///|
test "stl binary roundtrip" {
  let m = StlMesh::new("bin")
  m.triangles.push(
    StlTriangle::new(
      @core.Point3D::new(0.0, 0.0, 1.0),
      @core.Point3D::new(1.0, 2.0, 3.0),
      @core.Point3D::new(4.0, 5.0, 6.0),
      @core.Point3D::new(7.0, 8.0, 9.0),
    ),
  )
  let bytes = stl_write_binary(m)
  let m2 = stl_parse_binary(bytes)
  assert_eq(StlMesh::triangle_count(m2), 1)
  assert_true(@core.approx_eq(m2.triangles[0].v0.x, 1.0, 0.01))
  assert_true(@core.approx_eq(m2.triangles[0].v2.z, 9.0, 0.01))
}

///|
test "stl binary empty" {
  let m = StlMesh::new("empty")
  let bytes = stl_write_binary(m)
  let m2 = stl_parse_binary(bytes)
  assert_eq(StlMesh::triangle_count(m2), 0)
}

///|
test "stl binary multiple triangles" {
  let m = StlMesh::new("multi")
  for i in 0..<5 {
    let fi = i.to_double()
    m.triangles.push(
      StlTriangle::new(
        @core.Point3D::new(0.0, 0.0, 1.0),
        @core.Point3D::new(fi, 0.0, 0.0),
        @core.Point3D::new(fi + 1.0, 0.0, 0.0),
        @core.Point3D::new(fi, 1.0, 0.0),
      ),
    )
  }
  let bytes = stl_write_binary(m)
  let m2 = stl_parse_binary(bytes)
  assert_eq(StlMesh::triangle_count(m2), 5)
}

///|
test "stl ascii negative coords" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex -1.5 -2.5 -3.5\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].v0.x, -1.5, 0.000001))
}

///|
test "stl write ascii contains endloop" {
  let m = StlMesh::new("t")
  m.triangles.push(
    StlTriangle::new(
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(1.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
    ),
  )
  let s = stl_write_ascii(m)
  assert_true(s.contains("outer loop"))
  assert_true(s.contains("endloop"))
  assert_true(s.contains("endfacet"))
}
