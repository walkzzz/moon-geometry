test "bernstein basic" {
  let b0 = bernstein(0, 2, 0.0)
  assert_true((b0 - 1.0).abs() < 0.0001)
  let b2 = bernstein(2, 2, 1.0)
  assert_true((b2 - 1.0).abs() < 0.0001)
  let b1 = bernstein(1, 2, 0.5)
  assert_true((b1 - 0.5).abs() < 0.0001)
}

test "bezier_curve endpoints" {
  let pts = [(0.0, 0.0, 0.0), (1.0, 1.0, 0.0), (2.0, 0.0, 0.0)]
  let (x0, _, _) = bezier_curve(pts, 0.0)
  assert_true(x0.abs() < 0.0001)
  let (x1, _, _) = bezier_curve(pts, 1.0)
  assert_true((x1 - 2.0).abs() < 0.0001)
}

test "bezier_curve midpoint" {
  let pts = [(0.0, 0.0, 0.0), (1.0, 1.0, 0.0)]
  let (x, y, _) = bezier_curve(pts, 0.5)
  assert_true((x - 0.5).abs() < 0.0001)
  assert_true((y - 0.5).abs() < 0.0001)
}

test "bezier_surface corners" {
  let net = [
    [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)],
    [(0.0, 1.0, 0.0), (1.0, 1.0, 1.0)],
  ]
  let (x00, y00, _) = bezier_surface(net, 0.0, 0.0)
  assert_true(x00.abs() < 0.0001)
  assert_true(y00.abs() < 0.0001)
  let (x11, y11, z11) = bezier_surface(net, 1.0, 1.0)
  assert_true((x11 - 1.0).abs() < 0.0001)
  assert_true((y11 - 1.0).abs() < 0.0001)
  assert_true((z11 - 1.0).abs() < 0.0001)
}

test "bezier_surface_decasteljau matches" {
  let net = [
    [(0.0, 0.0, 0.0), (1.0, 0.0, 1.0)],
    [(0.0, 1.0, 1.0), (1.0, 1.0, 0.0)],
  ]
  let (x1, y1, z1) = bezier_surface(net, 0.3, 0.7)
  let (x2, y2, z2) = bezier_surface_decasteljau(net, 0.3, 0.7)
  assert_true((x1 - x2).abs() < 0.0001)
  assert_true((y1 - y2).abs() < 0.0001)
  assert_true((z1 - z2).abs() < 0.0001)
}

test "bezier_curve_derivative linear" {
  let pts = [(0.0, 0.0, 0.0), (2.0, 0.0, 0.0)]
  let (dx, _, _) = bezier_curve_derivative(pts, 0.5)
  assert_true((dx - 2.0).abs() < 0.0001)
}

test "bezier_degree_elevate basic" {
  let pts = [(0.0, 0.0, 0.0), (1.0, 1.0, 0.0)]
  let elevated = bezier_degree_elevate(pts)
  assert_eq(elevated.length(), 3)
  let (x0, _, _) = elevated[0]
  assert_true(x0.abs() < 0.0001)
  let (x2, _, _) = elevated[2]
  assert_true((x2 - 1.0).abs() < 0.0001)
}