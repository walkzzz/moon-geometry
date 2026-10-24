///|
test "rng basic" {
  let r = Rng::new(42U)
  let v1 = r.next_uint()
  let v2 = r.next_uint()
  assert_true(v1 != v2)
}

///|
test "rng next double" {
  let r = Rng::new(42U)
  let d = r.next_double()
  assert_true(d >= 0.0 && d < 1.0)
}

///|
test "rng point2d" {
  let r = Rng::new(42U)
  let p = r.point2d(0.0, 10.0, 0.0, 10.0)
  assert_true(p.x() >= 0.0 && p.x() < 10.0)
  assert_true(p.y() >= 0.0 && p.y() < 10.0)
}

///|
test "rng random points" {
  let r = Rng::new(42U)
  let pts = r.random_points(10, 0.0, 1.0, 0.0, 1.0)
  assert_eq(pts.length(), 10)
}

///|
test "rng convex polygon" {
  let r = Rng::new(42U)
  let poly = r.random_convex_polygon(5, 10.0)
  assert_eq(poly.length(), 5)
}
///|
test "rng range double" {
  let r = Rng::new(42U)
  let d = r.range_double(5.0, 10.0)
  assert_true(d >= 5.0 && d < 10.0)
}

///|
test "rng range double negative" {
  let r = Rng::new(42U)
  let d = r.range_double(-10.0, -5.0)
  assert_true(d >= -10.0 && d < -5.0)
}

///|
test "rng random points on circle" {
  let r = Rng::new(42U)
  let center = @core.Point2D::new(0.0, 0.0)
  let pts = r.random_points_on_circle(8, center, 5.0)
  assert_eq(pts.length(), 8)
}

///|
test "rng random points on circle radius" {
  let r = Rng::new(42U)
  let center = @core.Point2D::new(1.0, 2.0)
  let pts = r.random_points_on_circle(3, center, 5.0)
  for p in pts {
    let dx = p.x() - 1.0
    let dy = p.y() - 2.0
    let dist = (dx * dx + dy * dy).sqrt()
    assert_true(dist > 4.99 && dist < 5.01)
  }
}

///|
test "rng convex polygon radius" {
  let r = Rng::new(42U)
  let poly = r.random_convex_polygon(4, 7.0)
  for p in poly {
    let dist = (p.x() * p.x() + p.y() * p.y()).sqrt()
    assert_true(dist > 6.99 && dist < 7.01)
  }
}

///|
test "rng next uint sequence" {
  let r = Rng::new(1U)
  let v1 = r.next_uint()
  ignore(r.next_uint())
  let v3 = r.next_uint()
  assert_true(v1 != v3)
}

///|
test "rng random points zero" {
  let r = Rng::new(42U)
  let pts = r.random_points(0, 0.0, 1.0, 0.0, 1.0)
  assert_eq(pts.length(), 0)
}

///|
test "rng point2d negative range" {
  let r = Rng::new(42U)
  let p = r.point2d(-5.0, -1.0, -5.0, -1.0)
  assert_true(p.x() >= -5.0 && p.x() < -1.0)
  assert_true(p.y() >= -5.0 && p.y() < -1.0)
}
