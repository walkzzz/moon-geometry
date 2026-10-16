test "lagrangian" {
  assert_eq(lagrangian(10.0, 5.0), 5.0)
}

test "hamiltonian" {
  assert_eq(hamiltonian(10.0, 5.0), 15.0)
}

test "action integral" {
  let s = action_integral([1.0, 2.0, 3.0], 0.1)
  assert_true((s - 0.6).abs() < 1.0e-10)
}
