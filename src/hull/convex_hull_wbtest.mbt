///|
test "ccw counter-clockwise" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(ccw(a, b, c), @core.CounterClockwise)
}

///|
test "ccw clockwise" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 1.0)
  let c = @core.Point2D::new(1.0, 0.0)
  assert_eq(ccw(a, b, c), @core.Clockwise)
}

///|
test "ccw collinear" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 1.0)
  let c = @core.Point2D::new(2.0, 2.0)
  assert_eq(ccw(a, b, c), @core.Collinear)
}

///|
fn square_points() -> Array[@core.Point2D] {
  [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
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
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 4)
}

///|
test "convex_hull_graham with interior points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let hull = convex_hull_graham(pts)
  assert_eq(hull.length(), 4)
}

///|
test "convex_hull_andrew triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(2.0, 1.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 3)
}

///|
test "convex_hull_graham triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(2.0, 1.0),
  ]
  let hull = convex_hull_graham(pts)
  assert_eq(hull.length(), 3)
}

///|
test "convex_hull_andrew collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 2)
}

///|
test "convex_hull_graham collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let hull = convex_hull_graham(pts)
  assert_eq(hull.length(), 2)
}

///|
test "convex_hull_andrew duplicate points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 3)
}

///|
test "convex_hull_andrew empty" {
  let pts : Array[@core.Point2D] = []
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 0)
}

///|
test "convex_hull_andrew single" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 1)
}

///|
test "convex_hull_andrew two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(3.0, 4.0)]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 2)
}

///|
test "convex_hull algorithms agree" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(4.0, 3.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 1.0),
  ]
  let h1 = convex_hull_andrew(pts)
  let h2 = convex_hull_graham(pts)
  assert_eq(h1.length(), h2.length())
}

///|
test "convex_hull_andrew excludes collinear edge points" {
  // square with midpoints on edges - collinear should be excluded
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 4)
}

///|
test "convex_hull_andrew all collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 2)
}

///|
test "convex_hull_andrew duplicate points extra" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let hull = convex_hull_andrew(pts)
  assert_eq(hull.length(), 3)
}

///|
test "convex_hull of hull is hull" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 1.0),
  ]
  let hull = convex_hull_andrew(pts)
  let hull2 = convex_hull_andrew(hull)
  assert_eq(hull.length(), hull2.length())
}

///|
test "convex_hull_graham empty" {
  let pts : Array[@core.Point2D] = []
  assert_eq(convex_hull_graham(pts).length(), 0)
}

///|
test "convex_hull_graham single" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  assert_eq(convex_hull_graham(pts).length(), 1)
}

///|
test "convex_hull_graham collinear extra" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  assert_eq(convex_hull_graham(pts).length(), 2)
}
