///|
test "Triangle::area right" {
  let t = Triangle::new(
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(0.0, 3.0),
  )
  assert_true(approx_eq(t.area(), 6.0, 0.000000001))
}

///|
test "Triangle::signed_area ccw positive" {
  let t = Triangle::new(
    Point2D::new(0.0, 0.0),
    Point2D::new(1.0, 0.0),
    Point2D::new(0.0, 1.0),
  )
  assert_true(t.signed_area() > 0.0)
}

///|
test "Triangle::signed_area cw negative" {
  let t = Triangle::new(
    Point2D::new(0.0, 0.0),
    Point2D::new(0.0, 1.0),
    Point2D::new(1.0, 0.0),
  )
  assert_true(t.signed_area() < 0.0)
}

///|
test "Triangle::centroid" {
  let t = Triangle::new(
    Point2D::new(0.0, 0.0),
    Point2D::new(6.0, 0.0),
    Point2D::new(0.0, 6.0),
  )
  let c = t.centroid()
  assert_true(approx_eq(c.x(), 2.0, 0.000000001))
  assert_true(approx_eq(c.y(), 2.0, 0.000000001))
}

///|
test "Triangle::circumcenter right triangle" {
  // right triangle at origin, hypotenuse midpoint is circumcenter
  let t = Triangle::new(
    Point2D::new(0.0, 0.0),
    Point2D::new(4.0, 0.0),
    Point2D::new(0.0, 4.0),
  )
  let c = t.circumcenter()
  assert_true(approx_eq(c.x(), 2.0, 0.000000001))
  assert_true(approx_eq(c.y(), 2.0, 0.000000001))
}

///|
test "Triangle::incenter equilateral" {
  let t = Triangle::new(
    Point2D::new(0.0, 0.0),
    Point2D::new(2.0, 0.0),
    Point2D::new(1.0, 1.7320508075688772),
  )
  let c = t.incenter()
  assert_true(approx_eq(c.x(), 1.0, 0.000001))
}

///|
test "Circle::area" {
  let c = Circle::new(Point2D::new(0.0, 0.0), 2.0)
  assert_true(approx_eq(c.area(), 12.566370614359172, 0.000000001))
}

///|
test "Circle::perimeter" {
  let c = Circle::new(Point2D::new(0.0, 0.0), 3.0)
  assert_true(approx_eq(c.perimeter(), 18.84955592153876, 0.000000001))
}

///|
test "Circle::contains inside" {
  let c = Circle::new(Point2D::new(0.0, 0.0), 5.0)
  assert_true(c.contains(Point2D::new(3.0, 4.0)))
}

///|
test "Circle::contains outside" {
  let c = Circle::new(Point2D::new(0.0, 0.0), 1.0)
  assert_false(c.contains(Point2D::new(2.0, 0.0)))
}

///|
test "Circle::contains on boundary" {
  let c = Circle::new(Point2D::new(0.0, 0.0), 5.0)
  assert_true(c.contains(Point2D::new(5.0, 0.0)))
}

///|
test "Rectangle::area" {
  let r = Rectangle::new(0.0, 0.0, 4.0, 3.0)
  assert_true(approx_eq(r.area(), 12.0, 0.000000001))
}

///|
test "Rectangle::perimeter" {
  let r = Rectangle::new(0.0, 0.0, 4.0, 3.0)
  assert_true(approx_eq(r.perimeter(), 14.0, 0.000000001))
}

///|
test "Rectangle::from_corners" {
  let r = Rectangle::from_corners(
    Point2D::new(4.0, 3.0),
    Point2D::new(0.0, 0.0),
  )
  assert_true(approx_eq(r.min_x, 0.0, 0.000000001))
  assert_true(approx_eq(r.max_x, 4.0, 0.000000001))
}

///|
test "Rectangle::contains" {
  let r = Rectangle::new(0.0, 0.0, 4.0, 3.0)
  assert_true(r.contains(Point2D::new(2.0, 1.5)))
  assert_false(r.contains(Point2D::new(5.0, 1.5)))
}

///|
test "Rectangle::union" {
  let r1 = Rectangle::new(0.0, 0.0, 2.0, 2.0)
  let r2 = Rectangle::new(1.0, 1.0, 3.0, 3.0)
  let u = r1.union(r2)
  assert_true(approx_eq(u.min_x, 0.0, 0.000000001))
  assert_true(approx_eq(u.max_x, 3.0, 0.000000001))
}

///|
test "Rectangle::intersection overlapping" {
  let r1 = Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let r2 = Rectangle::new(2.0, 2.0, 6.0, 6.0)
  match r1.intersection(r2) {
    Some(r) => {
      assert_true(approx_eq(r.min_x, 2.0, 0.000000001))
      assert_true(approx_eq(r.max_x, 4.0, 0.000000001))
    }
    None => assert_true(false)
  }
}

///|
test "Rectangle::intersection disjoint" {
  let r1 = Rectangle::new(0.0, 0.0, 1.0, 1.0)
  let r2 = Rectangle::new(2.0, 2.0, 3.0, 3.0)
  assert_true(r1.intersection(r2) is None)
}

///|
test "Circle::contains center" {
  let c = Circle::new(Point2D::new(3.0, 4.0), 5.0)
  assert_true(c.contains(Point2D::new(3.0, 4.0)))
}

///|
test "Rectangle::union area" {
  let r1 = Rectangle::new(0.0, 0.0, 2.0, 2.0)
  let r2 = Rectangle::new(1.0, 1.0, 3.0, 3.0)
  let u = r1.union(r2)
  assert_true(approx_eq(u.min_x, 0.0, 0.000000001))
  assert_true(approx_eq(u.max_x, 3.0, 0.000000001))
  assert_true(approx_eq(u.min_y, 0.0, 0.000000001))
  assert_true(approx_eq(u.max_y, 3.0, 0.000000001))
}
