test "two sum" {
  let (s, _) = two_sum(1.0, 1.0e-15)
  assert_true(s > 1.0)
}

test "two prod" {
  let (p, _) = two_prod(1.0e100, 1.0e-100)
  assert_true(p > 0.99 && p < 1.01)
}

test "expansion sum" {
  let r = expansion_sum([1.0, 2.0, 3.0])
  assert_eq(r, 6.0)
}
