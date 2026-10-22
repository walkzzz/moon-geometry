test "compare_orientation_ccw" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(robust_orientation(a, b, c), 1)
}

test "compare_orientation_cw" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 1.0)
  let c = @core.Point2D::new(1.0, 0.0)
  assert_eq(robust_orientation(a, b, c), -1)
}

test "compare_orientation_collinear" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 1.0)
  let c = @core.Point2D::new(2.0, 2.0)
  assert_eq(robust_orientation(a, b, c), 0)
}

test "compare_left_turn" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.5, 0.5)
  assert_true(robust_left_turn(a, b, c))
}

test "compare_right_turn" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.5, -0.5)
  assert_true(robust_right_turn(a, b, c))
}

test "compare_collinear" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  assert_true(robust_collinear(a, b, c, 0.000000000001))
}

test "compare_points" {
  let a = @core.Point2D::new(1.0, 2.0)
  let b = @core.Point2D::new(3.0, 0.0)
  assert_eq(compare_points(a, b), -1)
  assert_eq(compare_points(b, a), 1)
  assert_eq(compare_points(a, a), 0)
}

test "compare_points_y" {
  let a = @core.Point2D::new(1.0, 2.0)
  let b = @core.Point2D::new(1.0, 5.0)
  assert_eq(compare_points(a, b), -1)
}

test "compare_points_equal" {
  let a = @core.Point2D::new(1.0, 2.0)
  let b = @core.Point2D::new(1.0, 2.0)
  assert_true(points_equal(a, b, 0.000000000001))
}

test "compare_less_than" {
  let a = @core.Point2D::new(1.0, 2.0)
  let b = @core.Point2D::new(3.0, 0.0)
  assert_true(less_than(a, b))
  assert_false(less_than(b, a))
}