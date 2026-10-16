test "ricci_flow_step" {
  let r = ricci_flow_step([1.0, 2.0], [0.0, 0.0], 0.1)
  assert_true((r[0] - 0.9).abs() < 0.001)
}

test "ricci_energy" {
  let e = ricci_energy([1.0, 2.0], [1.0, 2.0])
  assert_true(e.abs() < 0.001)
}

test "target_curvature_uniform" {
  let t = target_curvature_uniform(4, 12.566370614359172)
  assert_true((t[0] - 3.141592653589793).abs() < 0.001)
}
