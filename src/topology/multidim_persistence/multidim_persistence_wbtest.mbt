test "multidim_barcode" {
  let bc = multidim_barcode([(0.0, 0.0)], [(2.0, 3.0)])
  assert_eq(bc.length(), 1)
}

test "multidim_persistence" {
  let bc = multidim_barcode([(0.0, 0.0)], [(2.0, 3.0)])
  let p = multidim_persistence(bc)
  assert_true((p[0] - 2.0).abs() < 0.001)
}

test "rank_invariant" {
  assert_eq(rank_invariant((0, 0), (2, 3)), 1)
  assert_eq(rank_invariant((2, 0), (1, 3)), 0)
}
