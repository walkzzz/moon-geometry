///|
test "conformal_factor" {
  assert_true((conformal_factor(2.0, 4.0) - 2.0).abs() < 0.001)
}

///|
test "is_conformal" {
  assert_true(is_conformal(2.0, 0.0, 0.0, 2.0, 0.001))
  assert_false(is_conformal(2.0, 1.0, 0.0, 2.0, 0.001))
}

///|
test "conformal_energy" {
  assert_true(conformal_energy(2.0, 2.0).abs() < 0.001)
}

///|
test "conformal_factor_zero" {
  assert_true(conformal_factor(0.0, 1.0).abs() < 0.001)
}

///|
test "conformal_energy_nonzero" {
  let e = conformal_energy(3.0, 1.0)
  assert_true((e - 4.0).abs() < 0.001)
}

///|
test "angle_distortion_zero" {
  let d = angle_distortion(1.0, 1.0)
  assert_true(d.abs() < 0.001)
}

///|
test "angle_distortion_nonzero" {
  let d = angle_distortion(1.5, 1.0)
  assert_true((d - 0.5).abs() < 0.001)
}

///|
test "area_distortion_equal" {
  let d = area_distortion(2.0, 2.0)
  assert_true(d.abs() < 0.001)
}

///|
test "area_distortion_zero_before" {
  let d = area_distortion(0.0, 1.0)
  assert_true(d.abs() < 0.001)
}

///|
test "area_distortion_ratio" {
  let d = area_distortion(1.0, 2.718281828459045)
  assert_true((d - 1.0).abs() < 0.001)
}
