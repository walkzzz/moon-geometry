test "brunn minkowski" {
  let r = brunn_minkowski(1.0, 1.0)
  assert_eq(r, 4.0)
}

test "triangle inequality" {
  assert_true(triangle_inequality(3.0, 4.0, 5.0))
  assert_true(!triangle_inequality(1.0, 2.0, 10.0))
}

test "cauchy schwarz" {
  let r = cauchy_schwarz(1.0, 0.0, 0.0, 1.0)
  assert_true(r <= 1.0e-10)
}
