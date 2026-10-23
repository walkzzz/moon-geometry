///|
fn make_cube() -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
    @core.Point3D::new(0.0, 1.0, 1.0),
  ]
  let faces = [
    (0, 2, 1),
    (0, 3, 2),
    (4, 5, 6),
    (4, 6, 7),
    (0, 1, 5),
    (0, 5, 4),
    (1, 2, 6),
    (1, 6, 5),
    (2, 3, 7),
    (2, 7, 6),
    (3, 0, 4),
    (3, 4, 7),
  ]
  (verts, faces)
}

///|
fn make_cube2() -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let verts = [
    @core.Point3D::new(0.5, 0.5, 0.5),
    @core.Point3D::new(1.5, 0.5, 0.5),
    @core.Point3D::new(1.5, 1.5, 0.5),
    @core.Point3D::new(0.5, 1.5, 0.5),
    @core.Point3D::new(0.5, 0.5, 1.5),
    @core.Point3D::new(1.5, 0.5, 1.5),
    @core.Point3D::new(1.5, 1.5, 1.5),
    @core.Point3D::new(0.5, 1.5, 1.5),
  ]
  let faces = [
    (0, 2, 1),
    (0, 3, 2),
    (4, 5, 6),
    (4, 6, 7),
    (0, 1, 5),
    (0, 5, 4),
    (1, 2, 6),
    (1, 6, 5),
    (2, 3, 7),
    (2, 7, 6),
    (3, 0, 4),
    (3, 4, 7),
  ]
  (verts, faces)
}

///|
test "mesh union" {
  let (va, fa) = make_cube()
  let (vb, fb) = make_cube2()
  let result = mesh_union(va, fa, vb, fb)
  assert_true(result.vertices.length() > 0)
  assert_true(result.faces.length() > 0)
}

///|
test "mesh intersection" {
  let (va, fa) = make_cube()
  let (vb, fb) = make_cube2()
  let result = mesh_intersection(va, fa, vb, fb)
  assert_true(result.faces.length() > 0)
}

///|
test "mesh difference" {
  let (va, fa) = make_cube()
  let (vb, fb) = make_cube2()
  let result = mesh_difference(va, fa, vb, fb)
  assert_true(result.faces.length() > 0)
}

///|
fn make_tet_a() -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let v = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let f = [(0, 2, 1), (0, 1, 3), (0, 3, 2), (1, 2, 3)]
  (v, f)
}

///|
fn make_tet_b() -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let v = [
    @core.Point3D::new(10.0, 10.0, 10.0),
    @core.Point3D::new(11.0, 10.0, 10.0),
    @core.Point3D::new(10.0, 11.0, 10.0),
    @core.Point3D::new(10.0, 10.0, 11.0),
  ]
  let f = [(0, 2, 1), (0, 1, 3), (0, 3, 2), (1, 2, 3)]
  (v, f)
}

///|
test "mesh union disjoint" {
  let (va, fa) = make_tet_a()
  let (vb, fb) = make_tet_b()
  let result = mesh_union(va, fa, vb, fb)
  assert_eq(result.vertices.length(), 8)
  assert_eq(result.faces.length(), 8)
}

///|
test "mesh difference disjoint" {
  let (va, fa) = make_tet_a()
  let (vb, fb) = make_tet_b()
  let result = mesh_difference(va, fa, vb, fb)
  assert_eq(result.faces.length(), 4)
}

///|
test "mesh bool result construct" {
  let r = MeshBoolResult::new([], [])
  assert_eq(r.vertices.length(), 0)
  assert_eq(r.faces.length(), 0)
}
