test "q commutator" {
  let c = q_commutator(3.0, 5.0, 1.0)
  assert_eq(c, 0.0)
}

test "q number" {
  let qn = q_number(3, 2.0)
  assert_eq(qn, 7.0)
}

test "q factorial" {
  let qf = q_factorial(3, 1.0)
  assert_eq(qf, 6.0)
}
