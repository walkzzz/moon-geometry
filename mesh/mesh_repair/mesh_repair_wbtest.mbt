///|
test "remove degenerate faces" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 1, 3)]
  let (result, removed) = remove_degenerate_faces(verts, faces, 0.0001)
  assert_eq(removed, 1)
  assert_eq(result.length(), 1)
}

///|
test "merge duplicate vertices" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 0.0),
  ]
  let faces = [(0, 1, 2), (3, 1, 2)]
  let (nv, nf, merged) = merge_duplicate_vertices(verts, faces, 0.0001)
  assert_eq(merged, 1)
  assert_eq(nv.length(), 3)
  assert_eq(nf.length(), 2)
}

///|
test "find boundary edges" {
  let faces = [(0, 1, 2)]
  let boundary = find_boundary_edges(faces)
  assert_eq(boundary.length(), 3)
}

///|
test "find boundary edges closed" {
  let faces = [(0, 2, 1), (0, 1, 3), (0, 3, 2), (1, 2, 3)]
  let boundary = find_boundary_edges(faces)
  assert_eq(boundary.length(), 0)
}

///|
test "fill holes" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let (new_faces, filled) = fill_holes(verts, faces)
  assert_true(filled >= 0)
  assert_true(new_faces.length() >= faces.length())
}

///|
test "repair mesh full" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 1, 3)]
  let result = repair_mesh(verts, faces, 0.0001)
  assert_true(result.degenerate_removed >= 1)
}

///|
test "no degenerate faces" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let (result, removed) = remove_degenerate_faces(verts, faces, 0.0001)
  assert_eq(removed, 0)
  assert_eq(result.length(), 1)
}

///|
test "merge no duplicates" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let (nv, _nf, merged) = merge_duplicate_vertices(verts, faces, 0.0001)
  assert_eq(merged, 0)
  assert_eq(nv.length(), 3)
}
