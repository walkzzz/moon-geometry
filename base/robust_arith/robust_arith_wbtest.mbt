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
test "fast two sum" {
  let (s, err) = fast_two_sum(1.0, 1.0e-15)
  assert_true(s > 1.0)
  assert_true(err.abs() < 1.0e-10)
}

test "grow expansion" {
  let r = grow_expansion([1.0, 2.0, 3.0], 4.0)
  assert_eq(r.length(), 4)
  let s = expansion_sum(r)
  assert_true((s - 10.0).abs() < 0.0001)
}

test "grow expansion single" {
  let r = grow_expansion([1.0], 2.0)
  assert_eq(r.length(), 2)
  let s = expansion_sum(r)
  assert_true((s - 3.0).abs() < 0.0001)
}
