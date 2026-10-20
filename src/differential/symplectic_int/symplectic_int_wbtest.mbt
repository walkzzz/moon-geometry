test "stormer verlet" {
  let (q, _) = stormer_verlet(1.0, 0.0, fn(x) { -x }, 0.01)
  assert_true(q > 0.99)
}

test "leapfrog" {
  let (q, _) = leapfrog(1.0, 0.0, fn(x) { -x }, 0.01)
  assert_true(q > 0.99)
}

test "energy conservation error" {
  let e = energy_conservation_error(10.0, 10.001)
  assert_true(e < 0.001)
}
