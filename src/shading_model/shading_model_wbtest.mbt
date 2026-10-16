test "lambertian" {
  let v = lambertian((0.0, 0.0, 1.0), (0.0, 0.0, 1.0))
  assert_true(v > 0.99 && v < 1.01)
}
test "lambertian back" {
  let v = lambertian((0.0, 0.0, 1.0), (0.0, 0.0, -1.0))
  assert_true(v.abs() < 0.001)
}
test "phong" {
  let v = phong((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0), 32.0)
  assert_true(v > 1.0)
}
