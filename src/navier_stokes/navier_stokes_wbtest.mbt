test "ns_advection" {
  let u = ns_advection([0.0, 1.0, 0.0], [0.0, 0.0, 0.0], 1.0, 1.0)
  assert_eq(u.length(), 3)
}
test "ns_reynolds_number" {
  let re = ns_reynolds_number(1.0, 1.0, 1.0, 1.0)
  assert_true(re > 0.99 && re < 1.01)
}
