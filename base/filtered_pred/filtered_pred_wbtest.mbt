///|
test "static filter bound" {
  let b = static_filter_bound([1.0, 2.0, 3.0])
  assert_true(b > 0.0)
}

///|
test "filtered orientation" {
  let r = filtered_orientation(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

///|
test "filter result" {
  assert_eq(filter_result(5.0, 1.0), 1)
  assert_eq(filter_result(-5.0, 1.0), -1)
}

///|
test "static filter bound empty" {
  let b = static_filter_bound([])
  assert_eq(b, 0.0)
}

///|
test "static filter bound negative" {
  let b = static_filter_bound([-2.0, -4.0])
  assert_true(b > 0.0)
}

///|
test "static filter bound zero" {
  let b = static_filter_bound([0.0, 0.0, 0.0])
  assert_eq(b, 0.0)
}

///|
test "filtered orientation negative" {
  let r = filtered_orientation(0.0, 0.0, 0.0, 1.0, 1.0, 0.0)
  assert_eq(r, -1)
}

///|
test "filtered orientation collinear" {
  let r = filtered_orientation(0.0, 0.0, 1.0, 1.0, 2.0, 2.0)
  assert_eq(r, 0)
}

///|
test "dynamic filter true" {
  assert_true(dynamic_filter(10.0, 1.0, 0.5))
}

///|
test "dynamic filter false" {
  assert_true(!dynamic_filter(0.1, 10.0, 0.5))
}

///|
test "dynamic filter negative a" {
  assert_true(dynamic_filter(-10.0, 1.0, 0.5))
}

///|
test "filter result zero" {
  assert_eq(filter_result(0.5, 1.0), 0)
  assert_eq(filter_result(0.0, 1.0), 0)
}
