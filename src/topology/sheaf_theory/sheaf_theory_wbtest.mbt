test "sheaf_rank" {
  assert_eq(sheaf_rank([1, 2, 3]), 6)
}

test "sheaf_cohomology_dim" {
  let (h0, h1) = sheaf_cohomology_dim(3, 2, 1)
  assert_eq(h0, 1)
  assert_eq(h1, 1)
}

test "is_locally_constant" {
  assert_true(is_locally_constant([1, 1, 1]))
  assert_false(is_locally_constant([1, 2, 1]))
}
