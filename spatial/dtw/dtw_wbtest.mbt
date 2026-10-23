///|
test "dtw_distance_identical" {
  let c = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  assert_true((dtw_distance(c, c) - 0.0).abs() < 0.001)
}

///|
test "dtw_distance_shifted" {
  let c1 = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let c2 = [@core.Point2D::new(0.0, 1.0), @core.Point2D::new(1.0, 1.0)]
  let d = dtw_distance(c1, c2)
  assert_true(d > 0.0)
}

///|
test "dtw_windowed" {
  let c1 = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let c2 = [@core.Point2D::new(0.0, 1.0), @core.Point2D::new(1.0, 1.0)]
  let d = dtw_windowed(c1, c2, 1)
  assert_true(d > 0.0)
}

///|
test "dtw_normalized" {
  let c = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  assert_true((dtw_normalized(c, c) - 0.0).abs() < 0.001)
}

///|
test "dtw_empty" {
  let c : Array[@core.Point2D] = []
  assert_true(dtw_distance(c, c) == 0.0)
}
