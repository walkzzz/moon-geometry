test "connectivity threshold" {
  let r = connectivity_threshold(100, 1.0)
  assert_true(r > 0.0)
}

test "percolation threshold" {
  assert_eq(percolation_threshold_2d(), 0.5)
}

test "expected degree" {
  let d = expected_degree(10, 0.5, 1.0)
  assert_true(d > 0.0)
}
test "coverage threshold" {
  let r = coverage_threshold(100, 1.0)
  assert_true(r > 0.0)
  let r2 = coverage_threshold(1000, 2.0)
  assert_true(r2 > 0.0 && r2 < r)
}

test "isolation probability" {
  let p = isolation_probability(10, 0.1, 1.0)
  assert_true(p >= 0.0 && p <= 1.0)
  let p2 = isolation_probability(100, 0.5, 1.0)
  assert_true(p2 >= 0.0 && p2 <= 1.0)
  assert_true(p2 < p)
}

test "expected degree zero radius" {
  let d = expected_degree(10, 0.0, 1.0)
  assert_true(d == 0.0)
}
