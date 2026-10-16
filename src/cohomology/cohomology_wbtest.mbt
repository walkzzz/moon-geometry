test "CohomologyClass::new" {
  let c = CohomologyClass::new(1, [1, 0, 1])
  assert_eq(cohomology_dimension(c), 1)
}

test "cohomology_rank" {
  assert_eq(cohomology_rank(1, 2), 2)
}

test "cup_product_degree" {
  let a = CohomologyClass::new(1, [1])
  let b = CohomologyClass::new(2, [1])
  assert_eq(cup_product_degree(a, b), 3)
}
