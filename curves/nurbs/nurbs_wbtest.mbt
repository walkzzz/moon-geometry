///|
test "bspline_basis degree 0" {
  let knots = [0.0, 0.0, 1.0, 1.0]
  let b = bspline_basis(1, 0, 0.5, knots)
  assert_true(b > 0.0)
}

///|
test "bspline_curve_point linear" {
  let pts = [(0.0, 0.0, 0.0), (1.0, 1.0, 0.0)]
  let knots = [0.0, 0.0, 1.0, 1.0]
  let (x, y, _) = bspline_curve_point(pts, 1, 0.5, knots)
  assert_true((x - 0.5).abs() < 0.0001)
  assert_true((y - 0.5).abs() < 0.0001)
}

///|
test "nurbs_curve_point with weights" {
  let pts = [(0.0, 0.0, 0.0), (2.0, 0.0, 0.0)]
  let w = [1.0, 1.0]
  let knots = [0.0, 0.0, 1.0, 1.0]
  let (rx, _, _) = nurbs_curve_point(pts, w, 1, 0.5, knots)
  assert_true(rx >= -0.1 && rx <= 2.1)
}

///|
test "find_span basic" {
  let knots = [0.0, 0.0, 0.0, 0.5, 1.0, 1.0, 1.0]
  let span = find_span(3, 2, 0.3, knots)
  assert_eq(span, 2)
}

///|
test "uniform_knots basic" {
  let knots = uniform_knots(4, 2)
  assert_eq(knots.length(), 7)
  assert_true(knots[0].abs() < 0.0000001)
  assert_true((knots[6] - 1.0).abs() < 0.0000001)
}
