test "reachability_map" {
  let n = reachability_map([(0.0, 3.14159), (0.0, 3.14159)], 10)
  assert_eq(n, 100)
}
test "workspace_volume" {
  let v = workspace_volume((0.0, 1.0, 0.0, 1.0, 0.0, 1.0))
  assert_true(v > 0.99 && v < 1.01)
}
test "dexterity_index" {
  let d = dexterity_index(0.5, 1.0)
  assert_true(d > 0.49 && d < 0.51)
}
