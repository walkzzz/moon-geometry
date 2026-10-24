///|
test "bresenham_line horizontal" {
  let pts = bresenham_line(0, 0, 2, 0)
  assert_eq(pts.length(), 3)
}

///|
test "edge_function" {
  let e = edge_function((0.0, 0.0), (1.0, 0.0), (0.0, 1.0))
  assert_true(e.abs() > 0.99 && e.abs() < 1.01)
}

///|
test "point_in_triangle" {
  let v = point_in_triangle((0.25, 0.25), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0))
  assert_true(v)
}

///|
test "bresenham_line vertical" {
  let pts = bresenham_line(0, 0, 0, 2)
  assert_eq(pts.length(), 3)
  assert_eq(pts[0], (0, 0))
  assert_eq(pts[2], (0, 2))
}

///|
test "bresenham_line diagonal" {
  let pts = bresenham_line(0, 0, 2, 2)
  assert_eq(pts.length(), 3)
  assert_eq(pts[0], (0, 0))
  assert_eq(pts[2], (2, 2))
}

///|
test "bresenham_line reverse" {
  let pts = bresenham_line(2, 2, 0, 0)
  assert_eq(pts.length(), 3)
  assert_eq(pts[0], (2, 2))
  assert_eq(pts[2], (0, 0))
}

///|
test "bresenham_line single point" {
  let pts = bresenham_line(1, 1, 1, 1)
  assert_eq(pts.length(), 1)
  assert_eq(pts[0], (1, 1))
}

///|
test "barycentric_coord center" {
  let (u, v, w) = barycentric_coord(
    (1.0 / 3.0, 1.0 / 3.0),
    (0.0, 0.0),
    (1.0, 0.0),
    (0.0, 1.0),
  )
  assert_true((u - 1.0 / 3.0).abs() < 0.0001)
  assert_true((v - 1.0 / 3.0).abs() < 0.0001)
  assert_true((w - 1.0 / 3.0).abs() < 0.0001)
}

///|
test "barycentric_coord vertex" {
  let (u, v, w) = barycentric_coord(
    (0.0, 0.0),
    (0.0, 0.0),
    (1.0, 0.0),
    (0.0, 1.0),
  )
  assert_true((u - 1.0).abs() < 0.0001)
  assert_true((v - 0.0).abs() < 0.0001)
  assert_true((w - 0.0).abs() < 0.0001)
}

///|
test "barycentric_coord degenerate" {
  let (u, v, w) = barycentric_coord(
    (0.5, 0.0),
    (0.0, 0.0),
    (1.0, 0.0),
    (2.0, 0.0),
  )
  assert_true((u - 0.0).abs() < 0.0001)
  assert_true((v - 0.0).abs() < 0.0001)
  assert_true((w - 0.0).abs() < 0.0001)
}

///|
test "point_in_triangle outside" {
  let v = point_in_triangle((2.0, 2.0), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0))
  assert_true(!v)
}

///|
test "edge_function collinear" {
  let e = edge_function((0.0, 0.0), (1.0, 0.0), (2.0, 0.0))
  assert_true((e - 0.0).abs() < 0.0001)
}
