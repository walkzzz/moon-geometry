test "euler characteristic tetrahedron" {
  let m = unit_tetrahedron()
  let chi = euler_characteristic(m)
  assert_eq(chi, 2)
}

test "surface genus" {
  let m = unit_tetrahedron()
  let g = surface_genus(m)
  assert_eq(g, 0)
}

test "is sphere" {
  let m = unit_tetrahedron()
  assert_true(is_sphere(m))
}

test "euler from counts" {
  assert_eq(euler_from_counts(4, 6, 4), 2)
  assert_eq(euler_from_counts(8, 12, 6), 2)
}

test "betti 0" {
  let m = unit_tetrahedron()
  let b0 = betti_0(m)
  assert_eq(b0, 1)
}