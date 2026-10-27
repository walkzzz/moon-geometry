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

///|
test "convex_polygon: single vertex match" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 4.0)])
  let p = @core.Point2D::new(3.0, 4.0)
  assert_true(point_in_convex_polygon(poly, p))
}

///|
test "convex_polygon: single vertex no match" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 4.0)])
  let p = @core.Point2D::new(3.1, 4.0)
  assert_false(point_in_convex_polygon(poly, p))
}

///|
test "convex_polygon: support function single vertex" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 4.0)])
  let dir = @core.Point2D::new(1.0, 1.0)
  let val = support_function(poly, dir)
  assert_true(@core.approx_eq(val, 7.0, 0.001))
}

///|
test "convex_polygon: extreme point single vertex" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 4.0)])
  let dir = @core.Point2D::new(1.0, 0.0)
  let idx = extreme_point(poly, dir)
  assert_eq(idx, 0)
}

///|
test "convex_polygon: tangent empty" {
  let empty = @core.Polygon::new([])
  let p = @core.Point2D::new(1.0, 1.0)
  let (left, right) = tangent_from_point(empty, p)
  assert_eq(left, -1)
  assert_eq(right, -1)
}

///|
test "convex_polygon: tangent from above" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ])
  let p = @core.Point2D::new(2.0, 5.0)
  let (left, right) = tangent_from_point(sq, p)
  assert_true(left >= 0 && left < 4)
  assert_true(right >= 0 && right < 4)
  assert_true(left != right)
}

///|
test "convex_polygon: tangent from left" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ])
  let p = @core.Point2D::new(-1.0, 2.0)
  let (left, right) = tangent_from_point(sq, p)
  assert_true(left >= 0 && left < 4)
  assert_true(right >= 0 && right < 4)
  assert_true(left != right)
}

///|
test "convex_polygon: intersect with empty" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let empty = @core.Polygon::new([])
  assert_false(convex_polygons_intersect(sq, empty))
  assert_false(convex_polygons_intersect(empty, sq))
}

///|
test "convex_polygon: intersect triangles disjoint" {
  let t1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ])
  let t2 = @core.Polygon::new([
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(14.0, 10.0),
    @core.Point2D::new(12.0, 14.0),
  ])
  assert_false(convex_polygons_intersect(t1, t2))
}

///|
test "convex_polygon: intersect square triangle disjoint" {
  // Mixed polygon types: square vs triangle, clearly disjoint.
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let tri = @core.Polygon::new([
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(14.0, 10.0),
    @core.Point2D::new(12.0, 14.0),
  ])
  assert_false(convex_polygons_intersect(sq, tri))
  assert_false(convex_polygons_intersect(tri, sq))
}

///|
test "convex_polygon: point to convex distance at vertex" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  // Point outside near corner (0,0): closest is the vertex
  let p = @core.Point2D::new(-1.0, -1.0)
  let d = point_to_convex_polygon_distance(sq, p)
  // dist to (0,0) = sqrt(2)
  assert_true(@core.approx_eq(d, 1.4142135623730951, 0.001))
}

///|
test "convex_polygon: point in hexagon inside" {
  // Regular hexagon centered at (5,5) radius 4, CCW
  let hex = @core.Polygon::new([
    @core.Point2D::new(9.0, 5.0),
    @core.Point2D::new(7.0, 8.4641016151),
    @core.Point2D::new(3.0, 8.4641016151),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(3.0, 1.5358983849),
    @core.Point2D::new(7.0, 1.5358983849),
  ])
  let p = @core.Point2D::new(5.0, 5.0)
  assert_true(point_in_convex_polygon(hex, p))
}

///|
test "convex_polygon: point in hexagon outside" {
  let hex = @core.Polygon::new([
    @core.Point2D::new(9.0, 5.0),
    @core.Point2D::new(7.0, 8.4641016151),
    @core.Point2D::new(3.0, 8.4641016151),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(3.0, 1.5358983849),
    @core.Point2D::new(7.0, 1.5358983849),
  ])
  let p = @core.Point2D::new(10.0, 10.0)
  assert_false(point_in_convex_polygon(hex, p))
}

///|
test "convex_polygon: point outside left of last edge" {
  // Point with p.x < 0, p.y >= 0 triggers the turn(p0, poly[n-1], p) > 0
  // early-return branch (left of the last fan edge from vertex 0).
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(-1.0, 2.0)
  assert_false(point_in_convex_polygon(sq, p))
}

///|
test "convex_polygon: disjoint with separating axis in second poly" {
  // Diamond poly1 and rectangle poly2: all of poly1's edge normals overlap
  // with poly2, but poly2's edge 3 normal is a separating axis. This exercises
  // the second has_separating_axis call returning true (the return-false at
  // line 129 of convex_polygons_intersect).
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(5.0, 1.0),
    @core.Point2D::new(7.0, 1.0),
    @core.Point2D::new(7.0, 3.0),
    @core.Point2D::new(5.0, 3.0),
  ])
  assert_false(convex_polygons_intersect(poly1, poly2))
}

///|
test "convex_polygon: has_separating_axis min1 update" {
  // Non-convex poly1 where edge 1's normal has a vertex (index 3) with a
  // smaller projection than the edge start, exercising the min1 = val branch.
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(12.0, 10.0),
    @core.Point2D::new(12.0, 12.0),
    @core.Point2D::new(10.0, 12.0),
  ])
  assert_true(has_separating_axis(poly1, poly2))
}
