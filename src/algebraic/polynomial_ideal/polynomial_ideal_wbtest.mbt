test "ideal_is_zero" {
  let z = @grobner_basis.Polynomial::new([0.0])
  assert_true(ideal_is_zero([z]))
}

test "ideal_dimension" {
  let p = @grobner_basis.Polynomial::new([1.0, 2.0, 3.0])
  assert_eq(ideal_dimension([p]), 1)
}

test "ideal_generator_count" {
  let p = @grobner_basis.Polynomial::new([1.0, 2.0])
  assert_eq(ideal_generator_count([p, p]), 2)
}
