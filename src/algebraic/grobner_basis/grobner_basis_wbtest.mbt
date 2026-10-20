test "poly_degree" {
  let p = Polynomial::new([1.0, 2.0, 3.0])
  assert_eq(poly_degree(p), 2)
}

test "poly_lead_coeff" {
  let p = Polynomial::new([1.0, 2.0, 3.0])
  assert_true((poly_lead_coeff(p) - 3.0).abs() < 0.001)
}

test "poly_s_divide" {
  let a = Polynomial::new([0.0, 0.0, 1.0])
  let b = Polynomial::new([1.0])
  let q = poly_s_divide(a, b)
  assert_eq(poly_degree(q), 2)
}

test "poly_is_reduced" {
  let z = Polynomial::new([0.0, 0.0])
  assert_true(poly_is_reduced(z))
}
