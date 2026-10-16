test "boundary_of_simplex" {
  let bd = boundary_of_simplex([0, 1, 2])
  assert_eq(bd.length(), 3)
}

test "boundary_count" {
  assert_eq(boundary_count([0, 1]), 2)
  assert_eq(boundary_count([0, 1, 2]), 3)
}

test "boundary_squared_zero" {
  assert_true(boundary_squared_zero([0, 1, 2, 3]))
}
