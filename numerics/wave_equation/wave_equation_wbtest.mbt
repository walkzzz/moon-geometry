///|
test "wave_explicit_step" {
  let u = wave_explicit_step([0.0, 0.0, 0.0], [0.0, 1.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}

///|
test "wave_damping" {
  let v = wave_damping(1.0, 0.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}

///|
test "wave_energy positive" {
  let e = wave_energy([1.0, 2.0, 3.0], [0.0, 0.0, 0.0], 0.1)
  assert_true(e > 0.0)
}

///|
test "wave_energy zero" {
  let e = wave_energy([0.0, 0.0], [0.0, 0.0], 0.1)
  assert_true(e.abs() < 0.0000001)
}

///|
test "wave_energy equal arrays" {
  let e = wave_energy([1.0, 1.0], [1.0, 1.0], 0.1)
  assert_true(e.abs() < 0.0000001)
}

///|
test "wave_explicit_step boundary" {
  let u = wave_explicit_step([0.0, 0.0, 0.0], [1.0, 0.0, 1.0], 1.0, 0.5, 1.0)
  assert_eq(u.length(), 3)
  assert_true((u[0] - 1.75).abs() < 0.001)
  assert_true((u[2] - 1.75).abs() < 0.001)
}

///|
test "wave_explicit_step interior" {
  let u = wave_explicit_step(
    [0.0, 0.0, 0.0, 0.0],
    [0.0, 1.0, 1.0, 0.0],
    1.0,
    0.1,
    1.0,
  )
  assert_eq(u.length(), 4)
}

///|
test "wave_damping decay" {
  let v1 = wave_damping(1.0, 1.0, 0.0)
  let v2 = wave_damping(1.0, 1.0, 1.0)
  assert_true(v2 < v1)
  assert_true((v1 - 1.0).abs() < 0.0001)
}

///|
test "wave_damping negative u" {
  let v = wave_damping(-2.0, 0.5, 1.0)
  assert_true(v < 0.0)
}
