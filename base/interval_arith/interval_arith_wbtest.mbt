///|
test "geo interval add" {
  let a = GeoInterval::new(1.0, 0.1)
  let b = GeoInterval::new(2.0, 0.2)
  let c = a.add(b)
  assert_eq(c.center, 3.0)
  assert_true((c.radius - 0.3).abs() < 1.0e-10)
}

///|
test "geo interval contains" {
  let a = GeoInterval::new(5.0, 1.0)
  assert_true(a.contains(5.5))
  assert_true(!a.contains(7.0))
}

///|
test "geo interval overlaps" {
  let a = GeoInterval::new(0.0, 1.0)
  let b = GeoInterval::new(1.5, 1.0)
  assert_true(a.overlaps(b))
}

///|
test "geo interval new" {
  let a = GeoInterval::new(3.5, 0.7)
  assert_eq(a.center, 3.5)
  assert_eq(a.radius, 0.7)
}

///|
test "geo interval sub" {
  let a = GeoInterval::new(5.0, 0.3)
  let b = GeoInterval::new(2.0, 0.1)
  let c = a.sub(b)
  assert_eq(c.center, 3.0)
  assert_true((c.radius - 0.4).abs() < 1.0e-10)
}

///|
test "geo interval sub negative result" {
  let a = GeoInterval::new(1.0, 0.1)
  let b = GeoInterval::new(3.0, 0.2)
  let c = a.sub(b)
  assert_eq(c.center, -2.0)
  assert_true((c.radius - 0.3).abs() < 1.0e-10)
}

///|
test "geo interval mul basic" {
  let a = GeoInterval::new(2.0, 0.1)
  let b = GeoInterval::new(3.0, 0.2)
  let c = a.mul(b)
  assert_eq(c.center, 6.0)
  assert_true(c.radius > 0.0)
}

///|
test "geo interval mul with zero" {
  let a = GeoInterval::new(0.0, 0.0)
  let b = GeoInterval::new(5.0, 1.0)
  let c = a.mul(b)
  assert_eq(c.center, 0.0)
  assert_eq(c.radius, 0.0)
}

///|
test "geo interval mul by one" {
  let a = GeoInterval::new(4.0, 0.5)
  let one = GeoInterval::new(1.0, 0.0)
  let c = a.mul(one)
  assert_eq(c.center, 4.0)
  assert_true((c.radius - 0.5).abs() < 1.0e-10)
}

///|
test "geo interval contains boundary" {
  let a = GeoInterval::new(5.0, 1.0)
  assert_true(a.contains(4.0))
  assert_true(a.contains(6.0))
  assert_true(a.contains(5.0))
  assert_true(!a.contains(3.99))
  assert_true(!a.contains(6.01))
}

///|
test "geo interval contains negative" {
  let a = GeoInterval::new(-3.0, 2.0)
  assert_true(a.contains(-3.0))
  assert_true(a.contains(-1.0))
  assert_true(a.contains(-5.0))
  assert_true(!a.contains(0.0))
}

///|
test "geo interval overlaps disjoint" {
  let a = GeoInterval::new(0.0, 1.0)
  let b = GeoInterval::new(5.0, 1.0)
  assert_true(!a.overlaps(b))
}

///|
test "geo interval overlaps touching" {
  let a = GeoInterval::new(0.0, 1.0)
  let b = GeoInterval::new(2.0, 1.0)
  assert_true(a.overlaps(b))
}

///|
test "geo interval overlaps self" {
  let a = GeoInterval::new(1.0, 0.5)
  assert_true(a.overlaps(a))
}

///|
test "geo interval add negative" {
  let a = GeoInterval::new(-1.0, 0.1)
  let b = GeoInterval::new(-2.0, 0.2)
  let c = a.add(b)
  assert_eq(c.center, -3.0)
  assert_true((c.radius - 0.3).abs() < 1.0e-10)
}
