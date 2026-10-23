///|
test "round_polygon square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let result = round_polygon(pts, 1.0, 5)
  assert_true(result.length() > pts.length())
}

///|
test "round_corner right angle" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(5.0, 0.0)
  let p3 = @core.Point2D::new(5.0, 5.0)
  let result = round_corner(p1, p2, p3, 1.0, 4)
  assert_true(result.length() >= 4)
}

///|
test "round_polygon small radius" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let result = round_polygon(pts, 0.01, 3)
  assert_true(result.length() > 4)
}

///|
test "round_polygon degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let result = round_polygon(pts, 1.0, 5)
  assert_eq(result.length(), 2)
}

///|
test "round_corner straight line" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(5.0, 0.0)
  let p3 = @core.Point2D::new(10.0, 0.0)
  let result = round_corner(p1, p2, p3, 1.0, 4)
  assert_eq(result.length(), 1)
}
