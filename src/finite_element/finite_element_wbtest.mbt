test "element_stiffness" {
  let s = element_stiffness((1.0, 0.0), (1.0, 0.0), 0.5)
  assert_true((s - 0.5).abs() < 0.001)
}

test "element_mass" {
  let m = element_mass(1.0, 1.0, 0.5)
  assert_true((m - 0.166667).abs() < 0.001)
}

test "fem_l2_error" {
  let e = fem_l2_error([1.0, 2.0], [1.0, 2.0])
  assert_true(e.abs() < 0.001)
}
