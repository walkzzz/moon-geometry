///|
test "isoperimetric ratio" {
  let r = isoperimetric_ratio(2.0 * @math.PI, @math.PI)
  assert_true(r > 0.99 && r < 1.01)
}

///|
test "circle area from perimeter" {
  let a = circle_area_from_perimeter(2.0 * @math.PI)
  assert_true(a > 3.13 && a < 3.15)
}

///|
test "is isoperimetric optimal" {
  assert_true(is_isoperimetric_optimal(2.0 * @math.PI, @math.PI))
}
