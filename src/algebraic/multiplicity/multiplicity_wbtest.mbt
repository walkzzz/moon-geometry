test "intersection_multiplicity" {
  assert_eq(intersection_multiplicity(2, 3), 2)
}

test "total_multiplicity" {
  assert_eq(total_multiplicity([1, 2, 3]), 6)
}

test "is_simple_intersection" {
  assert_true(is_simple_intersection(1))
  assert_false(is_simple_intersection(2))
}
