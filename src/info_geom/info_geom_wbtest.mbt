test "fisher metric gaussian" {
  let (g11, g22) = fisher_metric_gaussian(0.0, 1.0)
  assert_eq(g11, 1.0)
  assert_eq(g22, 2.0)
}

test "kl divergence" {
  let d = kl_divergence(0.5, 0.5)
  assert_true(d.abs() < 1.0e-10)
}

test "fisher metric bernoulli" {
  let g = fisher_metric_bernoulli(0.5)
  assert_eq(g, 4.0)
}
