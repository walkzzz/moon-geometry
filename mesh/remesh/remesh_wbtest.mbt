///|
test "remesh empty" {
  let (v, f) = remesh([], [], 1.0, 1)
  assert_eq(v.length(), 0)
  assert_eq(f.length(), 0)
}

///|
test "remesh split long edge" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 10.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let (v, f) = remesh(verts, faces, 1.0, 1)
  assert_true(f.length() > 1)
  assert_true(v.length() > 3)
}

///|
test "remesh stable edges" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let (_, f) = remesh(verts, faces, 1.0, 1)
  assert_eq(f.length(), 1)
}
