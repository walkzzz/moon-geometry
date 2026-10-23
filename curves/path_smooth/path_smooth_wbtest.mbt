///|
test "smooth_path basic" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(10.0, 0.0),
  ]
  let config = SmoothConfig::new(10, 0.0, true)
  let smoothed = smooth_path(path, config)
  assert_true(smoothed.length() > path.length())
}

///|
test "smooth_path preserves endpoints" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(10.0, 0.0),
  ]
  let config = SmoothConfig::new(10, 0.0, true)
  let smoothed = smooth_path(path, config)
  assert_true((smoothed[0].x() - 0.0).abs() < 0.001)
  assert_true((smoothed[smoothed.length() - 1].x() - 10.0).abs() < 0.001)
}

///|
test "smooth_path short path" {
  let path = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let config = SmoothConfig::new(10, 0.0, true)
  let smoothed = smooth_path(path, config)
  assert_eq(smoothed.length(), 2)
}

///|
test "bspline_smooth basic" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(9.0, 4.0),
  ]
  let smoothed = bspline_smooth(path, 10)
  assert_true(smoothed.length() > path.length())
}

///|
test "bspline_smooth short path" {
  let path = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let smoothed = bspline_smooth(path, 10)
  assert_true(smoothed.length() >= 2)
}

///|
test "smooth_preserve_keypoints basic" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(8.0, 0.0),
  ]
  let smoothed = smooth_preserve_keypoints(path, [0, 4], 10)
  assert_true(smoothed.length() > 0)
  assert_true((smoothed[0].x() - 0.0).abs() < 0.001)
}

///|
test "path_length basic" {
  let path = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(3.0, 4.0)]
  let len = path_length(path)
  assert_true((len - 5.0).abs() < 0.001)
}

///|
test "path_length empty" {
  let path : Array[@core.Point2D] = []
  assert_true(path_length(path).abs() < 0.001)
}

///|
test "simplify_path collinear" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let simplified = simplify_path(path, 0.001)
  assert_eq(simplified.length(), 2)
}

///|
test "simplify_path non-collinear" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let simplified = simplify_path(path, 0.001)
  assert_eq(simplified.length(), 3)
}

///|
test "path_max_deviation basic" {
  let original = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(5.0, 5.0)]
  let smoothed = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(5.0, 5.0)]
  let dev = path_max_deviation(original, smoothed)
  assert_true(dev < 0.001)
}
