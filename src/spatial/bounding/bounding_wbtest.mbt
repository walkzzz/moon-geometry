///|
test "aabb basic" {
  let pts = [
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(3.0, 7.0),
    @core.Point2D::new(2.0, 1.0),
  ]
  let rect = aabb(pts)
  assert_true(@core.approx_eq(rect.min_x, 1.0, 0.000000001))
  assert_true(@core.approx_eq(rect.min_y, 1.0, 0.000000001))
  assert_true(@core.approx_eq(rect.width(), 4.0, 0.000000001))
  assert_true(@core.approx_eq(rect.height(), 6.0, 0.000000001))
}

///|
test "aabb single point" {
  let pts = [@core.Point2D::new(3.0, 4.0)]
  let rect = aabb(pts)
  assert_true(@core.approx_eq(rect.width(), 0.0, 0.000000001))
  assert_true(@core.approx_eq(rect.height(), 0.0, 0.000000001))
}

///|
test "aabb empty" {
  let pts : Array[@core.Point2D] = []
  let rect = aabb(pts)
  assert_true(@core.approx_eq(rect.width(), 0.0, 0.000000001))
}

///|
test "aabb negative coords" {
  let pts = [@core.Point2D::new(-3.0, -5.0), @core.Point2D::new(2.0, 1.0)]
  let rect = aabb(pts)
  assert_true(@core.approx_eq(rect.min_x, -3.0, 0.000000001))
  assert_true(@core.approx_eq(rect.min_y, -5.0, 0.000000001))
}

///|
test "aabb_polygon basic" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let rect = aabb_polygon(poly)
  assert_true(@core.approx_eq(rect.width(), 4.0, 0.000000001))
  assert_true(@core.approx_eq(rect.height(), 4.0, 0.000000001))
}

///|
test "aabb_polygon triangle" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ])
  let rect = aabb_polygon(poly)
  assert_true(@core.approx_eq(rect.width(), 6.0, 0.000000001))
  assert_true(@core.approx_eq(rect.height(), 4.0, 0.000000001))
}

///|
test "min_area_bounding_rect square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let (cx, cy, w, h, _) = min_area_bounding_rect(pts)
  assert_true(@core.approx_eq(w, 4.0, 0.001))
  assert_true(@core.approx_eq(h, 4.0, 0.001))
  assert_true(@core.approx_eq(cx, 2.0, 0.001))
  assert_true(@core.approx_eq(cy, 2.0, 0.001))
}

///|
test "min_area_bounding_rect rotated rectangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(-1.0, 3.0),
  ]
  let (_, _, w, h, _) = min_area_bounding_rect(pts)
  let area = w * h
  assert_true(area > 0.0)
  assert_true(area < 30.0)
}

///|
test "min_area_bounding_rect collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let (_, _, w, h, _) = min_area_bounding_rect(pts)
  assert_true(@core.approx_eq(w, 4.0, 0.001))
  assert_true(@core.approx_eq(h, 0.0, 0.001))
}

///|
test "min_area_bounding_rect single point" {
  let pts = [@core.Point2D::new(3.0, 4.0)]
  let (cx, cy, w, _, _) = min_area_bounding_rect(pts)
  assert_true(@core.approx_eq(cx, 3.0, 0.000000001))
  assert_true(@core.approx_eq(cy, 4.0, 0.000000001))
  assert_true(@core.approx_eq(w, 0.0, 0.000000001))
}

///|
test "min_area_bounding_rect empty" {
  let pts : Array[@core.Point2D] = []
  let (_, _, w, _, _) = min_area_bounding_rect(pts)
  assert_true(@core.approx_eq(w, 0.0, 0.000000001))
}

///|
test "bounding_circle basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let (center, r) = bounding_circle(pts)
  assert_true(r > 0.0)
  for p in pts {
    assert_true(p.dist(center) <= r + 0.0001)
  }
}

///|
test "bounding_circle single point" {
  let pts = [@core.Point2D::new(3.0, 4.0)]
  let (center, r) = bounding_circle(pts)
  assert_true(@core.approx_eq(r, 0.0, 0.000000001))
  assert_true(@core.approx_eq(center.x, 3.0, 0.000000001))
}

///|
test "bounding_circle empty" {
  let pts : Array[@core.Point2D] = []
  let (_, r) = bounding_circle(pts)
  assert_true(@core.approx_eq(r, 0.0, 0.000000001))
}

///|
test "bounding_circle symmetric" {
  let pts = [
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(0.0, -2.0),
  ]
  let (center, r) = bounding_circle(pts)
  assert_true(@core.approx_eq(center.x, 0.0, 0.000000001))
  assert_true(@core.approx_eq(center.y, 0.0, 0.000000001))
  assert_true(@core.approx_eq(r, 2.0, 0.000000001))
}

///|
test "aabb contains all points" {
  let pts = [
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(3.0, 2.0),
    @core.Point2D::new(7.0, 8.0),
    @core.Point2D::new(2.0, 1.0),
  ]
  let rect = aabb(pts)
  for p in pts {
    assert_true(rect.contains(p))
  }
}

///|
test "min_area_bounding_rect triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let (_, _, w, h, _) = min_area_bounding_rect(pts)
  assert_true(@core.approx_eq(w, 6.0, 0.001))
  assert_true(@core.approx_eq(h, 4.0, 0.001))
}

///|
test "aabb single point extra" {
  let pts = [@core.Point2D::new(5.0, 7.0)]
  let rect = aabb(pts)
  assert_true(@core.approx_eq(rect.width(), 0.0, 0.000000001))
  assert_true(@core.approx_eq(rect.height(), 0.0, 0.000000001))
}

///|
test "aabb_polygon single vertex" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 8.0)])
  let rect = aabb_polygon(poly)
  assert_true(@core.approx_eq(rect.width(), 0.0, 0.000000001))
  assert_true(@core.approx_eq(rect.height(), 0.0, 0.000000001))
}

///|
test "bounding_circle two points" {
  let pts = [@core.Point2D::new(-3.0, 0.0), @core.Point2D::new(3.0, 0.0)]
  let (center, r) = bounding_circle(pts)
  assert_true(@core.approx_eq(center.x, 0.0, 0.000000001))
  assert_true(@core.approx_eq(r, 3.0, 0.000000001))
}

///|
test "min_area_bounding_rect two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(5.0, 0.0)]
  let (_, _, w, h, _) = min_area_bounding_rect(pts)
  assert_true(@core.approx_eq(w, 5.0, 0.001))
  assert_true(@core.approx_eq(h, 0.0, 0.001))
}
