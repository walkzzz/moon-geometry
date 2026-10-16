test "sat_collide_polygons overlapping" {
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
  let result = sat_collide_polygons(poly1, poly2)
  assert_true(result.collides)
  assert_true(result.overlap > 0.0)
}

test "sat_collide_polygons disjoint" {
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
  let result = sat_collide_polygons(poly1, poly2)
  assert_false(result.collides)
}

test "sat_collide_polygons identical" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let result = sat_collide_polygons(poly, poly)
  assert_true(result.collides)
}

test "sat_contains_point inside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(sat_contains_point(poly, @core.Point2D::new(2.0, 2.0)))
}

test "sat_contains_point outside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  assert_false(sat_contains_point(poly, @core.Point2D::new(5.0, 5.0)))
}

test "sat_collide_circles overlapping" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(1.0, 0.0)
  let result = sat_collide_circles(c1, 1.0, c2, 1.0)
  assert_true(result.collides)
  assert_true(result.overlap > 0.0)
}

test "sat_collide_circles disjoint" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(5.0, 0.0)
  let result = sat_collide_circles(c1, 1.0, c2, 1.0)
  assert_false(result.collides)
}

test "sat_collide_polygon_circle overlapping" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(3.0, 3.0)
  let result = sat_collide_polygon_circle(poly, center, 2.0)
  assert_true(result.collides)
}

test "sat_collide_polygon_circle disjoint" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let center = @core.Point2D::new(10.0, 10.0)
  let result = sat_collide_polygon_circle(poly, center, 1.0)
  assert_false(result.collides)
}

test "sat_mtv basic" {
  let result = SATResult::new(true, 2.0, 1.0, 0.0)
  let mtv = sat_mtv(result)
  assert_true((mtv.x() - 2.0).abs() < 0.001)
}

test "sat_separating_axis basic" {
  let result = SATResult::new(false, 0.0, 0.6, 0.8)
  let axis = sat_separating_axis(result)
  assert_true((axis.x() - 0.6).abs() < 0.001)
  assert_true((axis.y() - 0.8).abs() < 0.001)
}