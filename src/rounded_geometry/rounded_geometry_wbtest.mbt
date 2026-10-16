test "round_double" {
  let r = round_double(3.14159, 2)
  assert_true((r - 3.14).abs() < 0.001)
}

test "rounded_area" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0), @core.Point2D::new(0.0, 4.0)]
  let a = rounded_area(pts, 2)
  assert_true((a - 8.0).abs() < 0.01)
}

test "rounded_length" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(3.0, 4.0)
  let l = rounded_length(a, b, 2)
  assert_true((l - 5.0).abs() < 0.01)
}
