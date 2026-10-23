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
