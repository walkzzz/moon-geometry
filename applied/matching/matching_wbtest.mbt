///|
test "nearest_neighbor_match basic" {
  let source = [(0.0, 0.0), (5.0, 5.0)]
  let target = [(0.1, 0.1), (5.1, 5.1)]
  let matches = nearest_neighbor_match(source, target)
  assert_eq(matches[0], 0)
  assert_eq(matches[1], 1)
}

///|
test "hausdorff_distance basic" {
  let a = [(0.0, 0.0), (1.0, 0.0)]
  let b = [(0.0, 1.0), (1.0, 1.0)]
  let h = hausdorff_distance(a, b)
  assert_true((h - 1.0).abs() < 0.001)
}

///|
test "chamfer_distance basic" {
  let a = [(0.0, 0.0)]
  let b = [(1.0, 0.0)]
  let c = chamfer_distance(a, b)
  assert_true((c - 2.0).abs() < 0.001)
}

///|
test "match_points basic" {
  let source = [(0.0, 0.0), (5.0, 5.0)]
  let target = [(0.1, 0.1), (5.1, 5.1)]
  let matches = match_points(source, target, 1.0)
  assert_eq(matches.length(), 2)
}
