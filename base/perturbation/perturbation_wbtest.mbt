///|
test "sos_orientation non-degenerate" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(sos_orientation(a, b, c, 0, 1, 2), 1)
}

///|
test "sos_sign" {
  assert_eq(sos_sign(0.0, 0), 1)
  assert_eq(sos_sign(0.0, 1), -1)
}

///|
test "sos_compare" {
  assert_eq(sos_compare(1.0, 2.0, 0, 1), -1)
  assert_eq(sos_compare(1.0, 1.0, 0, 1), -1)
}

///|
test "sos_sign positive" {
  assert_eq(sos_sign(1.5, 0), 1)
  assert_eq(sos_sign(0.001, 3), 1)
}

///|
test "sos_sign negative" {
  assert_eq(sos_sign(-1.5, 0), -1)
  assert_eq(sos_sign(-0.001, 2), -1)
}

///|
test "sos_sign zero even odd" {
  assert_eq(sos_sign(0.0, 2), 1)
  assert_eq(sos_sign(0.0, 3), -1)
  assert_eq(sos_sign(0.0, 4), 1)
}

///|
test "sos_orientation degenerate" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 1.0)
  let c = @core.Point2D::new(2.0, 2.0)
  assert_eq(sos_orientation(a, b, c, 0, 1, 2), 1)
}

///|
test "sos_orientation degenerate not sorted" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 1.0)
  let c = @core.Point2D::new(2.0, 2.0)
  assert_eq(sos_orientation(a, b, c, 2, 1, 0), -1)
}

///|
test "sos_orientation negative" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 1.0)
  let c = @core.Point2D::new(1.0, 0.0)
  assert_eq(sos_orientation(a, b, c, 0, 1, 2), -1)
}

///|
test "sos_compare greater" {
  assert_eq(sos_compare(2.0, 1.0, 0, 1), 1)
}

///|
test "sos_compare equal greater index" {
  assert_eq(sos_compare(1.0, 1.0, 1, 0), 1)
}
