test "rational_eval" {
  let m = RationalMap::new([1.0, 0.0], [1.0, 1.0])
  assert_true((rational_eval(m, 2.0) - 0.333333).abs() < 0.001)
}

test "rational_degree" {
  let m = RationalMap::new([1.0, 0.0, 1.0], [1.0, 1.0])
  assert_eq(rational_degree(m), 1)
}

test "rational_is_defined" {
  let m = RationalMap::new([1.0], [1.0, -1.0])
  assert_true(rational_is_defined(m, 0.0))
  assert_false(rational_is_defined(m, 1.0))
}
