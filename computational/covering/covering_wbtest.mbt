test "min_enclosing_circle basic" {
  let pts = [(0.0, 0.0), (2.0, 0.0), (0.0, 2.0)]
  let (cx, cy, r) = min_enclosing_circle(pts)
  assert_true((cx - 1.0).abs() < 0.1)
  assert_true((cy - 1.0).abs() < 0.1)
  assert_true((r - 1.4142).abs() < 0.1)
}

test "greedy_cover basic" {
  let pts = [(0.0, 0.0), (1.0, 0.0), (5.0, 0.0), (6.0, 0.0)]
  let centers = greedy_cover(pts, 1.5)
  assert_true(centers.length() >= 1)
}

test "covering_radius basic" {
  let pts = [(0.0, 0.0), (2.0, 0.0)]
  let r = covering_radius(pts, 1)
  assert_true((r - 1.0).abs() < 0.1)
}

test "min_enclosing_circle single" {
  let pts = [(3.0, 4.0)]
  let (cx, cy, r) = min_enclosing_circle(pts)
  assert_true((cx - 3.0).abs() < 0.001)
  assert_true((cy - 4.0).abs() < 0.001)
  assert_true(r.abs() < 0.001)
}