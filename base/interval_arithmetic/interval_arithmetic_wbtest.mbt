///|
test "Interval::new" {
  let i = Interval::new(1.0, 3.0)
  assert_true((interval_width(i) - 2.0).abs() < 0.001)
}

///|
test "interval_add" {
  let r = interval_add(Interval::new(1.0, 2.0), Interval::new(3.0, 4.0))
  assert_true((r.lo - 4.0).abs() < 0.001)
  assert_true((r.hi - 6.0).abs() < 0.001)
}

///|
test "interval_mul" {
  let r = interval_mul(Interval::new(1.0, 2.0), Interval::new(3.0, 4.0))
  assert_true((r.lo - 3.0).abs() < 0.001)
  assert_true((r.hi - 8.0).abs() < 0.001)
}

///|
test "interval_contains" {
  let i = Interval::new(1.0, 3.0)
  assert_true(interval_contains(i, 2.0))
  assert_false(interval_contains(i, 4.0))
}

///|
test "interval_midpoint" {
  let i = Interval::new(1.0, 3.0)
  assert_true((interval_midpoint(i) - 2.0).abs() < 0.001)
}
