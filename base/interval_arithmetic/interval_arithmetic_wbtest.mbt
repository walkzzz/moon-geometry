test "Interval::new" {
  let i = Interval::new(1.0, 3.0)
  assert_true((interval_width(i) - 2.0).abs() < 0.001)
}

test "interval_add" {
  let r = interval_add(Interval::new(1.0, 2.0), Interval::new(3.0, 4.0))
  assert_true((r.lo - 4.0).abs() < 0.001)
  assert_true((r.hi - 6.0).abs() < 0.001)
}

test "interval_mul" {
  let r = interval_mul(Interval::new(1.0, 2.0), Interval::new(3.0, 4.0))
  assert_true((r.lo - 3.0).abs() < 0.001)
  assert_true((r.hi - 8.0).abs() < 0.001)
}

test "interval_contains" {
  let i = Interval::new(1.0, 3.0)
  assert_true(interval_contains(i, 2.0))
  assert_false(interval_contains(i, 4.0))
}

test "interval_midpoint" {
  let i = Interval::new(1.0, 3.0)
  assert_true((interval_midpoint(i) - 2.0).abs() < 0.001)
}
test "interval_sub" {
  let r = interval_sub(Interval::new(5.0, 7.0), Interval::new(1.0, 2.0))
  assert_true((r.lo - 3.0).abs() < 0.001)
  assert_true((r.hi - 6.0).abs() < 0.001)
}

test "Interval::new ordered" {
  let i = Interval::new(1.0, 3.0)
  assert_true((i.lo - 1.0).abs() < 0.001)
  assert_true((i.hi - 3.0).abs() < 0.001)
}

test "interval_width explicit" {
  let i = Interval::new(2.0, 8.0)
  assert_true((interval_width(i) - 6.0).abs() < 0.001)
}

test "interval_contains boundary" {
  let i = Interval::new(1.0, 3.0)
  assert_true(interval_contains(i, 1.0))
  assert_true(interval_contains(i, 3.0))
  assert_false(interval_contains(i, 0.5))
}

test "interval_mul negative" {
  let r = interval_mul(Interval::new(-2.0, -1.0), Interval::new(3.0, 4.0))
  assert_true((r.lo - (-8.0)).abs() < 0.001)
  assert_true((r.hi - (-3.0)).abs() < 0.001)
}
