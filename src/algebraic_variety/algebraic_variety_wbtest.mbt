test "variety_dimension" {
  assert_eq(variety_dimension(2, 1), 1)
  assert_eq(variety_dimension(3, 3), 0)
}

test "variety_is_finite" {
  assert_true(variety_is_finite(0))
  assert_false(variety_is_finite(1))
}

test "variety_degree" {
  assert_eq(variety_degree(2, [2, 2]), 4)
}

test "variety_count_real_roots" {
  assert_eq(variety_count_real_roots([1.0, 2.0, 3.0], 0.01), 3)
  assert_eq(variety_count_real_roots([1.0, 1.001, 3.0], 0.01), 2)
}
