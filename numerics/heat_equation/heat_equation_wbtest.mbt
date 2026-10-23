///|
test "heat_explicit_step" {
  let u = heat_explicit_step([0.0, 1.0, 0.0], 1.0, 0.01, 1.0)
  assert_eq(u.length(), 3)
}

///|
test "heat_steady_state_1d" {
  let u = heat_steady_state_1d(0.0, 1.0, 3)
  assert_true(u[0].abs() < 0.001)
  assert_true(u[2] > 0.99 && u[2] < 1.01)
}

///|
test "heat_analytical_1d" {
  let v = heat_analytical_1d(0.5, 0.0, 1.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
