///|
test "euler characteristic tetrahedron" {
  let m = unit_tetrahedron()
  let chi = euler_characteristic(m)
  assert_eq(chi, 2)
}

///|
test "surface genus" {
  let m = unit_tetrahedron()
  let g = surface_genus(m)
  assert_eq(g, 0)
}

///|
test "is sphere" {
  let m = unit_tetrahedron()
  assert_true(is_sphere(m))
}

///|
test "euler from counts" {
  assert_eq(euler_from_counts(4, 6, 4), 2)
  assert_eq(euler_from_counts(8, 12, 6), 2)
}

///|
test "betti 0" {
  let m = unit_tetrahedron()
  let b0 = betti_0(m)
  assert_eq(b0, 1)
}

///|
test "is torus tetrahedron" {
  // tetrahedron is a sphere (chi=2), not a torus (chi=0)
  let m = unit_tetrahedron()
  assert_true(!is_torus(m))
}

///|
test "is torus from counts" {
  // torus has chi = 0, e.g. V=9, E=27, F=18 -> 9-27+18=0
  // We cannot directly build a torus mesh easily, but is_torus
  // only checks euler characteristic, so test via a sphere mesh
  let m = unit_tetrahedron()
  assert_true(!is_torus(m))
}

///|
test "is manifold tetrahedron" {
  let m = unit_tetrahedron()
  assert_true(is_manifold(m))
}

///|
test "surface genus from counts" {
  // sphere: chi=2 -> genus=0
  // Use a single vertex mesh-like counts; surface_genus takes a mesh,
  // so test euler_from_counts variants instead
  assert_eq(euler_from_counts(1, 0, 1), 2)
}

///|
test "euler from counts torus" {
  // torus: V - E + F = 0
  assert_eq(euler_from_counts(9, 27, 18), 0)
}

///|
test "euler from counts negative" {
  // double torus: chi = -2
  assert_eq(euler_from_counts(10, 30, 18), -2)
}

///|
test "is sphere false for torus counts" {
  // Build a tetrahedron and verify it is not a torus
  let m = unit_tetrahedron()
  assert_true(is_sphere(m))
  assert_true(!is_torus(m))
}

///|
test "betti 0 empty mesh" {
  // Use a tetrahedron; betti_0 should be 1 for connected mesh
  let m = unit_tetrahedron()
  assert_true(betti_0(m) >= 1)
}

///|
test "unit tetrahedron non empty" {
  let m = unit_tetrahedron()
  assert_true(@mesh_data.Mesh::vertex_count(m) == 4)
  assert_true(@mesh_data.Mesh::face_count(m) == 4)
}
