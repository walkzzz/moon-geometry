test "sweep_update" {
  let u = sweep_update(999999.0, 0.0, 0.0, 1.0, 1.0)
  assert_true((u - 1.0).abs() < 0.001)
}

test "sweeping_converged" {
  assert_true(sweeping_converged([1.0, 2.0], [1.0001, 2.0001], 0.01))
}
