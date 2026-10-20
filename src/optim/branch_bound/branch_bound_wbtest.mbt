test "BranchBoundConfig::new" {
  let config = BranchBoundConfig::new(0.001, 1000)
  assert_true((config.tol - 0.001).abs() < 0.0001)
}

test "lower_bound" {
  let f = fn(x : Double) -> Double { x * x }
  let lb = lower_bound(f, -1.0, 1.0)
  assert_true(lb <= 0.01)
}

test "branch_interval" {
  let ((lo1, hi1), (lo2, hi2)) = branch_interval(0.0, 4.0)
  assert_true((lo1 - 0.0).abs() < 0.001)
  assert_true((hi1 - 2.0).abs() < 0.001)
  assert_true((lo2 - 2.0).abs() < 0.001)
  assert_true((hi2 - 4.0).abs() < 0.001)
}

test "bb_converged" {
  assert_true(bb_converged(1.0, 1.0001, 0.001))
}
