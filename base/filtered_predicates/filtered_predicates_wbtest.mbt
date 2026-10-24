///|
test "filtered_orientation" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(filtered_orientation(a, b, c), 1)
}

///|
test "perturbation_orientation" {
  assert_eq(perturbation_orientation(0.5, 0.001), 1)
  assert_eq(perturbation_orientation(-0.5, 0.001), -1)
}
///|
test "perturbation_orientation zero" {
  assert_eq(perturbation_orientation(0.0, 0.001), 0)
  assert_eq(perturbation_orientation(0.0005, 0.001), 0)
  assert_eq(perturbation_orientation(-0.0005, 0.001), 0)
}

///|
test "perturbation_orientation boundary" {
  assert_eq(perturbation_orientation(0.001, 0.001), 0)
  assert_eq(perturbation_orientation(-0.001, 0.001), 0)
}

///|
test "filtered_orientation cw" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 1.0)
  let c = @core.Point2D::new(1.0, 0.0)
  assert_eq(filtered_orientation(a, b, c), -1)
}

///|
test "filtered_orientation collinear" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  assert_eq(filtered_orientation(a, b, c), 0)
}

///|
test "filtered_incircle inside" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  let d = @core.Point2D::new(0.5, 0.5)
  assert_true(filtered_incircle(a, b, c, d) != 0)
}

///|
test "filtered_incircle outside" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  let d = @core.Point2D::new(2.0, 2.0)
  assert_true(filtered_incircle(a, b, c, d) != 0)
}

///|
test "filtered_incircle on circle" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  let d = @core.Point2D::new(0.0, 0.0)
  assert_eq(filtered_incircle(a, b, c, d), 0)
}
