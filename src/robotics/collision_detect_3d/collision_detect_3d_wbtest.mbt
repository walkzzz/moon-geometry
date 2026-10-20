test "sphere_sphere_dist" {
  let d = sphere_sphere_dist((0.0, 0.0, 0.0), 1.0, (3.0, 0.0, 0.0), 1.0)
  assert_true(d > 0.99 && d < 1.01)
}
test "ray_sphere_intersect hit" {
  let t = ray_sphere_intersect((0.0, 0.0, -5.0), (0.0, 0.0, 1.0), (0.0, 0.0, 0.0), 1.0)
  assert_true(t > 3.99 && t < 4.01)
}
test "ray_sphere_intersect miss" {
  let t = ray_sphere_intersect((0.0, 0.0, -5.0), (0.0, 1.0, 0.0), (0.0, 0.0, 0.0), 1.0)
  assert_true(t < 0.0)
}
