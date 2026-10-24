///|
test "face_normal basic" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let (nx, ny, nz) = face_normal(verts, (0, 1, 2))
  assert_true((nx - 0.0).abs() < 0.0001)
  assert_true((ny - 0.0).abs() < 0.0001)
  assert_true((nz - 1.0).abs() < 0.0001)
}

///|
test "triangle_area basic" {
  let verts = [(0.0, 0.0, 0.0), (2.0, 0.0, 0.0), (0.0, 2.0, 0.0)]
  let area = triangle_area(verts, (0, 1, 2))
  assert_true((area - 2.0).abs() < 0.0001)
}

///|
test "mesh_area basic" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let faces = [(0, 1, 2)]
  let area = mesh_area(verts, faces)
  assert_true((area - 0.5).abs() < 0.0001)
}

///|
test "midpoint_subdivide basic" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let faces = [(0, 1, 2)]
  let (nv, nf) = midpoint_subdivide(verts, faces)
  assert_eq(nv.length(), 6)
  assert_eq(nf.length(), 4)
}

///|
test "validate_mesh basic" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let faces = [(0, 1, 2)]
  assert_true(validate_mesh(verts, faces))
  let bad_faces = [(0, 1, 5)]
  assert_true(!validate_mesh(verts, bad_faces))
}

///|
test "mesh_bounding_box basic" {
  let verts = [(1.0, 2.0, 3.0), (-1.0, -2.0, -3.0), (0.0, 0.0, 0.0)]
  let (min_x, _, min_z, max_x, _, _) = mesh_bounding_box(verts)
  assert_true((min_x - -1.0).abs() < 0.0001)
  assert_true((max_x - 1.0).abs() < 0.0001)
  assert_true((min_z - -3.0).abs() < 0.0001)
}
///|
test "vertex_normal basic" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let faces = [(0, 1, 2)]
  let (nx, ny, nz) = vertex_normal(verts, faces, 0)
  assert_true((nx - 0.0).abs() < 0.0001)
  assert_true((ny - 0.0).abs() < 0.0001)
  assert_true((nz - 1.0).abs() < 0.0001)
}

///|
test "vertex_normal not in any face" {
  let verts = [
    (0.0, 0.0, 0.0),
    (1.0, 0.0, 0.0),
    (0.0, 1.0, 0.0),
    (2.0, 2.0, 2.0),
  ]
  let faces = [(0, 1, 2)]
  let (nx, ny, nz) = vertex_normal(verts, faces, 3)
  assert_true((nx - 0.0).abs() < 0.0001)
  assert_true((ny - 0.0).abs() < 0.0001)
  assert_true((nz - 0.0).abs() < 0.0001)
}

///|
test "face_normal degenerate" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (2.0, 0.0, 0.0)]
  let (nx, ny, nz) = face_normal(verts, (0, 1, 2))
  assert_true((nx - 0.0).abs() < 0.0001)
  assert_true((ny - 0.0).abs() < 0.0001)
  assert_true((nz - 0.0).abs() < 0.0001)
}

///|
test "vertex_normal multiple faces" {
  let verts = [
    (0.0, 0.0, 0.0),
    (1.0, 0.0, 0.0),
    (0.0, 1.0, 0.0),
    (-1.0, 0.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 2, 3)]
  let (_, _, nz) = vertex_normal(verts, faces, 0)
  assert_true((nz - 1.0).abs() < 0.0001)
}

///|
test "mesh_area multiple" {
  let verts = [
    (0.0, 0.0, 0.0),
    (1.0, 0.0, 0.0),
    (0.0, 1.0, 0.0),
    (1.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (1, 3, 2)]
  let area = mesh_area(verts, faces)
  assert_true((area - 1.0).abs() < 0.0001)
}

///|
test "validate_mesh duplicate vertex" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let bad_faces = [(0, 0, 1)]
  assert_true(!validate_mesh(verts, bad_faces))
}

///|
test "mesh_bounding_box single" {
  let verts = [(5.0, 6.0, 7.0)]
  let (min_x, min_y, min_z, max_x, max_y, max_z) = mesh_bounding_box(verts)
  assert_true((min_x - 5.0).abs() < 0.0001)
  assert_true((max_x - 5.0).abs() < 0.0001)
  assert_true((min_y - 6.0).abs() < 0.0001)
  assert_true((max_y - 6.0).abs() < 0.0001)
  assert_true((min_z - 7.0).abs() < 0.0001)
  assert_true((max_z - 7.0).abs() < 0.0001)
}
