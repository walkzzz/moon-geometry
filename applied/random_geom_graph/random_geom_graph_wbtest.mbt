///|
test "connectivity threshold" {
  let r = connectivity_threshold(100, 1.0)
  assert_true(r > 0.0)
}

///|
test "percolation threshold" {
  assert_eq(percolation_threshold_2d(), 0.5)
}

///|
test "expected degree" {
  let d = expected_degree(10, 0.5, 1.0)
  assert_true(d > 0.0)
}

///|
test "coverage threshold" {
  let r = coverage_threshold(100, 1.0)
  assert_true(r > 0.0)
}

///|
test "coverage threshold decreases with n" {
  let r1 = coverage_threshold(100, 1.0)
  let r2 = coverage_threshold(10000, 1.0)
  assert_true(r2 < r1)
}

///|
test "isolation probability" {
  let p = isolation_probability(100, 0.1, 1.0)
  assert_true(p >= 0.0)
  assert_true(p <= 1.0)
}

///|
test "isolation probability small radius" {
  let p = isolation_probability(10, 0.0, 1.0)
  assert_true((p - 1.0).abs() < 0.000000001)
}
