test "dist_3d" {
  let d = dist_3d((0.0, 0.0, 0.0), (1.0, 2.0, 2.0))
  assert_true(d > 2.99 && d < 3.01)
}
test "sphere_collision" {
  let c = sphere_collision((0.0, 0.0, 0.0), (0.5, 0.0, 0.0), 1.0)
  assert_true(c)
}
test "aabb_collision" {
  let c = aabb_collision((0.0, 0.0, 0.0), (1.0, 1.0, 1.0), (0.5, 0.5, 0.5), (2.0, 2.0, 2.0))
  assert_true(c)
}
