test "dg_mass_matrix" {
  let m = dg_mass_matrix(2.0, 0)
  assert_true((m - 2.0).abs() < 0.001)
}

test "dg_numerical_flux" {
  let f = dg_numerical_flux(1.0, 3.0, 1.0)
  assert_true((f - 1.0).abs() < 0.001)
}

test "dg_lax_friedrichs_flux" {
  let f = dg_lax_friedrichs_flux(1.0, 3.0, 1.0, 3.0, 1.0)
  assert_true((f - 1.0).abs() < 0.001)
}
