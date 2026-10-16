test "SimplicialComplex::new" {
  let sc = SimplicialComplex::new([[0, 1], [1, 2], [0, 1, 2]])
  assert_eq(simplex_count(sc), 3)
}

test "complex_dimension" {
  let sc = SimplicialComplex::new([[0], [0, 1], [0, 1, 2]])
  assert_eq(complex_dimension(sc), 2)
}

test "is_valid_complex" {
  let sc = SimplicialComplex::new([[0, 1], [1, 2]])
  assert_true(is_valid_complex(sc))
}

test "add_simplex" {
  let sc = SimplicialComplex::new([[0, 1]])
  let sc2 = add_simplex(sc, [1, 2])
  assert_eq(simplex_count(sc2), 2)
}
