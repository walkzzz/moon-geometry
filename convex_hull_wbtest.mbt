///|
test "ccw counter-clockwise" {
  let a = Point2D::new(0.0, 0.0)
  let b = Point2D::new(1.0, 0.0)
  let c = Point2D::new(0.0, 1.0)
  assert_eq(ccw(a, b, c), CounterClockwise)
}

///|
test "ccw clockwise" {
  let a = Point2D::new(0.0, 0.0)
  let b = Point2D::new(0.0, 1.0)
  let c = Point2D::new(1.0, 0.0)
  assert_eq(ccw(a, b, c), Clockwise)
}

///|
test "ccw collinear" {
  let a = Point2D::new(0.0, 0.0)
  let b = Point2D::new(1.0, 1.0)
  let c = Point2D::new(2.0, 2.0)
  assert_eq(ccw(a, b, c), Collinear)
}

///|
fn square_points() -> Array[Point2D] {
  [
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
  ]
}

///|
test "convex_hull_andrew square" {
  let hull = convex_hull_andrew(square_points())
  assert_eq(hull.length(), 4)
}

///|
test "convex_hull_graham square" {
  let hull = convex_hull_graham(square_points())
  assert_eq(hull.length(), 4)
}

///|
test "convex_hull_andrew with interior points" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
    Point2D::new(2.0, 2.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(3.0, 1.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 4)
}

///|
test "convex_hull_graham with interior points" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
    Point2D::new(2.0, 2.0),
  ]
  let hull = convex_hull_graham(pts)
  assert_eq(hull.length(), 4)
}

///|
test "convex_hull_andrew triangle" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(2.0, 4.0),
    Point2D::new(2.0, 1.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 3)
}

///|
test "convex_hull_graham triangle" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(2.0, 4.0),
    Point2D::new(2.0, 1.0),
  ]
  let hull = convex_hull_graham(pts)
  assert_eq(hull.length(), 3)
}

///|
test "convex_hull_andrew collinear" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(2.0, 2.0),
    Point2D::new(3.0, 3.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 2)
}

///|
test "convex_hull_graham collinear" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(2.0, 2.0),
    Point2D::new(3.0, 3.0),
  ]
  let hull = convex_hull_graham(pts)
  assert_eq(hull.length(), 2)
}

///|
test "convex_hull_andrew duplicate points" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(0.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(1.0, 2.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 3)
}

///|
test "convex_hull_andrew empty" {
  let pts : Array[Point2D] = []
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 0)
}

///|
test "convex_hull_andrew single" {
  let pts = [Point2D::new(1.0, 2.0)]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 1)
}

///|
test "convex_hull_andrew two points" {
  let pts = [Point2D::new(0.0, 0.0), Point2D::new(3.0, 4.0)]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 2)
}

///|
test "convex_hull algorithms agree" {
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(5.0, 0.0),
    Point2D::new(4.0, 3.0),
    Point2D::new(2.0, 5.0),
    Point2D::new(0.0, 4.0),
    Point2D::new(1.0, 2.0),
    Point2D::new(3.0, 1.0),
  ]
  let h1 = convex_hull_andrew(pts)
  let h2 = convex_hull_graham(pts)
  assert_eq(h1.length(), h2.length())
}

///|
test "convex_hull_andrew excludes collinear edge points" {
  // square with midpoints on edges - collinear should be excluded
  let pts = [
    Point2D::new(0.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 4)
}
