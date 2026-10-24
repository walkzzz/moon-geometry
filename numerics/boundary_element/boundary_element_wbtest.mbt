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
///|
test "bem_matrix_entry" {
  let e = bem_matrix_entry(1.0, 2.0)
  assert_true(e.abs() < 0.001)
}

///|
test "bem_solve diagonal" {
  let m = [[2.0, 0.0], [0.0, 4.0]]
  let x = bem_solve(m, [4.0, 8.0])
  assert_true((x[0] - 2.0).abs() < 0.001)
  assert_true((x[1] - 2.0).abs() < 0.001)
}

///|
test "bem_solve zero diagonal" {
  let m = [[0.0, 0.0], [0.0, 4.0]]
  let x = bem_solve(m, [4.0, 8.0])
  assert_true(x[0].abs() < 0.001)
  assert_true((x[1] - 2.0).abs() < 0.001)
}

///|
test "fundamental_solution_2d at zero" {
  let g = fundamental_solution_2d(0.0)
  assert_true(g.abs() < 0.001)
}

///|
test "boundary_integral_kernel at zero" {
  let k = boundary_integral_kernel(0.0, 0.5)
  assert_true(k.abs() < 0.001)
}
