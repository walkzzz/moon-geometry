///|
test "Rational::new" {
  let r = Rational::new(1, 2)
  assert_true((rational_to_double(r) - 0.5).abs() < 0.001)
}

///|
test "rational_add" {
  let r = rational_add(Rational::new(1, 2), Rational::new(1, 3))
  assert_true((rational_to_double(r) - 0.833333).abs() < 0.001)
}

///|
test "rational_mul" {
  let r = rational_mul(Rational::new(2, 3), Rational::new(3, 4))
  assert_true((rational_to_double(r) - 0.5).abs() < 0.001)
}

///|
test "rational_equal" {
  assert_true(rational_equal(Rational::new(1, 2), Rational::new(2, 4)))
}

///|
test "rational_sub" {
  let r = rational_sub(Rational::new(1, 2), Rational::new(1, 3))
  assert_true((rational_to_double(r) - 0.166667).abs() < 0.001)
}

///|
test "Rational::new_zero_den" {
  let r = Rational::new(1, 0)
  assert_true(rational_to_double(r) == 0.0)
}

///|
test "rational_to_double" {
  let r = Rational::new(3, 4)
  assert_true((rational_to_double(r) - 0.75).abs() < 0.001)
}

///|
test "rational_equal_not_equal" {
  assert_false(rational_equal(Rational::new(1, 2), Rational::new(1, 3)))
}

///|
test "rational_add_negative" {
  let r = rational_add(Rational::new(-1, 2), Rational::new(1, 2))
  assert_true(rational_to_double(r) == 0.0)
}

///|
test "rational_mul_zero" {
  let r = rational_mul(Rational::new(0, 1), Rational::new(3, 4))
  assert_true(rational_to_double(r) == 0.0)
}

///|
test "rational_sub_same" {
  let r = rational_sub(Rational::new(3, 4), Rational::new(3, 4))
  assert_true(rational_to_double(r) == 0.0)
}
