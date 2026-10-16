test "linear_kernel" {
  let v = linear_kernel([1.0, 2.0], [3.0, 4.0])
  assert_true(v > 10.99 && v < 11.01)
}
test "rbf_kernel same" {
  let v = rbf_kernel([1.0, 2.0], [1.0, 2.0], 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
test "margin_distance" {
  let m = margin_distance([1.0, 0.0], 0.0, [1.0, 0.0], 1.0)
  assert_true(m > 0.99 && m < 1.01)
}
