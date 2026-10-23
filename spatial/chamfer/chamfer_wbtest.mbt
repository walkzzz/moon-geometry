///|
test "chamfer_directed" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(3.0, 4.0)]
  assert_true((chamfer_directed(a, b) - 5.0).abs() < 0.001)
}

///|
test "chamfer_distance" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 1.0)]
  assert_true((chamfer_distance(a, b) - 2.0).abs() < 0.001)
}

///|
test "chamfer_identical" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  assert_true((chamfer_distance(a, a) - 0.0).abs() < 0.001)
}

///|
test "chamfer_squared_directed" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(3.0, 4.0)]
  assert_true((chamfer_squared_directed(a, b) - 25.0).abs() < 0.001)
}

///|
test "chamfer_rms" {
  let a = [@core.Point2D::new(0.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 1.0)]
  assert_true((chamfer_rms(a, b) - 1.41421356).abs() < 0.01)
}
