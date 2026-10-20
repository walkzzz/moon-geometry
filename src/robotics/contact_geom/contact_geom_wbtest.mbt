test "contact form eval" {
  let w = { a_x: 1.0, a_y: 0.0, a_z: 1.0 }
  assert_eq(w.eval(1.0, 2.0, 3.0), 4.0)
}

test "legendre lift" {
  let (x, _, z) = legendre_lift(2.0, 3.0, fn(x) { x * x })
  assert_eq(x, 2.0)
  assert_eq(z, 4.0)
}
