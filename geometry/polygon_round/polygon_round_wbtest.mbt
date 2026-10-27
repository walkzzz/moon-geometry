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

///|
test "round_polygon non-positive radius returns copy" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
  ]
  let result = round_polygon(pts, 0.0, 5)
  assert_eq(result.length(), 3)
  let result2 = round_polygon(pts, -1.0, 5)
  assert_eq(result2.length(), 3)
}

///|
test "round_polygon zero segments returns copy" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
  ]
  let result = round_polygon(pts, 1.0, 0)
  assert_eq(result.length(), 3)
}

///|
test "round_corner degenerate p1 equals p2" {
  let p1 = @core.Point2D::new(5.0, 5.0)
  let p2 = @core.Point2D::new(5.0, 5.0)
  let p3 = @core.Point2D::new(10.0, 5.0)
  let result = round_corner(p1, p2, p3, 1.0, 4)
  assert_eq(result.length(), 1)
  assert_true((result[0].x() - 5.0).abs() < 0.000000001)
}

///|
test "round_corner degenerate p2 equals p3" {
  let p1 = @core.Point2D::new(0.0, 5.0)
  let p2 = @core.Point2D::new(5.0, 5.0)
  let p3 = @core.Point2D::new(5.0, 5.0)
  let result = round_corner(p1, p2, p3, 1.0, 4)
  assert_eq(result.length(), 1)
  assert_true((result[0].x() - 5.0).abs() < 0.000000001)
}

///|
test "round_corner 180 degree fold" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(5.0, 0.0)
  let p3 = @core.Point2D::new(0.0, 0.0)
  let result = round_corner(p1, p2, p3, 1.0, 4)
  assert_true(result.length() >= 1)
}

///|
test "round_corner radius clamped to max_r" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(1.0, 0.0)
  let p3 = @core.Point2D::new(1.0, 1.0)
  let result = round_corner(p1, p2, p3, 100.0, 4)
  assert_true(result.length() >= 4)
}

///|
test "round_corner acute angle produces arc" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(5.0, 0.0)
  let p3 = @core.Point2D::new(5.0 + 0.0001, 0.0001)
  let result = round_corner(p1, p2, p3, 0.5, 6)
  assert_true(result.length() >= 1)
}

///|
test "round_polygon triangle produces more points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 6.0),
  ]
  let result = round_polygon(pts, 0.5, 3)
  assert_true(result.length() > 3)
}
