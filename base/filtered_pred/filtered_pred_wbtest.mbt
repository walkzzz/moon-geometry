test "static filter bound" {
  let b = static_filter_bound([1.0, 2.0, 3.0])
  assert_true(b > 0.0)
}

test "filtered orientation" {
  let r = filtered_orientation(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

test "filter result" {
  assert_eq(filter_result(5.0, 1.0), 1)
  assert_eq(filter_result(-5.0, 1.0), -1)
}
