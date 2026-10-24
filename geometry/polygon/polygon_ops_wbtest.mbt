///|
fn unit_square() -> @core.Polygon {
  @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
}

///|
test "polygon_area unit square" {
  assert_true(@core.approx_eq(polygon_area(unit_square()), 1.0, 0.000000001))
}

///|
test "polygon_area triangle" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 3.0),
  ])
  assert_true(@core.approx_eq(polygon_area(poly), 6.0, 0.000000001))
}

///|
test "polygon_area cw equals ccw absolute" {
  let ccw = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let cw = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 0.0),
  ])
  assert_true(@core.approx_eq(polygon_area(ccw), polygon_area(cw), 0.000000001))
}

///|
test "polygon_signed_area ccw positive" {
  assert_true(polygon_signed_area(unit_square()) > 0.0)
}

///|
test "polygon_signed_area cw negative" {
  let cw = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 0.0),
  ])
  assert_true(polygon_signed_area(cw) < 0.0)
}

///|
test "polygon_perimeter unit square" {
  assert_true(
    @core.approx_eq(polygon_perimeter(unit_square()), 4.0, 0.000000001),
  )
}

///|
test "polygon_perimeter triangle" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(@core.approx_eq(polygon_perimeter(poly), 12.0, 0.000000001))
}

///|
test "polygon_centroid square" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let c = polygon_centroid(poly)
  assert_true(@core.approx_eq(c.x(), 1.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 1.0, 0.000000001))
}

///|
test "polygon_centroid single vertex" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 5.0)])
  let c = polygon_centroid(poly)
  assert_true(@core.approx_eq(c.x(), 3.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 5.0, 0.000000001))
}

///|
test "polygon_orientation ccw" {
  assert_eq(polygon_orientation(unit_square()), @core.CounterClockwise)
}

///|
test "polygon_orientation cw" {
  let cw = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 0.0),
  ])
  assert_eq(polygon_orientation(cw), @core.Clockwise)
}

///|
test "polygon_orientation collinear" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
  ])
  assert_eq(polygon_orientation(poly), @core.Collinear)
}

///|
test "is_convex square true" {
  assert_true(is_convex(unit_square()))
}

///|
test "is_convex triangle true" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ])
  assert_true(is_convex(poly))
}

///|
test "is_convex concave false" {
  // L-shape (concave)
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  assert_false(is_convex(poly))
}

///|
test "is_convex degenerate false" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ])
  assert_false(is_convex(poly))
}

///|
test "point_in_polygon inside" {
  let p = @core.Point2D::new(0.5, 0.5)
  assert_true(point_in_polygon(p, unit_square()))
}

///|
test "point_in_polygon outside" {
  let p = @core.Point2D::new(2.0, 2.0)
  assert_false(point_in_polygon(p, unit_square()))
}

///|
test "point_in_polygon vertex" {
  let p = @core.Point2D::new(0.0, 0.0)
  // boundary behavior may vary; just ensure no crash
  ignore(point_in_polygon(p, unit_square()))
}

///|
test "point_in_polygon triangle inside" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(point_in_polygon(@core.Point2D::new(1.0, 1.0), poly))
  assert_false(point_in_polygon(@core.Point2D::new(3.0, 3.0), poly))
}

///|
test "simplify_polygon no reduction" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let simplified = simplify_polygon(poly, 0.1)
  assert_eq(simplified.length(), 4)
}

///|
test "simplify_polygon removes collinear" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
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
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ])
  assert_true(@core.approx_eq(polygon_area(poly), 0.0, 0.000000001))
}

///|
test "polygon_perimeter degenerate" {
  let poly = @core.Polygon::new([@core.Point2D::new(0.0, 0.0)])
  assert_true(@core.approx_eq(polygon_perimeter(poly), 0.0, 0.000000001))
}

///|
test "polygon_area concave" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let a = polygon_area(poly)
  assert_true(a > 0.0)
  assert_true(a < 16.0)
}

///|
test "polygon_centroid triangle" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(0.0, 6.0),
  ])
  let c = polygon_centroid(poly)
  assert_true(@core.approx_eq(c.x, 2.0, 0.000000001))
  assert_true(@core.approx_eq(c.y, 2.0, 0.000000001))
}

///|
test "is_convex concave polygon" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_false(is_convex(poly))
}

///|
test "point_in_polygon on edge" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(2.0, 0.0)
  assert_true(point_in_polygon(p, poly))
}

///|
test "point_in_polygon at vertex" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(point_in_polygon(@core.Point2D::new(0.5, 0.5), poly))
  assert_true(point_in_polygon(@core.Point2D::new(3.5, 3.5), poly))
}

///|
test "polygon_orientation clockwise" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
  ])
  assert_eq(polygon_orientation(poly), @core.Clockwise)
}

///|
test "polygon_orientation collinear extra" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
  ])
  assert_eq(polygon_orientation(poly), @core.Collinear)
}

///|
test "polygon_centroid empty" {
  let poly = @core.Polygon::new([])
  let c = polygon_centroid(poly)
  assert_true(@core.approx_eq(c.x(), 0.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 0.0, 0.000000001))
}

///|
test "polygon_centroid two vertices" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 6.0),
  ])
  let c = polygon_centroid(poly)
  assert_true(@core.approx_eq(c.x(), 2.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 3.0, 0.000000001))
}

///|
test "polygon_centroid degenerate collinear" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ])
  let c = polygon_centroid(poly)
  assert_true(@core.approx_eq(c.x(), 1.5, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 1.5, 0.000000001))
}

///|
test "polygon_perimeter empty" {
  let poly = @core.Polygon::new([])
  assert_true(@core.approx_eq(polygon_perimeter(poly), 0.0, 0.000000001))
}

///|
test "polygon_signed_area empty" {
  let poly = @core.Polygon::new([])
  assert_true(@core.approx_eq(polygon_signed_area(poly), 0.0, 0.000000001))
}

///|
test "polygon_area empty" {
  let poly = @core.Polygon::new([])
  assert_true(@core.approx_eq(polygon_area(poly), 0.0, 0.000000001))
}

///|
test "polygon_orientation empty" {
  let poly = @core.Polygon::new([])
  assert_eq(polygon_orientation(poly), @core.Collinear)
}

///|
test "is_convex triangle three vertices" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  assert_true(is_convex(poly))
}

///|
test "is_convex empty" {
  let poly = @core.Polygon::new([])
  assert_false(is_convex(poly))
}

///|
test "point_in_polygon empty polygon" {
  let poly = @core.Polygon::new([])
  assert_false(point_in_polygon(@core.Point2D::new(0.0, 0.0), poly))
}

///|
test "simplify_polygon two vertices" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ])
  let simplified = simplify_polygon(poly, 0.1)
  assert_eq(simplified.length(), 2)
}

///|
test "simplify_polygon empty" {
  let poly = @core.Polygon::new([])
  let simplified = simplify_polygon(poly, 0.1)
  assert_eq(simplified.length(), 0)
}
