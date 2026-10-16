test "conformal_factor" {
  assert_true((conformal_factor(2.0, 4.0) - 2.0).abs() < 0.001)
}

test "is_conformal" {
  assert_true(is_conformal(2.0, 0.0, 0.0, 2.0, 0.001))
  assert_false(is_conformal(2.0, 1.0, 0.0, 2.0, 0.001))
}

test "conformal_energy" {
  assert_true(conformal_energy(2.0, 2.0).abs() < 0.001)
}
