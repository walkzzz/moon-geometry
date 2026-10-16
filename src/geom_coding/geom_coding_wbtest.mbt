test "sphere packing density sc" {
  let d = sphere_packing_density_sc()
  assert_true(d > 0.52 && d < 0.53)
}

test "kissing number" {
  assert_eq(kissing_number_2d(), 6)
  assert_eq(kissing_number_3d(), 12)
}

test "hamming bound" {
  let b = hamming_bound(7, 3, 1)
  assert_true(b > 0.0)
}
