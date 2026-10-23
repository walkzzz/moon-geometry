///|
test "level_set_sign" {
  assert_eq(level_set_sign(1.0), 1)
  assert_eq(level_set_sign(-1.0), -1)
  assert_eq(level_set_sign(0.0), 0)
}

///|
test "level_set_normal" {
  let (nx, ny) = level_set_normal((3.0, 4.0))
  assert_true((nx - 0.6).abs() < 0.001)
  assert_true((ny - 0.8).abs() < 0.001)
}

///|
test "level_set_area" {
  let a = level_set_area([-1.0, -1.0, 1.0, 1.0], 1.0)
  assert_true((a - 2.0).abs() < 0.001)
}
