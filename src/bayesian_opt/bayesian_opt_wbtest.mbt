test "BOConfig::new" {
  let config = BOConfig::new(50, 5, -5.0, 5.0)
  assert_eq(config.n_iterations, 50)
}

test "expected_improvement" {
  let ei = expected_improvement(1.0, 0.5, 0.1)
  assert_true(ei > 0.0)
}

test "gaussian_kernel" {
  let k = gaussian_kernel(0.0, 0.0, 1.0)
  assert_true((k - 1.0).abs() < 0.001)
}
