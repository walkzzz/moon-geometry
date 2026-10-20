test "bezout_count" {
  assert_eq(bezout_count(2, 3), 6)
}

test "bezout_with_multiplicities" {
  assert_eq(bezout_with_multiplicities([2, 3, 4]), 24)
}

test "bezout_excess" {
  assert_eq(bezout_excess(6, 4), 2)
}
