test "arc_length_segment" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(3.0, 4.0)
  assert_true((arc_length_segment(p1, p2) - 5.0).abs() < 0.001)
}

test "arc_length_total" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  assert_true((arc_length_total(pts) - 7.0).abs() < 0.001)
}

test "arc_length_cumulative" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let cum = arc_length_cumulative(pts)
  assert_true(cum.length() == 3)
  assert_true((cum[0] - 0.0).abs() < 0.001)
  assert_true((cum[1] - 3.0).abs() < 0.001)
  assert_true((cum[2] - 7.0).abs() < 0.001)
}

test "arc_length_average" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  assert_true((arc_length_average(pts) - 2.0).abs() < 0.001)
}

test "arc_length_max_segment" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 5.0),
  ]
  assert_true((arc_length_max_segment(pts) - 5.0).abs() < 0.001)
}