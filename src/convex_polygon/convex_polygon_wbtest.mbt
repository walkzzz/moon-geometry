///|
test "convex_polygon: support function" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let dir = @core.Point2D::new(1.0, 0.0)
  let val = support_function(sq, dir)
  assert_true(@core.approx_eq(val, 4.0, 0.001))
}

///|
test "convex_polygon: support function diagonal" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let dir = @core.Point2D::new(1.0, 1.0)
  let val = support_function(sq, dir)
  assert_true(@core.approx_eq(val, 8.0, 0.001))
}

///|
test "convex_polygon: extreme point" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let dir = @core.Point2D::new(1.0, 0.0)
  let idx = extreme_point(sq, dir)
  let p = sq.get(idx)
  assert_true(@core.approx_eq(p.x(), 4.0, 0.001))
}

///|
test "convex_polygon: point inside convex" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(2.0, 2.0)
  assert_true(point_in_convex_polygon(sq, p))
}

///|
test "convex_polygon: point outside convex" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(5.0, 5.0)
  assert_false(point_in_convex_polygon(sq, p))
}

///|
test "convex_polygon: point on vertex" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(0.0, 0.0)
  assert_true(point_in_convex_polygon(sq, p))
}

///|
test "convex_polygon: point on edge" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(2.0, 0.0)
  assert_true(point_in_convex_polygon(sq, p))
}

///|
test "convex_polygon: tangent from external point" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ])
  let p = @core.Point2D::new(5.0, 2.0)
  let (left, right) = tangent_from_point(sq, p)
  assert_true(left >= 0 && left < 4)
  assert_true(right >= 0 && right < 4)
  assert_true(left != right)
}

///|
test "convex_polygon: intersect overlapping" {
  let sq1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let sq2 = @core.Polygon::new([
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ])
  assert_true(convex_polygons_intersect(sq1, sq2))
}

///|
test "convex_polygon: intersect disjoint" {
  let sq1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let sq2 = @core.Polygon::new([
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(12.0, 10.0),
    @core.Point2D::new(12.0, 12.0),
    @core.Point2D::new(10.0, 12.0),
  ])
  assert_false(convex_polygons_intersect(sq1, sq2))
}

///|
test "convex_polygon: intersect contained" {
  let outer = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ])
  let inner = @core.Polygon::new([
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(3.0, 5.0),
  ])
  assert_true(convex_polygons_intersect(outer, inner))
}

///|
test "convex_polygon: point to convex distance inside" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(2.0, 2.0)
  let d = point_to_convex_polygon_distance(sq, p)
  assert_true(@core.approx_eq(d, 0.0, 0.001))
}

///|
test "convex_polygon: point to convex distance outside" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(6.0, 2.0)
  let d = point_to_convex_polygon_distance(sq, p)
  assert_true(@core.approx_eq(d, 2.0, 0.001))
}

///|
test "convex_polygon: empty polygon" {
  let empty = @core.Polygon::new([])
  let p = @core.Point2D::new(1.0, 1.0)
  assert_false(point_in_convex_polygon(empty, p))
  assert_eq(support_function(empty, p), 0.0)
  assert_eq(extreme_point(empty, p), -1)
}
