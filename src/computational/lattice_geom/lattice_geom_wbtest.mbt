test "bravais lattice volume" {
  let v = bravais_lattice_volume(1.0, 0.0, 0.0, 1.0)
  assert_eq(v, 1.0)
}

test "reciprocal lattice" {
  let (b1x, _, _, b2y) = reciprocal_lattice(1.0, 0.0, 0.0, 1.0)
  assert_eq(b1x, 1.0)
  assert_eq(b2y, 1.0)
}

test "nearest lattice point" {
  let (n1, n2) = nearest_lattice_point(0.4, 0.6, 1.0, 0.0, 0.0, 1.0)
  assert_eq(n1, 0)
  assert_eq(n2, 1)
}
