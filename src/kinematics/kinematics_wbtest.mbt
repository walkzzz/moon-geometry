test "forward_kin_2d" {
  let (x, y) = forward_kin_2d(0.0, 0.0, 1.0, 1.0)
  assert_true(x > 1.99 && x < 2.01)
  assert_true(y.abs() < 0.01)
}
test "inverse_kin_2d" {
  let (t1, t2) = inverse_kin_2d(2.0, 0.0, 1.0, 1.0)
  assert_true(t1.abs() < 0.01)
  assert_true(t2.abs() < 0.01)
}
test "manipulability" {
  let m = manipulability(1.0, 0.0, 0.0, 1.0)
  assert_true(m > 0.99 && m < 1.01)
}
