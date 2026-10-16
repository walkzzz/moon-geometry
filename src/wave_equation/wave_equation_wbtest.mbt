test "wave_explicit_step" {
  let u = wave_explicit_step([0.0, 0.0, 0.0], [0.0, 1.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}
test "wave_damping" {
  let v = wave_damping(1.0, 0.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
