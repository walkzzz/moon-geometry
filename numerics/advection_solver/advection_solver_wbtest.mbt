test "upwind_advection" {
  let u = upwind_advection([1.0, 0.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}
test "lax_friedrichs" {
  let u = lax_friedrichs([0.0, 1.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}
test "lax_wendroff" {
  let u = lax_wendroff([0.0, 1.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}
