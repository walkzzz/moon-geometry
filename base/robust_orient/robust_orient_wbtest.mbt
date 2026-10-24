///|
test "robust orient2d" {
  assert_eq(robust_orient2d(0.0, 0.0, 1.0, 0.0, 0.0, 1.0), 1)
  assert_eq(robust_orient2d(0.0, 0.0, 0.0, 1.0, 1.0, 0.0), -1)
}

///|
test "robust orient3d" {
  let r = robust_orient3d(
    0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0,
  )
  assert_eq(r, 1)
}

///|
test "robust compare" {
  assert_eq(robust_compare(5.0, 3.0, 0.1), 1)
  assert_eq(robust_compare(3.0, 5.0, 0.1), -1)
}
///|
test "robust orient2d collinear" {
  assert_eq(robust_orient2d(0.0, 0.0, 1.0, 1.0, 2.0, 2.0), 0)
}

///|
test "robust orient2d coincident" {
  assert_eq(robust_orient2d(1.0, 1.0, 1.0, 1.0, 1.0, 1.0), 0)
}

///|
test "robust orient3d negative" {
  let r = robust_orient3d(
    0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0,
  )
  assert_eq(r, -1)
}

///|
test "robust orient3d coplanar" {
  let r = robust_orient3d(
    0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 2.0, 0.0, 0.0, 3.0, 0.0, 0.0,
  )
  assert_eq(r, 0)
}

///|
test "robust sign positive" {
  assert_eq(robust_sign(5.0, 0.1), 1)
}

///|
test "robust sign negative" {
  assert_eq(robust_sign(-5.0, 0.1), -1)
}

///|
test "robust sign zero" {
  assert_eq(robust_sign(0.05, 0.1), 0)
  assert_eq(robust_sign(0.0, 0.1), 0)
}

///|
test "robust compare equal" {
  assert_eq(robust_compare(3.0, 3.0, 0.1), 0)
  assert_eq(robust_compare(3.04, 3.0, 0.1), 0)
}
