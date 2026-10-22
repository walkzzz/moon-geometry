test "solve_eikonal_2d" {
  let u = solve_eikonal_2d(0.0, 0.0, 1.0, 1.0)
  assert_true((u - 0.707107).abs() < 0.01)
}

test "is_far" {
  assert_true(is_far(999999999.0))
  assert_false(is_far(1.0))
}

test "is_frozen" {
  assert_true(is_frozen(1.0))
  assert_false(is_frozen(-1.0))
}
