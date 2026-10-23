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
