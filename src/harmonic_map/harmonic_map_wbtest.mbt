test "dirichlet_energy" {
  let e = dirichlet_energy([1.0, 2.0], [[2.0], [1.0]])
  assert_true((e - 1.0).abs() < 0.001)
}

test "harmonic_residual" {
  let r = harmonic_residual([0.0, 0.0])
  assert_true(r.abs() < 0.001)
}

test "laplacian_smooth" {
  let r = laplacian_smooth([1.0, 2.0], [0.5, -0.5], 0.1)
  assert_true((r[0] - 1.05).abs() < 0.001)
}
