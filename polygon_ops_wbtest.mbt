///|
fn unit_square() -> Polygon {
  Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(0.0, 1.0),
  ])
}

///|
test "polygon_area unit square" {
  assert_true(approx_eq(polygon_area(unit_square()), 1.0, 0.000000001))
}

///|
test "polygon_area triangle" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(0.0, 3.0),
  ])
  assert_true(approx_eq(polygon_area(poly), 6.0, 0.000000001))
}

///|
test "polygon_area cw equals ccw absolute" {
  let ccw = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(0.0, 1.0),
  ])
  let cw = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(0.0, 1.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(1.0, 0.0),
  ])
  assert_true(approx_eq(polygon_area(ccw), polygon_area(cw), 0.000000001))
}

///|
test "polygon_signed_area ccw positive" {
  assert_true(polygon_signed_area(unit_square()) > 0.0)
}

///|
test "polygon_signed_area cw negative" {
  let cw = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(0.0, 1.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(1.0, 0.0),
  ])
  assert_true(polygon_signed_area(cw) < 0.0)
}

///|
test "polygon_perimeter unit square" {
  assert_true(approx_eq(polygon_perimeter(unit_square()), 4.0, 0.000000001))
}

///|
test "polygon_perimeter triangle" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(3.0, 0.0),
    Point2D::new(0.0, 4.0),
  ])
  assert_true(approx_eq(polygon_perimeter(poly), 12.0, 0.000000001))
}

///|
test "polygon_centroid square" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(2.0, 2.0),
    Point2D::new(0.0, 2.0),
  ])
  let c = polygon_centroid(poly)
  assert_true(approx_eq(c.x(), 1.0, 0.000000001))
  assert_true(approx_eq(c.y(), 1.0, 0.000000001))
}

///|
test "polygon_centroid single vertex" {
  let poly = Polygon::new([Point2D::new(3.0, 5.0)])
  let c = polygon_centroid(poly)
  assert_true(approx_eq(c.x(), 3.0, 0.000000001))
  assert_true(approx_eq(c.y(), 5.0, 0.000000001))
}

///|
test "polygon_orientation ccw" {
  assert_eq(polygon_orientation(unit_square()), CounterClockwise)
}

///|
test "polygon_orientation cw" {
  let cw = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(0.0, 1.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(1.0, 0.0),
  ])
  assert_eq(polygon_orientation(cw), Clockwise)
}

///|
test "polygon_orientation collinear" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(2.0, 2.0),
  ])
  assert_eq(polygon_orientation(poly), Collinear)
}

///|
test "is_convex square true" {
  assert_true(is_convex(unit_square()))
}

///|
test "is_convex triangle true" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(2.0, 3.0),
  ])
  assert_true(is_convex(poly))
}

///|
test "is_convex concave false" {
  // L-shape (concave)
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(2.0, 1.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(1.0, 2.0),
    Point2D::new(0.0, 2.0),
  ])
  assert_false(is_convex(poly))
}

///|
test "is_convex degenerate false" {
  let poly = Polygon::new([Point2D::new(0.0, 0.0), Point2D::new(1.0, 1.0)])
  assert_false(is_convex(poly))
}

///|
test "point_in_polygon inside" {
  let p = Point2D::new(0.5, 0.5)
  assert_true(point_in_polygon(p, unit_square()))
}

///|
test "point_in_polygon outside" {
  let p = Point2D::new(2.0, 2.0)
  assert_false(point_in_polygon(p, unit_square()))
}

///|
test "point_in_polygon vertex" {
  let p = Point2D::new(0.0, 0.0)
  // boundary behavior may vary; just ensure no crash
  ignore(point_in_polygon(p, unit_square()))
}

///|
test "point_in_polygon triangle inside" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(0.0, 4.0),
  ])
  assert_true(point_in_polygon(Point2D::new(1.0, 1.0), poly))
  assert_false(point_in_polygon(Point2D::new(3.0, 3.0), poly))
}

///|
test "simplify_polygon no reduction" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
  ])
  let simplified = simplify_polygon(poly, 0.1)
  assert_eq(simplified.length(), 4)
}

///|
test "simplify_polygon removes collinear" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(3.0, 0.0),
    Point2D::new(3.0, 3.0),
    Point2D::new(0.0, 3.0),
  ])
  let simplified = simplify_polygon(poly, 0.1)
  assert_true(simplified.length() <= 4)
}

///|
test "simplify_polygon small epsilon" {
  let poly = unit_square()
  let simplified = simplify_polygon(poly, 0.0)
  assert_eq(simplified.length(), 4)
}

///|
test "polygon_area degenerate" {
  let poly = Polygon::new([Point2D::new(0.0, 0.0), Point2D::new(1.0, 1.0)])
  assert_true(approx_eq(polygon_area(poly), 0.0, 0.000000001))
}

///|
test "polygon_perimeter degenerate" {
  let poly = Polygon::new([Point2D::new(0.0, 0.0)])
  assert_true(approx_eq(polygon_perimeter(poly), 0.0, 0.000000001))
}
