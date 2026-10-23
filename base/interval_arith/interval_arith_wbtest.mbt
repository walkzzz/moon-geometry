test "geo interval add" {
  let a = GeoInterval::new(1.0, 0.1)
  let b = GeoInterval::new(2.0, 0.2)
  let c = a.add(b)
  assert_eq(c.center, 3.0)
  assert_true((c.radius - 0.3).abs() < 1.0e-10)
}

test "geo interval contains" {
  let a = GeoInterval::new(5.0, 1.0)
  assert_true(a.contains(5.5))
  assert_true(!a.contains(7.0))
}

test "geo interval overlaps" {
  let a = GeoInterval::new(0.0, 1.0)
  let b = GeoInterval::new(1.5, 1.0)
  assert_true(a.overlaps(b))
}
