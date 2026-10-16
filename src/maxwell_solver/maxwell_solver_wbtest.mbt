test "fdtd_update_e" {
  let e = fdtd_update_e([0.0, 0.0], [1.0, 0.0], 0.01, 1.0, 1.0)
  assert_eq(e.length(), 2)
}
test "fdtd_update_h" {
  let h = fdtd_update_h([1.0, 0.0], [0.0, 0.0], 0.01, 1.0, 1.0)
  assert_eq(h.length(), 2)
}
test "courant_condition" {
  let dt = courant_condition(1.0, 1.0, 1.0, 1.0)
  assert_true(dt > 0.0)
}
