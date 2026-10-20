test "SqpConfig::new" {
  let config = SqpConfig::new(100, 0.0001)
  assert_eq(config.max_iter, 100)
}

test "lagrangian" {
  let l = lagrangian(1.0, [2.0, 3.0], [0.5, 0.5])
  assert_true((l - 3.5).abs() < 0.001)
}

test "sqp_converged" {
  assert_true(sqp_converged(0.00001, 0.001))
}
