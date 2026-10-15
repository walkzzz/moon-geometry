///|
test "closest_pair basic" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(3.0, 3.0),
    Point2D::new(4.0, 4.0),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) =>
      assert_true(approx_eq(d, 1.4142135623730951, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "closest_pair two points" {
  let pts = [Point2D::new(0.0, 0.0), Point2D::new(3.0, 4.0)]
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(approx_eq(d, 5.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "closest_pair single none" {
  let pts = [Point2D::new(1.0, 2.0)]
  assert_true(closest_pair(pts) is None)
}

///|
test "closest_pair empty none" {
  let pts : Array[Point2D] = []
  assert_true(closest_pair(pts) is None)
}

///|
test "closest_pair duplicate points" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(5.0, 5.0),
    Point2D::new(0.0, 0.0),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(approx_eq(d, 0.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "closest_pair horizontal" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(5.0, 0.0),
    Point2D::new(2.0, 0.0),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(approx_eq(d, 1.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "closest_pair vertical" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(0.0, 3.0),
    Point2D::new(0.0, 1.0),
    Point2D::new(0.0, 2.0),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(approx_eq(d, 1.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "closest_pair grid" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(0.0, 2.0),
    Point2D::new(2.0, 2.0),
    Point2D::new(1.0, 1.0),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) =>
      assert_true(approx_eq(d, 1.4142135623730951, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "closest_pair cross strip" {
  // Points where closest pair crosses the divide
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(10.0, 0.0),
    Point2D::new(4.9, 1.0),
    Point2D::new(5.1, 1.0),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(d < 1.0)
    None => assert_true(false)
  }
}

///|
test "closest_pair many points" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(10.0, 10.0),
    Point2D::new(2.0, 3.0),
    Point2D::new(3.0, 2.0),
    Point2D::new(7.0, 8.0),
    Point2D::new(8.0, 7.0),
    Point2D::new(1.0, 1.0),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(d > 0.0)
    None => assert_true(false)
  }
}

///|
test "closest_pair brute comparison" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(0.0, 2.0),
  ]
  // brute: min dist is 1.0 (between consecutive on x-axis)
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(approx_eq(d, 1.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "closest_pair collinear" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(3.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(2.0, 0.0),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(approx_eq(d, 1.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "closest_pair three points" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(0.0, 0.5),
  ]
  match closest_pair(pts) {
    Some((_, _, d)) => assert_true(approx_eq(d, 0.5, 0.000000001))
    None => assert_true(false)
  }
}
