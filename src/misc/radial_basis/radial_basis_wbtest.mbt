test "rbf_interpolate_gaussian" {
  let v = rbf_interpolate_gaussian(0.0, 1.0)
  assert_true((v - 1.0).abs() < 0.001)
}

test "rbf_interpolate_multiquadric" {
  let v = rbf_interpolate_multiquadric(0.0, 1.0)
  assert_true((v - 1.0).abs() < 0.001)
}

test "rbf_interpolate_polyharmonic" {
  let v = rbf_interpolate_polyharmonic(0.0, 3)
  assert_true(v.abs() < 0.001)
}
