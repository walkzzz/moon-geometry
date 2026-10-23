///|
test "aabb_overlap basic" {
  let a = AABB::new(0.0, 0.0, 2.0, 2.0)
  let b = AABB::new(1.0, 1.0, 3.0, 3.0)
  assert_true(aabb_overlap(a, b))
}

///|
test "aabb_overlap disjoint" {
  let a = AABB::new(0.0, 0.0, 1.0, 1.0)
  let b = AABB::new(2.0, 2.0, 3.0, 3.0)
  assert_false(aabb_overlap(a, b))
}

///|
test "aabb_contains basic" {
  let box = AABB::new(0.0, 0.0, 4.0, 4.0)
  assert_true(aabb_contains(box, 2.0, 2.0))
  assert_false(aabb_contains(box, 5.0, 5.0))
}

///|
test "broad_phase_aabb basic" {
  let boxes = [
    AABB::new(0.0, 0.0, 2.0, 2.0),
    AABB::new(1.0, 1.0, 3.0, 3.0),
    AABB::new(10.0, 10.0, 12.0, 12.0),
  ]
  let pairs = broad_phase_aabb(boxes)
  assert_true(pairs.length() >= 1)
}

///|
test "segment_segment_collide crossing" {
  let a1 = @core.Point2D::new(0.0, 0.0)
  let a2 = @core.Point2D::new(2.0, 2.0)
  let b1 = @core.Point2D::new(0.0, 2.0)
  let b2 = @core.Point2D::new(2.0, 0.0)
  assert_true(segment_segment_collide(a1, a2, b1, b2))
}

///|
test "segment_segment_collide parallel" {
  let a1 = @core.Point2D::new(0.0, 0.0)
  let a2 = @core.Point2D::new(2.0, 0.0)
  let b1 = @core.Point2D::new(0.0, 1.0)
  let b2 = @core.Point2D::new(2.0, 1.0)
  assert_false(segment_segment_collide(a1, a2, b1, b2))
}

///|
test "point_in_polygon basic" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(point_in_polygon(@core.Point2D::new(2.0, 2.0), poly))
  assert_false(point_in_polygon(@core.Point2D::new(5.0, 5.0), poly))
}

///|
test "circle_circle_collide basic" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(3.0, 0.0)
  assert_true(circle_circle_collide(c1, 2.0, c2, 2.0))
  assert_false(circle_circle_collide(c1, 1.0, c2, 1.0))
}

///|
test "polygon_polygon_collide overlapping" {
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
  assert_true(polygon_polygon_collide(poly1, poly2))
}

///|
test "aabb_intersection overlapping" {
  let a = AABB::new(0.0, 0.0, 4.0, 4.0)
  let b = AABB::new(2.0, 2.0, 6.0, 6.0)
  let result = aabb_intersection(a, b)
  match result {
    Some(box) => assert_true((box.min_x - 2.0).abs() < 0.001)
    None => abort("expected intersection")
  }
}

///|
test "aabb_union basic" {
  let a = AABB::new(0.0, 0.0, 2.0, 2.0)
  let b = AABB::new(1.0, 1.0, 3.0, 3.0)
  let u = aabb_union(a, b)
  assert_true((u.min_x - 0.0).abs() < 0.001)
  assert_true((u.max_x - 3.0).abs() < 0.001)
}

///|
test "aabb_area basic" {
  let box = AABB::new(0.0, 0.0, 4.0, 3.0)
  assert_true((aabb_area(box) - 12.0).abs() < 0.001)
}

///|
test "aabb_from_center basic" {
  let box = AABB::from_center(5.0, 5.0, 2.0, 3.0)
  assert_true((box.min_x - 3.0).abs() < 0.001)
  assert_true((box.max_x - 7.0).abs() < 0.001)
}

///|
test "aabb_from_polygon basic" {
  let poly = [
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(3.0, 7.0),
  ]
  let box = aabb_from_polygon(poly)
  assert_true((box.min_x - 1.0).abs() < 0.001)
  assert_true((box.max_x - 5.0).abs() < 0.001)
  assert_true((box.min_y - 2.0).abs() < 0.001)
  assert_true((box.max_y - 7.0).abs() < 0.001)
}

///|
test "segment_polygon_collide crossing" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let a = @core.Point2D::new(-1.0, 2.0)
  let b = @core.Point2D::new(5.0, 2.0)
  assert_true(segment_polygon_collide(a, b, poly))
}

///|
test "segment_polygon_collide disjoint" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let a = @core.Point2D::new(10.0, 10.0)
  let b = @core.Point2D::new(12.0, 12.0)
  assert_false(segment_polygon_collide(a, b, poly))
}

///|
test "circle_polygon_collide inside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(2.0, 2.0)
  assert_true(circle_polygon_collide(center, 0.5, poly))
}

///|
test "circle_polygon_collide disjoint" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(10.0, 10.0)
  assert_false(circle_polygon_collide(center, 0.5, poly))
}

///|
test "aabb_polygon_collide overlapping" {
  let box = AABB::new(1.0, 1.0, 3.0, 3.0)
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(aabb_polygon_collide(box, poly))
}

///|
test "aabb_polygon_collide disjoint" {
  let box = AABB::new(10.0, 10.0, 12.0, 12.0)
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_false(aabb_polygon_collide(box, poly))
}
