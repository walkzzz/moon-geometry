test "trajectory_length" {
  let l = trajectory_length([(0.0, 0.0), (3.0, 4.0)])
  assert_true(l > 4.99 && l < 5.01)
}
test "trajectory_smoothness line" {
  let s = trajectory_smoothness([(0.0, 0.0), (1.0, 0.0), (2.0, 0.0)])
  assert_true(s.abs() < 0.001)
}
test "bezier_point start" {
  let p = bezier_point((0.0, 0.0), (1.0, 1.0), (2.0, 0.0), 0.0)
  assert_true(p.0.abs() < 0.001 && p.1.abs() < 0.001)
}
