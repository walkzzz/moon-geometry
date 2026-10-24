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

///|
test "bspline_basis degree 1" {
  let knots = [0.0, 0.0, 1.0, 1.0]
  let b0 = bspline_basis(0, 1, 0.5, knots)
  let b1 = bspline_basis(1, 1, 0.5, knots)
  assert_true(b0.abs() < 0.0001)
  assert_true((b1 - 0.5).abs() < 0.0001)
}

///|
test "bspline_curve_point quadratic" {
  let pts = [(0.0, 0.0, 0.0), (1.0, 2.0, 0.0), (2.0, 0.0, 0.0)]
  let knots = [0.0, 0.0, 0.0, 1.0, 1.0, 1.0]
  let (x, _, _) = bspline_curve_point(pts, 2, 0.5, knots)
  assert_true(x >= -0.1 && x <= 2.1)
}

///|
test "nurbs_curve_point zero weights" {
  let pts = [(0.0, 0.0, 0.0), (1.0, 1.0, 0.0)]
  let w = [0.0, 0.0]
  let knots = [0.0, 0.0, 1.0, 1.0]
  let (x, y, z) = nurbs_curve_point(pts, w, 1, 0.5, knots)
  assert_true(x.abs() < 0.0001)
  assert_true(y.abs() < 0.0001)
  assert_true(z.abs() < 0.0001)
}

///|
test "nurbs_surface_point bilinear" {
  let net = [
    [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)],
    [(0.0, 1.0, 0.0), (1.0, 1.0, 0.0)],
  ]
  let w = [[1.0, 1.0], [1.0, 1.0]]
  let knots_u = [0.0, 0.0, 1.0, 1.0]
  let knots_v = [0.0, 0.0, 1.0, 1.0]
  let (x, y, z) = nurbs_surface_point(net, w, 1, 1, 0.5, 0.5, knots_u, knots_v)
  assert_true((x - 1.0).abs() < 0.0001)
  assert_true((y - 1.0).abs() < 0.0001)
  assert_true(z.abs() < 0.0001)
}

///|
test "find_span at upper bound" {
  let knots = [0.0, 0.0, 0.0, 0.5, 1.0, 1.0, 1.0]
  let span = find_span(3, 2, 1.0, knots)
  assert_eq(span, 3)
}

///|
test "find_span at lower bound" {
  let knots = [0.0, 0.0, 0.0, 0.5, 1.0, 1.0, 1.0]
  let span = find_span(3, 2, 0.0, knots)
  assert_eq(span, 2)
}

///|
test "uniform_knots cubic" {
  let knots = uniform_knots(5, 3)
  assert_eq(knots.length(), 9)
  assert_true(knots[0].abs() < 0.0000001)
  assert_true((knots[8] - 1.0).abs() < 0.0000001)
}
