test "CmaesConfig::new" {
  let config = CmaesConfig::new(5, 20, 1.0, 1000)
  assert_eq(config.dim, 5)
}

test "update_sigma" {
  let s = update_sigma(1.0, 2.0, 5)
  assert_true(s > 0.0)
}

test "cmaes_convergence_check" {
  assert_true(cmaes_convergence_check(0.0001, 0.001))
}
