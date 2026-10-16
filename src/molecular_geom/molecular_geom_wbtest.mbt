test "bond length" {
  let l = bond_length(0.0, 0.0, 0.0, 1.0, 0.0, 0.0)
  assert_eq(l, 1.0)
}

test "bond angle" {
  let a = bond_angle(1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0)
  assert_true((a - 1.5707963267948966).abs() < 1.0e-10)
}

test "rmsd" {
  let r = rmsd([(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)], [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)])
  assert_eq(r, 0.0)
}
