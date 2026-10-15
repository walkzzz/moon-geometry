test "constants: pi" {
  assert_true(@core.approx_eq(pi, 3.141592653589793, 0.0001))
}

test "constants: two pi" {
  assert_true(@core.approx_eq(two_pi, 6.283185307179586, 0.0001))
}

test "constants: half pi" {
  assert_true(@core.approx_eq(half_pi, 1.5707963267948966, 0.0001))
}

test "constants: sqrt2" {
  assert_true(@core.approx_eq(sqrt2 * sqrt2, 2.0, 0.0001))
}

test "constants: sqrt3" {
  assert_true(@core.approx_eq(sqrt3 * sqrt3, 3.0, 0.0001))
}

test "constants: golden ratio" {
  assert_true(@core.approx_eq(golden_ratio, 1.0 + 1.0 / golden_ratio, 0.0001))
}

test "constants: deg2rad" {
  assert_true(@core.approx_eq(deg2rad * 180.0, pi, 0.0001))
}

test "constants: rad2deg" {
  assert_true(@core.approx_eq(rad2deg * pi, 180.0, 0.0001))
}