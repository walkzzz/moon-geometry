test "chebyshev_node" {
  let n = chebyshev_node(4, 0)
  assert_true(n.abs() < 1.01)
}

test "fourier_coeff" {
  let c = fourier_coeff([1.0, 1.0, 1.0, 1.0], 0)
  assert_true((c - 2.0).abs() < 0.001)
}

test "spectral_interp" {
  let v = spectral_interp([1.0, 0.0, 0.0], 0.0)
  assert_true((v - 1.0).abs() < 0.001)
}
