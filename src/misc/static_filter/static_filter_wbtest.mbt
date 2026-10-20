test "epsilon bound" {
  let e = epsilon_bound(3)
  assert_true(e > 0.0)
}

test "orient2d bound" {
  let b = orient2d_bound(10.0)
  assert_true(b > 0.0)
}

test "filter pass" {
  assert_true(filter_pass(10.0, 1.0))
  assert_true(!filter_pass(0.5, 1.0))
}
