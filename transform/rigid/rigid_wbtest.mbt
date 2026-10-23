///|
test "rigid identity" {
  let r = Rigid::identity()
  let p = @core.Point2D::new(3.0, 4.0)
  let result = r.apply(p)
  assert_true((result.x() - 3.0).abs() < 0.0001)
  assert_true((result.y() - 4.0).abs() < 0.0001)
}

///|
test "rigid translation" {
  let r = Rigid::translation(5.0, 3.0)
  let p = @core.Point2D::new(1.0, 2.0)
  let result = r.apply(p)
  assert_true((result.x() - 6.0).abs() < 0.0001)
  assert_true((result.y() - 5.0).abs() < 0.0001)
}

///|
test "rigid rotation" {
  let r = Rigid::rotation(1.5707963267948966)
  let p = @core.Point2D::new(1.0, 0.0)
  let result = r.apply(p)
  assert_true(result.x().abs() < 0.001)
  assert_true((result.y() - 1.0).abs() < 0.001)
}

///|
test "rigid inverse" {
  let r = Rigid::translation(5.0, 3.0)
  let inv = r.inverse()
  let p = @core.Point2D::new(6.0, 5.0)
  let result = inv.apply(p)
  assert_true((result.x() - 1.0).abs() < 0.001)
  assert_true((result.y() - 2.0).abs() < 0.001)
}

///|
test "rigid compose" {
  let r1 = Rigid::translation(3.0, 0.0)
  let r2 = Rigid::translation(0.0, 4.0)
  let r3 = Rigid::compose(r1, r2)
  let p = @core.Point2D::new(0.0, 0.0)
  let result = r3.apply(p)
  assert_true((result.x() - 3.0).abs() < 0.001)
  assert_true((result.y() - 4.0).abs() < 0.001)
}
