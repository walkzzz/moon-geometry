test "yamabe_energy" {
  let e = yamabe_energy([1.0, 1.0], 1.0)
  assert_true(e.abs() < 0.001)
}

test "yamabe_gradient" {
  let g = yamabe_gradient([2.0, 3.0], 1.0)
  assert_true((g[0] - 2.0).abs() < 0.001)
}

test "constant_curvature_target" {
  assert_true((constant_curvature_target(6.0, 3) - 2.0).abs() < 0.001)
}
