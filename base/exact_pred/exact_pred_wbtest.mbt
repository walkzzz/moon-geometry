///|
test "exact orientation" {
  let r = exact_orientation(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

///|
test "exact collinear" {
  assert_true(exact_collinear(0.0, 0.0, 1.0, 1.0, 2.0, 2.0))
}

///|
test "exact left of line" {
  assert_true(exact_left_of_line(0.0, 1.0, 0.0, 0.0, 1.0, 0.0))
}

///|
test "exact orientation cw" {
  assert_eq(exact_orientation(0.0, 0.0, 0.0, 1.0, 1.0, 0.0), -1)
}

///|
test "exact orientation collinear" {
  assert_eq(exact_orientation(0.0, 0.0, 1.0, 0.0, 2.0, 0.0), 0)
}

///|
test "exact collinear false" {
  assert_false(exact_collinear(0.0, 0.0, 1.0, 0.0, 0.0, 1.0))
}

///|
test "exact left of line false" {
  assert_false(exact_left_of_line(0.0, -1.0, 0.0, 0.0, 1.0, 0.0))
}

///|
test "exact incircle inside" {
  assert_eq(exact_incircle(0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.5, 0.5), 1)
}

///|
test "exact incircle outside" {
  assert_eq(exact_incircle(0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 2.0, 2.0), -1)
}

///|
test "exact incircle on circle" {
  assert_eq(exact_incircle(0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0), 0)
}
