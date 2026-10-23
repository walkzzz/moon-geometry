///|
test "angle: deg to rad" {
  assert_true((deg_to_rad(180.0) - 3.141592653589793).abs() < 0.001)
  assert_true((deg_to_rad(90.0) - 1.5707963).abs() < 0.001)
}

///|
test "angle: rad to deg" {
  assert_true((rad_to_deg(3.141592653589793) - 180.0).abs() < 0.001)
  assert_true((rad_to_deg(1.5707963) - 90.0).abs() < 0.001)
}

///|
test "angle: normalize" {
  let a = normalize_angle(7.0)
  assert_true(a >= 0.0 && a < 6.283185307179586)
}

///|
test "angle: normalize negative" {
  let a = normalize_angle(-1.0)
  assert_true(a >= 0.0 && a < 6.283185307179586)
}

///|
test "angle: normalize signed" {
  let a = normalize_angle_signed(4.0)
  assert_true(a >= -3.141592653589793 && a < 3.141592653589793)
}

///|
test "angle: angle diff" {
  let d = angle_diff(0.0, 3.141592653589793)
  assert_true((d - 3.141592653589793).abs() < 0.001)
}

///|
test "angle: bisector" {
  let b = bisector(0.0, 1.5707963)
  assert_true((b - 0.7853981).abs() < 0.001)
}

///|
test "angle: is between" {
  assert_true(is_between(0.0, 0.5, 1.0))
  assert_false(is_between(0.0, 1.5, 1.0))
}
