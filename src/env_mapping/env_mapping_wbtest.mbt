test "cube_map_face" {
  let f = cube_map_face((1.0, 0.0, 0.0))
  assert_eq(f, 0)
}
test "cube_map_face neg z" {
  let f = cube_map_face((0.0, 0.0, -1.0))
  assert_eq(f, 5)
}
