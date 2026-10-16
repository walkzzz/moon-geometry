test "gjk_collide_polygons overlapping" {
  let poly1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let poly2 = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ]
  let result = gjk_collide_polygons(poly1, poly2)
  assert_true(result.collides)
}

test "gjk_collide_polygons disjoint" {
  let poly1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let poly2 = [
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(6.0, 5.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(5.0, 6.0),
  ]
  let result = gjk_collide_polygons(poly1, poly2)
  assert_false(result.collides)
}

test "gjk_collide_circles overlapping" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(1.0, 0.0)
  let result = gjk_collide_circles(c1, 1.0, c2, 1.0)
  assert_true(result.collides)
}

test "gjk_collide_circles disjoint" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(5.0, 0.0)
  let result = gjk_collide_circles(c1, 1.0, c2, 1.0)
  assert_false(result.collides)
}

test "gjk_collide_polygon_circle overlapping" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(3.0, 3.0)
  let result = gjk_collide_polygon_circle(poly, center, 2.0)
  assert_true(result.collides)
}

test "gjk_collide_polygon_circle disjoint" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let center = @core.Point2D::new(10.0, 10.0)
  let result = gjk_collide_polygon_circle(poly, center, 1.0)
  assert_false(result.collides)
}

test "gjk_point_in_polygon inside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let p = @core.Point2D::new(2.0, 2.0)
  let result = gjk_point_in_polygon(p, poly)
  assert_true(result.collides)
}

test "gjk_point_in_polygon outside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let p = @core.Point2D::new(5.0, 5.0)
  let result = gjk_point_in_polygon(p, poly)
  assert_false(result.collides)
}

test "gjk_collide_polygons touching" {
  let poly1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let poly2 = [
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let result = gjk_collide_polygons(poly1, poly2)
  assert_true(result.collides)
}

test "gjk_collide_circles same center" {
  let c = @core.Point2D::new(0.0, 0.0)
  let result = gjk_collide_circles(c, 1.0, c, 1.0)
  assert_true(result.collides)
}

test "polygon_support basic" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let s = polygon_support(poly, 1.0, 0.0)
  assert_true((s.x() - 4.0).abs() < 0.001)
}