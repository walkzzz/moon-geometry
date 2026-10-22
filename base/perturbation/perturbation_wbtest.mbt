test "sos_orientation non-degenerate" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(sos_orientation(a, b, c, 0, 1, 2), 1)
}

test "sos_sign" {
  assert_eq(sos_sign(0.0, 0), 1)
  assert_eq(sos_sign(0.0, 1), -1)
}

test "sos_compare" {
  assert_eq(sos_compare(1.0, 2.0, 0, 1), -1)
  assert_eq(sos_compare(1.0, 1.0, 0, 1), -1)
}
