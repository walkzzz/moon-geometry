test "gaussian_log_likelihood" {
  let ll = gaussian_log_likelihood(0.0, 0.0, 1.0)
  assert_true(ll < 0.0)
}
test "posterior_mean" {
  let pm = posterior_mean(0.0, 1.0, 1.0, 1.0)
  assert_true(pm > 0.49 && pm < 0.51)
}
test "posterior_var" {
  let pv = posterior_var(1.0, 1.0)
  assert_true(pv > 0.49 && pv < 0.51)
}
test "bayes_update" {
  let p = bayes_update(0.5, 0.8, 0.5)
  assert_true(p > 0.79 && p < 0.81)
}
