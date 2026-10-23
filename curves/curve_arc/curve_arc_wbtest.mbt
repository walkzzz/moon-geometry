///|
test "arc_length" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  assert_true((arc_length(pts) - 7.0).abs() < 0.001)
}

///|
test "arc_length_at" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  assert_true((arc_length_at(pts, 0.5) - 2.0).abs() < 0.001)
}

///|
test "arc_length_parametrize" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let result = arc_length_parametrize(pts, 5)
  assert_true(result.length() == 5)
  assert_true((result[0].x() - 0.0).abs() < 0.001)
  assert_true((result[4].x() - 4.0).abs() < 0.001)
}

///|
test "arc_length_to_param" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  let t = arc_length_to_param(pts, 2.0)
  assert_true((t - 0.5).abs() < 0.001)
}

///|
test "arc_length_empty" {
  let pts : Array[@core.Point2D] = []
  assert_true(arc_length(pts) == 0.0)
}
