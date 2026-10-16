test "rrt_distance" {
  let d = rrt_distance((0.0, 0.0), (3.0, 4.0))
  assert_true(d > 4.99 && d < 5.01)
}
test "rrt_steer" {
  let p = rrt_steer((0.0, 0.0), (10.0, 0.0), 1.0)
  assert_true(p.0 > 0.99 && p.0 < 1.01)
}
test "rrt_rewire_radius" {
  let r = rrt_rewire_radius(100, 2, 100.0)
  assert_true(r > 0.0)
}
