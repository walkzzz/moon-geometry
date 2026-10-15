///|
test "Segment::length" {
  let s = Segment::new(Point2D::new(0.0, 0.0), Point2D::new(3.0, 4.0))
  assert_true(approx_eq(s.length(), 5.0, 0.000000001))
}

///|
test "Segment::length zero" {
  let p = Point2D::new(1.0, 1.0)
  let s = Segment::new(p, p)
  assert_true(approx_eq(s.length(), 0.0, 0.000000001))
}

///|
test "Segment::direction" {
  let s = Segment::new(Point2D::new(1.0, 2.0), Point2D::new(4.0, 6.0))
  let d = s.direction()
  assert_true(approx_eq(d.x(), 3.0, 0.000000001))
  assert_true(approx_eq(d.y(), 4.0, 0.000000001))
}

///|
test "Segment::midpoint" {
  let s = Segment::new(Point2D::new(0.0, 0.0), Point2D::new(4.0, 6.0))
  let m = s.midpoint()
  assert_true(approx_eq(m.x(), 2.0, 0.000000001))
  assert_true(approx_eq(m.y(), 3.0, 0.000000001))
}

///|
test "Line::from_points horizontal" {
  let l = Line::from_points(Point2D::new(0.0, 1.0), Point2D::new(2.0, 1.0))
  // y = 1 => 0*x + 1*y - 1 = 0 => a=0, b=2, c=-2 (scaled)
  let p = Point2D::new(5.0, 1.0)
  assert_true(approx_eq(l.evaluate(p), 0.0, 0.000000001))
}

///|
test "Line::from_points vertical" {
  let l = Line::from_points(Point2D::new(2.0, 0.0), Point2D::new(2.0, 5.0))
  let on = Point2D::new(2.0, 100.0)
  assert_true(approx_eq(l.evaluate(on), 0.0, 0.000000001))
}

///|
test "Line::point_distance" {
  // x-axis: a=0, b=1, c=0
  let l = Line::new(0.0, 1.0, 0.0)
  let p = Point2D::new(3.0, 4.0)
  assert_true(approx_eq(l.point_distance(p), 4.0, 0.000000001))
}

///|
test "Line::point_distance diagonal" {
  // y = x => x - y = 0
  let l = Line::new(1.0, -1.0, 0.0)
  let p = Point2D::new(0.0, 0.0)
  assert_true(approx_eq(l.point_distance(p), 0.0, 0.000000001))
  let q = Point2D::new(1.0, 0.0)
  assert_true(approx_eq(l.point_distance(q), 0.7071067811865476, 0.000000001))
}

///|
test "Line::evaluate sign" {
  let l = Line::new(1.0, 0.0, 0.0) // x = 0
  assert_true(l.evaluate(Point2D::new(1.0, 0.0)) > 0.0)
  assert_true(l.evaluate(Point2D::new(-1.0, 0.0)) < 0.0)
}

///|
test "Line::point_distance degenerate" {
  let l = Line::new(0.0, 0.0, 0.0)
  let p = Point2D::new(1.0, 1.0)
  assert_true(approx_eq(l.point_distance(p), 0.0, 0.000000001))
}
