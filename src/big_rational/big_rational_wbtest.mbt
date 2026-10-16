test "Rational::new" {
  let r = Rational::new(1, 2)
  assert_true((rational_to_double(r) - 0.5).abs() < 0.001)
}

test "rational_add" {
  let r = rational_add(Rational::new(1, 2), Rational::new(1, 3))
  assert_true((rational_to_double(r) - 0.833333).abs() < 0.001)
}

test "rational_mul" {
  let r = rational_mul(Rational::new(2, 3), Rational::new(3, 4))
  assert_true((rational_to_double(r) - 0.5).abs() < 0.001)
}

test "rational_equal" {
  assert_true(rational_equal(Rational::new(1, 2), Rational::new(2, 4)))
}
