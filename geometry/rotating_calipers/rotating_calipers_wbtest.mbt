///|
test "rotating_calipers: diameter of square" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let (_, _, d) = convex_polygon_diameter(sq)
  assert_true(@core.approx_eq(d, 5.6568542, 0.001))
}

///|
test "rotating_calipers: diameter of rectangle" {
  let rect = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let (_, _, d) = convex_polygon_diameter(rect)
  assert_true(@core.approx_eq(d, 6.3245553, 0.001))
}

///|
test "rotating_calipers: diameter of triangle" {
  let tri = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let (_, _, d) = convex_polygon_diameter(tri)
  assert_true(@core.approx_eq(d, 5.0, 0.001))
}

///|
test "rotating_calipers: width of square" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let w = convex_polygon_width(sq)
  assert_true(@core.approx_eq(w, 4.0, 0.001))
}

///|
test "rotating_calipers: width of rectangle" {
  let rect = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let w = convex_polygon_width(rect)
  assert_true(@core.approx_eq(w, 2.0, 0.001))
}

///|
test "rotating_calipers: farthest pair from points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  match farthest_point_pair(pts) {
    Some((_, _, d)) => assert_true(@core.approx_eq(d, 7.0710678, 0.001))
    None => assert_true(false)
  }
}

///|
test "rotating_calipers: farthest pair degenerate single point" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  match farthest_point_pair(pts) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "rotating_calipers: farthest pair two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(3.0, 4.0)]
  match farthest_point_pair(pts) {
    Some((_, _, d)) => assert_true(@core.approx_eq(d, 5.0, 0.001))
    None => assert_true(false)
  }
}

///|
test "rotating_calipers: diameter of hexagon" {
  let hex = @core.Polygon::new([
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 8.660),
    @core.Point2D::new(-5.0, 8.660),
    @core.Point2D::new(-10.0, 0.0),
    @core.Point2D::new(-5.0, -8.660),
    @core.Point2D::new(5.0, -8.660),
  ])
  let (_, _, d) = convex_polygon_diameter(hex)
  assert_true(@core.approx_eq(d, 20.0, 0.01))
}

///|
test "rotating_calipers: min perimeter bounding rect of square" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let (_, _, w, h, _) = min_perimeter_bounding_rect(sq)
  assert_true(@core.approx_eq(2.0 * (w + h), 16.0, 0.01))
}

///|
test "rotating_calipers: min perimeter bounding rect of rectangle" {
  let rect = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(8.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ])
  let (_, _, w, h, _) = min_perimeter_bounding_rect(rect)
  assert_true(@core.approx_eq(2.0 * (w + h), 22.0, 0.01))
}

///|
test "rotating_calipers: diameter degenerate empty" {
  let empty = @core.Polygon::new([])
  let (_, _, d) = convex_polygon_diameter(empty)
  assert_eq(d, 0.0)
}

///|
test "rotating_calipers: diameter single point" {
  let single = @core.Polygon::new([@core.Point2D::new(3.0, 7.0)])
  let (_, _, d) = convex_polygon_diameter(single)
  assert_eq(d, 0.0)
}
