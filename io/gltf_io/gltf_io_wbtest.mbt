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
test "gltf binary large indices" {
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
