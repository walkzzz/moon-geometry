test "robust orient2d" {
  assert_eq(robust_orient2d(0.0, 0.0, 1.0, 0.0, 0.0, 1.0), 1)
  assert_eq(robust_orient2d(0.0, 0.0, 0.0, 1.0, 1.0, 0.0), -1)
}

test "robust orient3d" {
  let r = robust_orient3d(0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

test "robust compare" {
  assert_eq(robust_compare(5.0, 3.0, 0.1), 1)
  assert_eq(robust_compare(3.0, 5.0, 0.1), -1)
}
