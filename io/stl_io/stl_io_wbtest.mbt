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

///|
test "stl parse ascii with blank lines" {
  let text = "solid cube\n\nfacet normal 0 0 1\nouter loop\n\nvertex 0 0 0\nvertex 1 0 0\nvertex 0 1 0\n\nendloop\nendfacet\nendsolid cube\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
}

///|
test "stl parse ascii solid without name" {
  let text = "solid\nfacet normal 0 0 1\nouter loop\nvertex 0 0 0\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid\n"
  let m = stl_parse_ascii(text)
  assert_eq(m.name, "default")
  assert_eq(StlMesh::triangle_count(m), 1)
}

///|
test "stl parse ascii facet insufficient_args" {
  let text = "solid x\nfacet normal 0 0\nouter loop\nvertex 0 0 0\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].normal.x, 0.0, 0.000001))
}

///|
test "stl parse ascii vertex insufficient_args" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex 0 0\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 0)
}

///|
test "stl parse ascii endfacet insufficient_vertices" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex 0 0 0\nvertex 1 0 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 0)
}

///|
test "stl parse ascii decimal coords" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex 1.25 2.75 3.125\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].v0.x, 1.25, 0.000001))
  assert_true(@core.approx_eq(m.triangles[0].v0.z, 3.125, 0.000001))
}

///|
test "stl parse ascii scientific notation" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex 1e2 2E1 3.0e0\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].v0.x, 100.0, 0.001))
  assert_true(@core.approx_eq(m.triangles[0].v0.y, 20.0, 0.001))
}

///|
test "stl parse ascii scientific notation negative exponent" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex 1.5e-1 2.5E+1 3.0e2\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].v0.x, 0.15, 0.0001))
  assert_true(@core.approx_eq(m.triangles[0].v0.y, 25.0, 0.001))
}

///|
test "stl parse ascii plus sign coords" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex +1.0 +2.0 +3.0\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].v0.x, 1.0, 0.000001))
}

///|
test "stl parse ascii tab separated" {
  let text = "solid x\nfacet normal 0\t0\t1\nouter loop\nvertex 0\t0\t0\nvertex 1\t0\t0\nvertex 0\t1\t0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].normal.z, 1.0, 0.000001))
}

///|
test "stl parse ascii unknown commands ignored" {
  let text = "solid x\ncustom line here\nfacet normal 0 0 1\nouter loop\nvertex 0 0 0\nvertex 1 0 0\nvertex 0 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
}

///|
test "stl write binary long name truncated" {
  let long_name = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
  let m = StlMesh::new(long_name)
  m.triangles.push(
    StlTriangle::new(
      @core.Point3D::new(0.0, 0.0, 1.0),
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(1.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
    ),
  )
  let bytes = stl_write_binary(m)
  let m2 = stl_parse_binary(bytes)
  assert_eq(StlMesh::triangle_count(m2), 1)
}

///|
test "stl parse binary too short" {
  let bytes = b"\x01\x02\x03\x04\x05"
  let m = stl_parse_binary(bytes)
  assert_eq(StlMesh::triangle_count(m), 0)
}

///|
test "stl parse binary empty" {
  let bytes = b""
  let m = stl_parse_binary(bytes)
  assert_eq(StlMesh::triangle_count(m), 0)
}

///|
test "stl parse binary truncated triangle" {
  let m = StlMesh::new("t")
  m.triangles.push(
    StlTriangle::new(
      @core.Point3D::new(0.0, 0.0, 1.0),
      @core.Point3D::new(1.0, 2.0, 3.0),
      @core.Point3D::new(4.0, 5.0, 6.0),
      @core.Point3D::new(7.0, 8.0, 9.0),
    ),
  )
  m.triangles.push(
    StlTriangle::new(
      @core.Point3D::new(0.0, 0.0, 1.0),
      @core.Point3D::new(1.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 0.0),
    ),
  )
  let bytes = stl_write_binary(m)
  let truncated = Bytes::from_iter(bytes[0:110].iter())
  let m2 = stl_parse_binary(truncated)
  assert_true(StlMesh::triangle_count(m2) <= 1)
}

///|
test "stl binary roundtrip negative coords" {
  let m = StlMesh::new("neg")
  m.triangles.push(
    StlTriangle::new(
      @core.Point3D::new(0.0, 0.0, -1.0),
      @core.Point3D::new(-1.5, -2.5, -3.5),
      @core.Point3D::new(1.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
    ),
  )
  let bytes = stl_write_binary(m)
  let m2 = stl_parse_binary(bytes)
  assert_eq(StlMesh::triangle_count(m2), 1)
  assert_true(@core.approx_eq(m2.triangles[0].v0.x, -1.5, 0.01))
  assert_true(@core.approx_eq(m2.triangles[0].normal.z, -1.0, 0.01))
}

///|
test "stl write ascii empty mesh" {
  let m = StlMesh::new("empty")
  let s = stl_write_ascii(m)
  assert_true(s.contains("solid empty"))
  assert_true(s.contains("endsolid empty"))
}

///|
test "stl parse ascii only_header" {
  let text = "solid x\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(m.name, "x")
  assert_eq(StlMesh::triangle_count(m), 0)
}

///|
test "stl parse ascii extra_vertices_ignored" {
  let text = "solid x\nfacet normal 0 0 1\nouter loop\nvertex 0 0 0\nvertex 1 0 0\nvertex 0 1 0\nvertex 1 1 0\nendloop\nendfacet\nendsolid x\n"
  let m = stl_parse_ascii(text)
  assert_eq(StlMesh::triangle_count(m), 1)
  assert_true(@core.approx_eq(m.triangles[0].v2.x, 0.0, 0.000001))
}
