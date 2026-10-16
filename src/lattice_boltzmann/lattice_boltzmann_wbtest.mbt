test "equilibrium_dist" {
  let f = equilibrium_dist(1.0, 0.0, 1.0 / 3.0, 0.0)
  assert_true((f - 0.333333).abs() < 0.001)
}

test "collide" {
  let f = collide(1.0, 0.5, 1.0)
  assert_true((f - 0.5).abs() < 0.001)
}

test "compute_density" {
  let rho = compute_density([1.0, 2.0, 3.0])
  assert_true((rho - 6.0).abs() < 0.001)
}

test "relaxation_time" {
  let tau = relaxation_time(0.1, 1.0, 1.0)
  assert_true((tau - 0.8).abs() < 0.001)
}
