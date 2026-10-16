fn make_cube_faces() -> Array[Array[Int]] {
  [
    [0, 3, 2, 1],
    [4, 5, 6, 7],
    [0, 1, 5, 4],
    [1, 2, 6, 5],
    [2, 3, 7, 6],
    [3, 0, 4, 7],
  ]
}

fn make_cube_verts() -> Array[@core.Point3D] {
  [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
    @core.Point3D::new(0.0, 1.0, 1.0),
  ]
}

fn make_cube2_verts() -> Array[@core.Point3D] {
  [
    @core.Point3D::new(0.5, 0.5, 0.5),
    @core.Point3D::new(1.5, 0.5, 0.5),
    @core.Point3D::new(1.5, 1.5, 0.5),
    @core.Point3D::new(0.5, 1.5, 0.5),
    @core.Point3D::new(0.5, 0.5, 1.5),
    @core.Point3D::new(1.5, 0.5, 1.5),
    @core.Point3D::new(1.5, 1.5, 1.5),
    @core.Point3D::new(0.5, 1.5, 1.5),
  ]
}

test "polyhedron union" {
  let va = make_cube_verts()
  let fa = make_cube_faces()
  let vb = make_cube2_verts()
  let fb = make_cube_faces()
  let result = polyhedron_union(va, fa, vb, fb)
  assert_true(result.success)
  assert_true(result.vertices.length() > 0)
}

test "polyhedron intersection" {
  let va = make_cube_verts()
  let fa = make_cube_faces()
  let vb = make_cube2_verts()
  let fb = make_cube_faces()
  let result = polyhedron_intersection(va, fa, vb, fb)
  assert_true(result.success)
}

test "polyhedron difference" {
  let va = make_cube_verts()
  let fa = make_cube_faces()
  let vb = make_cube2_verts()
  let fb = make_cube_faces()
  let result = polyhedron_difference(va, fa, vb, fb)
  assert_true(result.success)
}

fn make_tet_verts() -> Array[@core.Point3D] {
  [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
}

fn make_tet_faces() -> Array[Array[Int]] {
  [[0, 2, 1], [0, 1, 3], [0, 3, 2], [1, 2, 3]]
}

fn make_tet2_verts() -> Array[@core.Point3D] {
  [
    @core.Point3D::new(10.0, 10.0, 10.0),
    @core.Point3D::new(11.0, 10.0, 10.0),
    @core.Point3D::new(10.0, 11.0, 10.0),
    @core.Point3D::new(10.0, 10.0, 11.0),
  ]
}

test "polyhedron union disjoint" {
  let va = make_tet_verts()
  let fa = make_tet_faces()
  let vb = make_tet2_verts()
  let fb = make_tet_faces()
  let result = polyhedron_union(va, fa, vb, fb)
  assert_eq(result.vertices.length(), 8)
  assert_eq(result.faces.length(), 8)
}

test "polyhedron difference disjoint" {
  let va = make_tet_verts()
  let fa = make_tet_faces()
  let vb = make_tet2_verts()
  let fb = make_tet_faces()
  let result = polyhedron_difference(va, fa, vb, fb)
  assert_eq(result.faces.length(), 4)
}

test "poly bool result construct" {
  let r = PolyBoolResult::new([], [], true)
  assert_true(r.success)
}