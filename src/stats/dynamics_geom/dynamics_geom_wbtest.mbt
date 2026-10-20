///|
test "inertia_tensor_sphere" {
  let i_val = inertia_tensor_sphere(1.0, 1.0)
  assert_true(i_val > 0.39 && i_val < 0.41)
}
test "angular_momentum" {
  let l_val = angular_momentum(2.0, 3.0)
  assert_true(l_val > 5.99 && l_val < 6.01)
}
test "kinetic_energy_rot" {
  let e_val = kinetic_energy_rot(2.0, 3.0)
  assert_true(e_val > 8.99 && e_val < 9.01)
}
