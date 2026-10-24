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

///|
test "isoperimetric deficit" {
  let d = isoperimetric_deficit(2.0 * @math.PI, @math.PI)
  assert_true(d.abs() < 0.0000000001)
}

///|
test "isoperimetric deficit non optimal" {
  let d = isoperimetric_deficit(10.0, 1.0)
  assert_true(d > 0.0)
}

///|
test "circle perimeter from area" {
  let p = circle_perimeter_from_area(@math.PI)
  assert_true((p - 2.0 * @math.PI).abs() < 0.001)
}

///|
test "optimal shape area" {
  let a = optimal_shape_area(2.0 * @math.PI)
  assert_true((a - @math.PI).abs() < 0.001)
}

///|
test "isoperimetric ratio square" {
  let r = isoperimetric_ratio(8.0, 4.0)
  assert_true(r > 0.0 && r < 1.0)
}

///|
test "circle area from perimeter zero" {
  let a = circle_area_from_perimeter(0.0)
  assert_true(a.abs() < 0.000000001)
}

///|
test "is isoperimetric optimal non optimal" {
  assert_false(is_isoperimetric_optimal(10.0, 1.0))
}

///|
test "circle perimeter from area zero" {
  let p = circle_perimeter_from_area(0.0)
  assert_true(p.abs() < 0.000000001)
}

///|
test "optimal shape area large perimeter" {
  let a = optimal_shape_area(100.0)
  let expected_r = 100.0 / (2.0 * @math.PI)
  let expected_a = @math.PI * expected_r * expected_r
  assert_true((a - expected_a).abs() < 0.001)
}
