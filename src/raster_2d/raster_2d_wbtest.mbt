test "bresenham_line horizontal" {
  let pts = bresenham_line(0, 0, 2, 0)
  assert_eq(pts.length(), 3)
}
test "edge_function" {
  let e = edge_function((0.0, 0.0), (1.0, 0.0), (0.0, 1.0))
  assert_true(e.abs() > 0.99 && e.abs() < 1.01)
}
test "point_in_triangle" {
  let v = point_in_triangle((0.25, 0.25), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0))
  assert_true(v)
}
