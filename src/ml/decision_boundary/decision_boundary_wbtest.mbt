test "linear_boundary" {
  let v = linear_boundary([1.0, 1.0], -1.0, [0.5, 0.5])
  assert_true(v.abs() < 0.0001)
}
test "boundary_classify" {
  let c = boundary_classify([1.0, 0.0], 0.0, [0.5, 0.0])
  assert_eq(c, 1)
}
test "quadratic_boundary" {
  let v = quadratic_boundary(1.0, 0.0, -1.0, 1.0)
  assert_true(v.abs() < 0.0001)
}
