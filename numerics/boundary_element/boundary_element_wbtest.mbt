///|
test "fundamental_solution_2d" {
  let g = fundamental_solution_2d(1.0)
  assert_true(g.abs() < 0.001)
}

///|
test "boundary_integral_kernel" {
  let k = boundary_integral_kernel(1.0, 0.5)
  assert_true(k > 0.0)
}

///|
test "bem_error" {
  let e = bem_error([1.0, 2.0], [1.0, 2.0])
  assert_true(e.abs() < 0.001)
}
