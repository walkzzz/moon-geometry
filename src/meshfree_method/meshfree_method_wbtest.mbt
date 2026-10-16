test "sph_kernel" {
  let k = sph_kernel(0.0, 1.0)
  assert_true(k > 0.0)
}

test "sph_kernel compact" {
  let k = sph_kernel(3.0, 1.0)
  assert_true(k.abs() < 0.001)
}

test "rbf_gaussian" {
  let v = rbf_gaussian(0.0, 1.0)
  assert_true((v - 1.0).abs() < 0.001)
}
