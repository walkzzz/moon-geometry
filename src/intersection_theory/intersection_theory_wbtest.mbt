test "intersection_number" {
  assert_eq(intersection_number([2, 3]), 6)
  assert_eq(intersection_number([2, 2, 2]), 8)
}

test "bezout_bound" {
  assert_eq(bezout_bound(3, 4), 12)
}

test "is_transverse" {
  assert_true(is_transverse(2, 2))
  assert_false(is_transverse(1, 2))
}
