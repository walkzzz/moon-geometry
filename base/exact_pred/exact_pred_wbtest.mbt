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
