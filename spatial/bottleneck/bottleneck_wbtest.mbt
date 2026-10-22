test "bottleneck_distance" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(3.0, 4.0)]
  assert_true((bottleneck_distance(a, b) - 5.0).abs() < 0.001)
}

test "bottleneck_within" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 0.5)]
  assert_true(bottleneck_within(a, b, 1.0))
  assert_false(bottleneck_within(a, b, 0.1))
}

test "bottleneck_match" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 1.0), @core.Point2D::new(2.0, 1.0)]
  let pairs = bottleneck_match(a, b)
  assert_true(pairs.length() == 2)
}

test "bottleneck_max" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 1.0), @core.Point2D::new(2.0, 1.0)]
  let d = bottleneck_max(a, b)
  assert_true((d - 1.0).abs() < 0.001)
}

test "bottleneck_identical" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  assert_true((bottleneck_distance(a, a) - 0.0).abs() < 0.001)
}