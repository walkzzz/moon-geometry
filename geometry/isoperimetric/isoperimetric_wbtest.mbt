test "isoperimetric ratio" {
  let r = isoperimetric_ratio(2.0 * @math.PI, @math.PI)
  assert_true(r > 0.99 && r < 1.01)
}

test "circle area from perimeter" {
  let a = circle_area_from_perimeter(2.0 * @math.PI)
  assert_true(a > 3.13 && a < 3.15)
}

test "is isoperimetric optimal" {
  assert_true(is_isoperimetric_optimal(2.0 * @math.PI, @math.PI))
}
test "isoperimetric deficit" {
  let d = isoperimetric_deficit(2.0 * @math.PI, @math.PI)
  assert_true(d.abs() < 1.0e-9)
  let d2 = isoperimetric_deficit(4.0, 1.0)
  assert_true(d2 > 0.0)
}

test "circle perimeter from area" {
  let p = circle_perimeter_from_area(@math.PI)
  assert_true((p - 2.0 * @math.PI).abs() < 0.001)
  let p2 = circle_perimeter_from_area(4.0 * @math.PI)
  assert_true((p2 - 4.0 * @math.PI).abs() < 0.001)
}

test "optimal shape area" {
  let a = optimal_shape_area(2.0 * @math.PI)
  assert_true((a - @math.PI).abs() < 0.001)
  let a2 = optimal_shape_area(4.0 * @math.PI)
  assert_true((a2 - 4.0 * @math.PI).abs() < 0.001)
}

test "not isoperimetric optimal" {
  assert_true(!is_isoperimetric_optimal(4.0, 1.0))
}
