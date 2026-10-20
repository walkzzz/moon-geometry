test "SdpConfig::new" {
  let config = SdpConfig::new(100, 0.0001)
  assert_eq(config.max_iter, 100)
}

test "is_psd" {
  assert_true(is_psd([1.0, 2.0, 3.0]))
  assert_false(is_psd([1.0, -1.0, 3.0]))
}

test "matrix_trace" {
  let m = [[1.0, 2.0], [3.0, 4.0]]
  assert_true((matrix_trace(m) - 5.0).abs() < 0.001)
}

test "frobenius_norm" {
  let m = [[3.0, 0.0], [0.0, 4.0]]
  assert_true((frobenius_norm(m) - 5.0).abs() < 0.001)
}
