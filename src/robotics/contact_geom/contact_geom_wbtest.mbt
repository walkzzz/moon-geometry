test "contact form eval" {
  let w = ContactForm::new(1.0, 0.0, 1.0)
  assert_eq(w.eval(1.0, 2.0, 3.0), 4.0)
  assert_true(w.is_contact())
}

test "legendre lift" {
  let (x, _, z) = legendre_lift(2.0, 3.0, fn(x) { x * x })
  assert_eq(x, 2.0)
  assert_eq(z, 4.0)
}
