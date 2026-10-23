///|
test "hausdorff_directed" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 1.0), @core.Point2D::new(1.0, 1.0)]
  let d = hausdorff_directed(a, b)
  assert_true((d - 1.0).abs() < 0.001)
}

///|
test "hausdorff_distance" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 1.0), @core.Point2D::new(1.0, 1.0)]
  let d = hausdorff_distance(a, b)
  assert_true((d - 1.0).abs() < 0.001)
}

///|
test "hausdorff_within" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 0.5)]
  assert_true(hausdorff_within(a, b, 1.0))
  assert_false(hausdorff_within(a, b, 0.1))
}

///|
test "hausdorff_identical" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  assert_true((hausdorff_distance(a, a) - 0.0).abs() < 0.001)
}

///|
test "partial_hausdorff" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 0.0)]
  let d = partial_hausdorff(a, b, 0)
  assert_true((d - 0.0).abs() < 0.001)
}
