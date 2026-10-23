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
