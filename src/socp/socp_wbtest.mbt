test "SocpConfig::new" {
  let config = SocpConfig::new(100, 0.0001)
  assert_eq(config.max_iter, 100)
}

test "soc_constraint" {
  assert_true(soc_constraint([3.0, 4.0], 6.0))
  assert_false(soc_constraint([3.0, 4.0], 4.0))
}

test "soc_slack" {
  let s = soc_slack([3.0, 4.0], 6.0)
  assert_true((s - 1.0).abs() < 0.001)
}
