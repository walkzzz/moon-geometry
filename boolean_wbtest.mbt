///|
test "clip_polygon inside fully" {
  let poly = Polygon::new([
    Point2D::new(1.0, 1.0),
    Point2D::new(3.0, 1.0),
    Point2D::new(3.0, 3.0),
    Point2D::new(1.0, 3.0),
  ])
  let rect = Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let clipped = clip_polygon(poly, rect)
  assert_eq(clipped.length(), 4)
}

///|
test "clip_polygon partial" {
  let poly = Polygon::new([
    Point2D::new(-1.0, -1.0),
    Point2D::new(5.0, -1.0),
    Point2D::new(5.0, 5.0),
    Point2D::new(-1.0, 5.0),
  ])
  let rect = Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let clipped = clip_polygon(poly, rect)
  assert_eq(clipped.length(), 4)
  // clipped should be the rect itself
  let area = polygon_area(Polygon::new(clipped))
  assert_true(approx_eq(area, 16.0, 0.000000001))
}

///|
test "clip_polygon outside empty" {
  let poly = Polygon::new([
    Point2D::new(5.0, 5.0),
    Point2D::new(7.0, 5.0),
    Point2D::new(7.0, 7.0),
    Point2D::new(5.0, 7.0),
  ])
  let rect = Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let clipped = clip_polygon(poly, rect)
  assert_true(clipped.length() < 3)
}

///|
test "clip_polygon triangle" {
  let poly = Polygon::new([
    Point2D::new(-2.0, 2.0),
    Point2D::new(6.0, 2.0),
    Point2D::new(2.0, 6.0),
  ])
  let rect = Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let clipped = clip_polygon(poly, rect)
  assert_true(clipped.length() >= 3)
}

///|
test "clip_polygon corner" {
  let poly = Polygon::new([
    Point2D::new(-2.0, -2.0),
    Point2D::new(2.0, -2.0),
    Point2D::new(2.0, 2.0),
    Point2D::new(-2.0, 2.0),
  ])
  let rect = Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let clipped = clip_polygon(poly, rect)
  // overlap is 2x2 in corner
  let area = polygon_area(Polygon::new(clipped))
  assert_true(approx_eq(area, 4.0, 0.000000001))
}

///|
test "polygon_intersection two squares" {
  let p1 = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
  ])
  let p2 = Polygon::new([
    Point2D::new(2.0, 2.0),
    Point2D::new(6.0, 2.0),
    Point2D::new(6.0, 6.0),
    Point2D::new(2.0, 6.0),
  ])
  match polygon_intersection(p1, p2) {
    Some(p) => assert_true(approx_eq(polygon_area(p), 4.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "polygon_intersection disjoint none" {
  let p1 = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(0.0, 1.0),
  ])
  let p2 = Polygon::new([
    Point2D::new(5.0, 5.0),
    Point2D::new(6.0, 5.0),
    Point2D::new(6.0, 6.0),
    Point2D::new(5.0, 6.0),
  ])
  assert_true(polygon_intersection(p1, p2) is None)
}

///|
test "polygon_intersection contained" {
  let outer = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(10.0, 0.0),
    Point2D::new(10.0, 10.0),
    Point2D::new(0.0, 10.0),
  ])
  let inner = Polygon::new([
    Point2D::new(2.0, 2.0),
    Point2D::new(4.0, 2.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(2.0, 4.0),
  ])
  match polygon_intersection(outer, inner) {
    Some(p) => assert_true(approx_eq(polygon_area(p), 4.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "polygon_intersection identical" {
  let sq = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(2.0, 2.0),
    Point2D::new(0.0, 2.0),
  ])
  match polygon_intersection(sq, sq) {
    Some(p) => assert_true(approx_eq(polygon_area(p), 4.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "polygon_union_area two squares" {
  let p1 = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
  ])
  let p2 = Polygon::new([
    Point2D::new(2.0, 2.0),
    Point2D::new(6.0, 2.0),
    Point2D::new(6.0, 6.0),
    Point2D::new(2.0, 6.0),
  ])
  // union = 16 + 16 - 4 = 28
  assert_true(approx_eq(polygon_union_area(p1, p2), 28.0, 0.000000001))
}

///|
test "polygon_union_area disjoint" {
  let p1 = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(1.0, 1.0),
    Point2D::new(0.0, 1.0),
  ])
  let p2 = Polygon::new([
    Point2D::new(5.0, 5.0),
    Point2D::new(6.0, 5.0),
    Point2D::new(6.0, 6.0),
    Point2D::new(5.0, 6.0),
  ])
  assert_true(approx_eq(polygon_union_area(p1, p2), 2.0, 0.000000001))
}

///|
test "polygon_difference_area" {
  let p1 = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
  ])
  let p2 = Polygon::new([
    Point2D::new(2.0, 2.0),
    Point2D::new(6.0, 2.0),
    Point2D::new(6.0, 6.0),
    Point2D::new(2.0, 6.0),
  ])
  // diff = 16 - 4 = 12
  assert_true(approx_eq(polygon_difference_area(p1, p2), 12.0, 0.000000001))
}

///|
test "polygon_difference_area no overlap" {
  let p1 = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(2.0, 2.0),
    Point2D::new(0.0, 2.0),
  ])
  let p2 = Polygon::new([
    Point2D::new(5.0, 5.0),
    Point2D::new(6.0, 5.0),
    Point2D::new(6.0, 6.0),
    Point2D::new(5.0, 6.0),
  ])
  assert_true(approx_eq(polygon_difference_area(p1, p2), 4.0, 0.000000001))
}

///|
test "clip_polygon edge touching" {
  let poly = Polygon::new([
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(4.0, 4.0),
    Point2D::new(0.0, 4.0),
  ])
  let rect = Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let clipped = clip_polygon(poly, rect)
  let area = polygon_area(Polygon::new(clipped))
  assert_true(approx_eq(area, 16.0, 0.000000001))
}
