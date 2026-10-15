test "minkowski: sum of two squares" {
  let sq1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let sq2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let result = minkowski_sum_convex(sq1, sq2)
  assert_eq(result.length(), 4)
}

test "minkowski: sum of two triangles" {
  let tri1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(0.0, 3.0),
  ])
  let tri2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let result = minkowski_sum_convex(tri1, tri2)
  assert_true(result.length() >= 3 && result.length() <= 6)
}

test "minkowski: sum with CW polygon" {
  let sq1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 0.0),
  ])
  let sq2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let result = minkowski_sum_convex(sq1, sq2)
  assert_eq(result.length(), 4)
}

test "minkowski: difference of two squares" {
  let sq1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let sq2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let result = minkowski_difference_convex(sq1, sq2)
  assert_true(result.length() >= 4)
}

test "minkowski: sum of circle and polygon" {
  let circle = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 2.0)
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let (pts, r) = minkowski_sum_circle_polygon(circle, sq)
  assert_eq(pts.length(), 4)
  assert_eq(r, 2.0)
}

test "minkowski: collide overlapping squares" {
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
  assert_true(convex_polygons_collide(sq1, sq2))
}

test "minkowski: collide non-overlapping squares" {
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
  assert_false(convex_polygons_collide(sq1, sq2))
}

test "minkowski: collide touching squares" {
  let sq1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ])
  let sq2 = @core.Polygon::new([
    @core.Point2D::new(2.5, 0.0),
    @core.Point2D::new(5.5, 0.0),
    @core.Point2D::new(5.5, 3.0),
    @core.Point2D::new(2.5, 3.0),
  ])
  assert_true(convex_polygons_collide(sq1, sq2))
}

test "minkowski: empty polygon sum" {
  let empty = @core.Polygon::new([])
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let result = minkowski_sum_convex(empty, sq)
  assert_eq(result.length(), 0)
}

test "minkowski: sum of same square" {
  let sq = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let result = minkowski_sum_convex(sq, sq)
  assert_eq(result.length(), 4)
}

test "minkowski: sum of hexagon and triangle" {
  let hex = @core.Polygon::new([
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 5.196),
    @core.Point2D::new(-3.0, 5.196),
    @core.Point2D::new(-6.0, 0.0),
    @core.Point2D::new(-3.0, -5.196),
    @core.Point2D::new(3.0, -5.196),
  ])
  let tri = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 0.866),
  ])
  let result = minkowski_sum_convex(hex, tri)
  assert_true(result.length() >= 6)
}