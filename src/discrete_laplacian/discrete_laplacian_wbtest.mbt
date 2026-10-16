test "uniform_laplacian" {
  let l = uniform_laplacian([5.0], [3.0, 7.0])
  assert_true(l.abs() < 0.001)
}

test "cotangent_weight" {
  assert_true((cotangent_weight(1.0, 1.0) - 1.0).abs() < 0.001)
}

test "is_harmonic" {
  assert_true(is_harmonic(0.0001, 0.01))
}
