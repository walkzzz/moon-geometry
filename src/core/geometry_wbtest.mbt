///|
test "Point2D::new and accessors" {
  let p = Point2D::new(3.0, 4.0)
  assert_true(approx_eq(p.x(), 3.0, 0.000000001))
  assert_true(approx_eq(p.y(), 4.0, 0.000000001))
}

///|
test "Point2D::dist_sq" {
  let p = Point2D::new(0.0, 0.0)
  let q = Point2D::new(3.0, 4.0)
  assert_true(approx_eq(p.dist_sq(q), 25.0, 0.000000001))
}

///|
test "Point2D::dist" {
  let p = Point2D::new(0.0, 0.0)
  let q = Point2D::new(3.0, 4.0)
  assert_true(approx_eq(p.dist(q), 5.0, 0.000000001))
}

///|
test "Point2D::dist symmetric" {
  let p = Point2D::new(1.0, 2.0)
  let q = Point2D::new(4.0, 6.0)
  assert_true(approx_eq(p.dist(q), q.dist(p), 0.000000001))
}

///|
test "Point2D::dist to self is zero" {
  let p = Point2D::new(5.0, -3.0)
  assert_true(approx_eq(p.dist(p), 0.0, 0.000000001))
}

///|
test "Point2D::add" {
  let p = Point2D::new(1.0, 2.0)
  let q = Point2D::new(3.0, 4.0)
  let r = p.add(q)
  assert_true(approx_eq(r.x(), 4.0, 0.000000001))
  assert_true(approx_eq(r.y(), 6.0, 0.000000001))
}

///|
test "Point2D::sub" {
  let p = Point2D::new(5.0, 7.0)
  let q = Point2D::new(2.0, 3.0)
  let r = p.sub(q)
  assert_true(approx_eq(r.x(), 3.0, 0.000000001))
  assert_true(approx_eq(r.y(), 4.0, 0.000000001))
}

///|
test "Point2D::mul scalar" {
  let p = Point2D::new(2.0, 3.0)
  let r = p.mul(2.0)
  assert_true(approx_eq(r.x(), 4.0, 0.000000001))
  assert_true(approx_eq(r.y(), 6.0, 0.000000001))
}

///|
test "Point2D::dot" {
  let p = Point2D::new(1.0, 2.0)
  let q = Point2D::new(3.0, 4.0)
  assert_true(approx_eq(p.dot(q), 11.0, 0.000000001))
}

///|
test "Point2D::cross" {
  let p = Point2D::new(1.0, 0.0)
  let q = Point2D::new(0.0, 1.0)
  assert_true(approx_eq(p.cross(q), 1.0, 0.000000001))
}

///|
test "Point2D::cross anti-symmetric" {
  let p = Point2D::new(3.0, 1.0)
  let q = Point2D::new(2.0, 5.0)
  assert_true(approx_eq(p.cross(q), -q.cross(p), 0.000000001))
}

///|
test "Point2D::equals" {
  let p = Point2D::new(1.0, 2.0)
  let q = Point2D::new(1.0, 2.0)
  let r = Point2D::new(1.0, 3.0)
  assert_true(p.equals(q))
  assert_false(p.equals(r))
}

///|
test "Point2D::approx_eq" {
  let p = Point2D::new(1.0, 2.0)
  let q = Point2D::new(1.0 + 0.0000000001, 2.0 - 0.0000000001)
  assert_true(p.approx_eq(q, 0.000000001))
  assert_false(p.approx_eq(q, 0.000000000001))
}

///|
test "Point3D::dist" {
  let p = Point3D::new(0.0, 0.0, 0.0)
  let q = Point3D::new(1.0, 2.0, 2.0)
  assert_true(approx_eq(p.dist(q), 3.0, 0.000000001))
}

///|
test "Point3D::dot" {
  let p = Point3D::new(1.0, 2.0, 3.0)
  let q = Point3D::new(4.0, 5.0, 6.0)
  assert_true(approx_eq(p.dot(q), 32.0, 0.000000001))
}

///|
test "Point3D::cross" {
  let i = Point3D::new(1.0, 0.0, 0.0)
  let j = Point3D::new(0.0, 1.0, 0.0)
  let k = i.cross(j)
  assert_true(approx_eq(k.x, 0.0, 0.000000001))
  assert_true(approx_eq(k.y, 0.0, 0.000000001))
  assert_true(approx_eq(k.z, 1.0, 0.000000001))
}

///|
test "Point3D::add sub mul" {
  let p = Point3D::new(1.0, 2.0, 3.0)
  let q = Point3D::new(4.0, 5.0, 6.0)
  let s = p.add(q)
  assert_true(approx_eq(s.x, 5.0, 0.000000001))
  assert_true(approx_eq(s.z, 9.0, 0.000000001))
  let d = q.sub(p)
  assert_true(approx_eq(d.y, 3.0, 0.000000001))
  let m = p.mul(2.0)
  assert_true(approx_eq(m.z, 6.0, 0.000000001))
}

///|
test "approx_eq helper" {
  assert_true(approx_eq(1.0, 1.0 + 0.0000000001, 0.000000001))
  assert_false(approx_eq(1.0, 1.1, 0.000000001))
}
///|
test "Point2D add commutative" {
  let p = Point2D::new(3.0, 5.0)
  let q = Point2D::new(7.0, 2.0)
  let s1 = p.add(q)
  let s2 = q.add(p)
  assert_true(approx_eq(s1.x, s2.x, 0.000000001))
  assert_true(approx_eq(s1.y, s2.y, 0.000000001))
}

///|
test "Point2D add associative" {
  let p = Point2D::new(1.0, 2.0)
  let q = Point2D::new(3.0, 4.0)
  let r = Point2D::new(5.0, 6.0)
  let a1 = p.add(q).add(r)
  let a2 = p.add(q.add(r))
  assert_true(approx_eq(a1.x, a2.x, 0.000000001))
  assert_true(approx_eq(a1.y, a2.y, 0.000000001))
}

///|
test "Point2D sub equals add negative" {
  let p = Point2D::new(10.0, 20.0)
  let q = Point2D::new(3.0, 7.0)
  let d1 = p.sub(q)
  let d2 = p.add(q.mul(-1.0))
  assert_true(approx_eq(d1.x, d2.x, 0.000000001))
  assert_true(approx_eq(d1.y, d2.y, 0.000000001))
}

///|
test "Point2D mul distributive" {
  let p = Point2D::new(3.0, 4.0)
  let a = 2.0
  let b = 5.0
  let m1 = p.mul(a + b)
  let m2 = p.mul(a).add(p.mul(b))
  assert_true(approx_eq(m1.x, m2.x, 0.000000001))
  assert_true(approx_eq(m1.y, m2.y, 0.000000001))
}

///|
test "Point2D dot commutative" {
  let p = Point2D::new(3.0, 5.0)
  let q = Point2D::new(7.0, 2.0)
  assert_true(approx_eq(p.dot(q), q.dot(p), 0.000000001))
}

///|
test "Point2D cross anti-symmetric" {
  let p = Point2D::new(3.0, 5.0)
  let q = Point2D::new(7.0, 2.0)
  assert_true(approx_eq(p.cross(q), -q.cross(p), 0.000000001))
}

///|
test "Point2D dist symmetric" {
  let p = Point2D::new(1.0, 2.0)
  let q = Point2D::new(5.0, 6.0)
  assert_true(approx_eq(p.dist(q), q.dist(p), 0.000000001))
}

///|
test "Point2D dist_sq zero to self" {
  let p = Point2D::new(42.0, -17.0)
  assert_true(approx_eq(p.dist_sq(p), 0.0, 0.000000001))
}

///|
test "Point2D zero vector identity" {
  let z = Point2D::new(0.0, 0.0)
  let p = Point2D::new(3.0, 7.0)
  let s = z.add(p)
  assert_true(approx_eq(s.x, p.x, 0.000000001))
  assert_true(approx_eq(s.y, p.y, 0.000000001))
}

///|
test "Point2D mul by one identity" {
  let p = Point2D::new(3.0, 7.0)
  let m = p.mul(1.0)
  assert_true(approx_eq(m.x, p.x, 0.000000001))
  assert_true(approx_eq(m.y, p.y, 0.000000001))
}
