test "canonical form nondegenerate" {
  let w = canonical_form()
  assert_true(w.is_nondegenerate())
}

test "hamiltonian flow" {
  let (x, y) = hamiltonian_flow(1.0, 0.0, 0.1)
  assert_true(x > 0.99 && x < 1.01)
  assert_true(y > -0.11 && y < -0.09)
}

test "poisson bracket" {
  let r = poisson_bracket(1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1.0)
}
