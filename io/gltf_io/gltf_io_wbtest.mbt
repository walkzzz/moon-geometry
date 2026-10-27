///|
test "gltf empty mesh" {
  let m = GltfMesh::new()
  assert_eq(GltfMesh::vertex_count(m), 0)
  assert_eq(GltfMesh::index_count(m), 0)
}

///|
test "gltf write json" {
  let m = GltfMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.indices.push(0)
  let s = gltf_write_json(m)
  assert_true(s.contains("\"version\":\"2.0\""))
  assert_true(s.contains("\"vertices\":[1,2,3]"))
  assert_true(s.contains("\"indices\":[0]"))
}

///|
test "gltf parse json" {
  let text = "{\"asset\":{\"version\":\"2.0\"},\"vertices\":[1,2,3,4,5,6],\"indices\":[0,1,2]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 2)
  assert_eq(GltfMesh::index_count(m), 3)
  assert_true(@core.approx_eq(m.vertices[0].x, 1.0, 0.000001))
  assert_true(@core.approx_eq(m.vertices[1].z, 6.0, 0.000001))
}

///|
test "gltf json roundtrip" {
  let m = GltfMesh::new()
  m.vertices.push(@core.Point3D::new(1.5, 2.5, 3.5))
  m.vertices.push(@core.Point3D::new(4.5, 5.5, 6.5))
  m.vertices.push(@core.Point3D::new(7.5, 8.5, 9.5))
  m.indices.push(0)
  m.indices.push(1)
  m.indices.push(2)
  let text = gltf_write_json(m)
  let m2 = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m2), 3)
  assert_eq(GltfMesh::index_count(m2), 3)
  assert_true(@core.approx_eq(m2.vertices[2].z, 9.5, 0.000001))
}

///|
test "gltf binary roundtrip" {
  let m = GltfMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.vertices.push(@core.Point3D::new(4.0, 5.0, 6.0))
  m.indices.push(0)
  m.indices.push(1)
  let bytes = gltf_write_binary(m)
  let m2 = gltf_parse_binary(bytes)
  assert_eq(GltfMesh::vertex_count(m2), 2)
  assert_eq(GltfMesh::index_count(m2), 2)
  assert_true(@core.approx_eq(m2.vertices[0].x, 1.0, 0.01))
  assert_eq(m2.indices[1], 1)
}

///|
test "gltf binary empty" {
  let m = GltfMesh::new()
  let bytes = gltf_write_binary(m)
  let m2 = gltf_parse_binary(bytes)
  assert_eq(GltfMesh::vertex_count(m2), 0)
  assert_eq(GltfMesh::index_count(m2), 0)
}

///|
test "gltf parse json negative" {
  let text = "{\"vertices\":[-1.5,-2.5,-3.5],\"indices\":[]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 1)
  assert_true(@core.approx_eq(m.vertices[0].x, -1.5, 0.000001))
}

///|
test "gltf write json empty arrays" {
  let m = GltfMesh::new()
  let s = gltf_write_json(m)
  assert_true(s.contains("\"vertices\":[]"))
  assert_true(s.contains("\"indices\":[]"))
}

///|
test "gltf binary large_indices" {
  let m = GltfMesh::new()
  for i in 0..<10 {
    m.vertices.push(@core.Point3D::new(i.to_double(), 0.0, 0.0))
  }
  for i in 0..<10 {
    m.indices.push(i)
  }
  let bytes = gltf_write_binary(m)
  let m2 = gltf_parse_binary(bytes)
  assert_eq(GltfMesh::vertex_count(m2), 10)
  assert_eq(GltfMesh::index_count(m2), 10)
  assert_eq(m2.indices[9], 9)
}

///|
test "gltf parse json missing vertices_key" {
  let text = "{\"asset\":{\"version\":\"2.0\"},\"indices\":[0,1,2]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 0)
  assert_eq(GltfMesh::index_count(m), 3)
}

///|
test "gltf parse json missing_indices_key" {
  let text = "{\"asset\":{\"version\":\"2.0\"},\"vertices\":[1,2,3]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 1)
  assert_eq(GltfMesh::index_count(m), 0)
}

///|
test "gltf parse json with spaces" {
  let text = "{\"vertices\":[ 1.0 , 2.0 , 3.0 ],\"indices\":[ 0 , 1 ]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 1)
  assert_eq(GltfMesh::index_count(m), 2)
  assert_true(@core.approx_eq(m.vertices[0].x, 1.0, 0.000001))
}

///|
test "gltf parse json with newlines and tabs" {
  let text = "{\"vertices\":[\n\t1.0,\n\t2.0,\n\t3.0\n],\"indices\":[\n\t0\n]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 1)
  assert_eq(GltfMesh::index_count(m), 1)
}

///|
test "gltf parse json scientific notation" {
  let text = "{\"vertices\":[1e2,2E1,3.0e0],\"indices\":[]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 1)
  assert_true(@core.approx_eq(m.vertices[0].x, 100.0, 0.001))
  assert_true(@core.approx_eq(m.vertices[0].y, 20.0, 0.001))
}

///|
test "gltf parse json scientific notation negative exponent" {
  let text = "{\"vertices\":[1.5e-1,2.5E+1,3.0e2],\"indices\":[]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 1)
  assert_true(@core.approx_eq(m.vertices[0].x, 0.15, 0.0001))
  assert_true(@core.approx_eq(m.vertices[0].y, 25.0, 0.001))
  assert_true(@core.approx_eq(m.vertices[0].z, 300.0, 0.001))
}

///|
test "gltf parse json plus sign numbers" {
  let text = "{\"vertices\":[+1.0,+2.0,+3.0],\"indices\":[]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 1)
  assert_true(@core.approx_eq(m.vertices[0].x, 1.0, 0.000001))
}

///|
test "gltf parse json negative indices" {
  let text = "{\"vertices\":[1,2,3],\"indices\":[-1,-2,0]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::index_count(m), 3)
  assert_eq(m.indices[0], -1)
  assert_eq(m.indices[1], -2)
}

///|
test "gltf parse json plus sign indices" {
  let text = "{\"vertices\":[1,2,3],\"indices\":[+1,+2]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::index_count(m), 2)
  assert_eq(m.indices[0], 1)
  assert_eq(m.indices[1], 2)
}

///|
test "gltf parse json nested array_in_vertices" {
  let text = "{\"vertices\":[[1,2,3]],\"indices\":[]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 0)
}

///|
test "gltf parse json incomplete_vertex_triple" {
  let text = "{\"vertices\":[1,2],\"indices\":[]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 0)
}

///|
test "gltf parse json extra_vertices_trailing" {
  let text = "{\"vertices\":[1,2,3,4],\"indices\":[]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 1)
  assert_true(@core.approx_eq(m.vertices[0].x, 1.0, 0.000001))
}

///|
test "gltf parse binary too short" {
  let bytes = b"\x01\x02\x03"
  let m = gltf_parse_binary(bytes)
  assert_eq(GltfMesh::vertex_count(m), 0)
  assert_eq(GltfMesh::index_count(m), 0)
}

///|
test "gltf parse binary truncated vertices" {
  let m = GltfMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.vertices.push(@core.Point3D::new(4.0, 5.0, 6.0))
  let bytes = gltf_write_binary(m)
  let truncated = Bytes::from_iter(bytes[0:15].iter())
  let m2 = gltf_parse_binary(truncated)
  assert_true(GltfMesh::vertex_count(m2) <= 1)
}

///|
test "gltf parse binary truncated indices" {
  let m = GltfMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.indices.push(0)
  m.indices.push(1)
  let bytes = gltf_write_binary(m)
  let truncated = Bytes::from_iter(bytes[0:23].iter())
  let m2 = gltf_parse_binary(truncated)
  assert_eq(GltfMesh::vertex_count(m2), 1)
  assert_true(GltfMesh::index_count(m2) <= 2)
}

///|
test "gltf parse binary empty data" {
  let bytes = b""
  let m = gltf_parse_binary(bytes)
  assert_eq(GltfMesh::vertex_count(m), 0)
  assert_eq(GltfMesh::index_count(m), 0)
}

///|
test "gltf write json multiple vertices separator" {
  let m = GltfMesh::new()
  m.vertices.push(@core.Point3D::new(1.0, 2.0, 3.0))
  m.vertices.push(@core.Point3D::new(4.0, 5.0, 6.0))
  m.indices.push(0)
  m.indices.push(1)
  let s = gltf_write_json(m)
  assert_true(s.contains("3,4,5,6"))
  assert_true(s.contains("0,1"))
}

///|
test "gltf binary roundtrip negative coords" {
  let m = GltfMesh::new()
  m.vertices.push(@core.Point3D::new(-1.5, -2.5, -3.5))
  m.indices.push(0)
  let bytes = gltf_write_binary(m)
  let m2 = gltf_parse_binary(bytes)
  assert_eq(GltfMesh::vertex_count(m2), 1)
  assert_true(@core.approx_eq(m2.vertices[0].x, -1.5, 0.01))
  assert_true(@core.approx_eq(m2.vertices[0].z, -3.5, 0.01))
}

///|
test "gltf parse json empty vertices and indices" {
  let text = "{\"vertices\":[],\"indices\":[]}"
  let m = gltf_parse_json(text)
  assert_eq(GltfMesh::vertex_count(m), 0)
  assert_eq(GltfMesh::index_count(m), 0)
}
