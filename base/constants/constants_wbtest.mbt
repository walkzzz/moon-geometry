///|
test "constants: pi" {
  assert_true((pi - 3.141592653589793).abs() < 0.0001)
}

///|
test "constants: two pi" {
  assert_true((two_pi - 6.283185307179586).abs() < 0.0001)
}

///|
test "constants: half pi" {
  assert_true((half_pi - 1.5707963267948966).abs() < 0.0001)
}

///|
test "constants: sqrt2" {
  assert_true((sqrt2 * sqrt2 - 2.0).abs() < 0.0001)
}

///|
test "constants: sqrt3" {
  assert_true((sqrt3 * sqrt3 - 3.0).abs() < 0.0001)
}

///|
test "constants: golden ratio" {
  assert_true((golden_ratio - (1.0 + 1.0 / golden_ratio)).abs() < 0.0001)
}

///|
test "constants: deg2rad" {
  assert_true((deg2rad * 180.0 - pi).abs() < 0.0001)
}

///|
test "constants: rad2deg" {
  assert_true((rad2deg * pi - 180.0).abs() < 0.0001)
}
