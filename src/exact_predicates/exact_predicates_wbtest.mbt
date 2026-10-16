test "exact_orientation ccw" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(exact_orientation(a, b, c), 1)
}

test "exact_orientation cw" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 1.0)
  let c = @core.Point2D::new(1.0, 0.0)
  assert_eq(exact_orientation(a, b, c), -1)
}

test "exact_orientation collinear" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  assert_eq(exact_orientation(a, b, c), 0)
}

test "exact_left_turn" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_true(exact_left_turn(a, b, c))
}

test "exact_collinear" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  assert_true(exact_collinear(a, b, c))
}
