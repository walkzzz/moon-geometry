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

///|
test "hausdorff_directed empty a" {
  let b = [@core.Point2D::new(0.0, 0.0)]
  let d = hausdorff_directed([], b)
  assert_true((d - 0.0).abs() < 0.001)
}

///|
test "hausdorff_directed empty b" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let d = hausdorff_directed(a, [])
  assert_true(d > 1000000000.0)
}

///|
test "hausdorff_distance both empty" {
  let d = hausdorff_distance([], [])
  assert_true((d - 0.0).abs() < 0.001)
}

///|
test "hausdorff_distance one empty" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let d = hausdorff_distance(a, [])
  assert_true(d > 1000000000.0)
}

///|
test "partial_hausdorff empty" {
  let d = partial_hausdorff([], [], 0)
  assert_true((d - 0.0).abs() < 0.001)
}

///|
test "partial_hausdorff k out of range" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 0.0)]
  let d = partial_hausdorff(a, b, 10)
  assert_true((d - 2.0).abs() < 0.001)
}

///|
test "hausdorff_within exact boundary" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(1.0, 0.0)]
  assert_true(hausdorff_within(a, b, 1.0))
}

///|
test "hausdorff_directed asymmetric" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 0.0)]
  let d = hausdorff_directed(a, b)
  assert_true((d - 10.0).abs() < 0.001)
}

///|
test "partial_hausdorff k one" {
  let a = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
  ]
  let b = [@core.Point2D::new(0.0, 0.0)]
  let d = partial_hausdorff(a, b, 1)
  assert_true((d - 3.0).abs() < 0.001)
}
