test "hilbert_function_pn" {
  assert_eq(hilbert_function_pn(0, 2), 1)
  assert_eq(hilbert_function_pn(1, 2), 3)
  assert_eq(hilbert_function_pn(2, 2), 6)
}

test "hilbert_regularity" {
  assert_eq(hilbert_regularity(3), 3)
}

test "hilbert_multiplicity" {
  assert_eq(hilbert_multiplicity(2, 2), 4)
}
