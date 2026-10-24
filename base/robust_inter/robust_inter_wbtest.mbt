///|
test "robust segment intersect" {
  let (x, _, ok) = robust_segment_intersect(
    0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0,
  )
  assert_true(ok)
  assert_true(x > 0.49 && x < 0.51)
}

///|
test "robust line line" {
  let (x, _, ok) = robust_line_line(1.0, 1.0, 3.0, 1.0, -1.0, 1.0)
  assert_true(ok)
  assert_eq(x, 2.0)
}

///|
test "robust point on segment" {
  assert_true(robust_point_on_segment(0.5, 0.5, 0.0, 0.0, 1.0, 1.0))
}
///|
test "robust segment intersect parallel" {
  let (_, _, ok) = robust_segment_intersect(
    0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0,
  )
  assert_true(!ok)
}

///|
test "robust segment intersect coincident" {
  let (_, _, ok) = robust_segment_intersect(
    0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 2.0, 2.0,
  )
  assert_true(!ok)
}

///|
test "robust segment intersect known" {
  let (x, y, ok) = robust_segment_intersect(
    0.0, 0.0, 4.0, 0.0, 2.0, -2.0, 2.0, 2.0,
  )
  assert_true(ok)
  assert_true(x > 1.99 && x < 2.01)
  assert_true(y > -0.01 && y < 0.01)
}

///|
test "robust line line no solution" {
  let (_, _, ok) = robust_line_line(1.0, 1.0, 1.0, 1.0, 1.0, 2.0)
  assert_true(!ok)
}

///|
test "robust line line y check" {
  let (_, y, ok) = robust_line_line(1.0, 1.0, 3.0, 1.0, -1.0, 1.0)
  assert_true(ok)
  assert_eq(y, 1.0)
}

///|
test "robust line line both" {
  let (x, y, ok) = robust_line_line(2.0, 0.0, 4.0, 0.0, 3.0, 9.0)
  assert_true(ok)
  assert_eq(x, 2.0)
  assert_eq(y, 3.0)
}

///|
test "robust point on segment endpoint" {
  assert_true(robust_point_on_segment(0.0, 0.0, 0.0, 0.0, 1.0, 1.0))
  assert_true(robust_point_on_segment(1.0, 1.0, 0.0, 0.0, 1.0, 1.0))
}

///|
test "robust point not on segment off_line" {
  assert_true(!robust_point_on_segment(0.5, 0.9, 0.0, 0.0, 1.0, 1.0))
}

///|
test "robust point not on segment outside" {
  assert_true(!robust_point_on_segment(2.0, 2.0, 0.0, 0.0, 1.0, 1.0))
}

///|
test "robust point on segment horizontal" {
  assert_true(robust_point_on_segment(0.5, 0.0, 0.0, 0.0, 1.0, 0.0))
}
