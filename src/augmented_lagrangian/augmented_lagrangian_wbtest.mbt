test "AugLagConfig::new" {
  let config = AugLagConfig::new(10.0, 10.0, 100, 0.0001)
  assert_true((config.rho - 10.0).abs() < 0.001)
}

test "aug_lagrangian" {
  let val = aug_lagrangian(1.0, [2.0], [0.5], 10.0)
  assert_true(val > 1.0)
}

test "constraint_violation" {
  let v = constraint_violation([3.0, 4.0])
  assert_true((v - 5.0).abs() < 0.001)
}
