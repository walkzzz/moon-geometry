test "eliminate_variable" {
  assert_eq(eliminate_variable(3, 1), 2)
}

test "projection_dimension" {
  assert_eq(projection_dimension(2, 1), 1)
  assert_eq(projection_dimension(1, 2), 0)
}

test "extension_exists" {
  assert_true(extension_exists(true))
  assert_false(extension_exists(false))
}
