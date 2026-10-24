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

///|
test "Interval::new reversed args" {
  let i = Interval::new(5.0, 1.0)
  ignore(i)
}

///|
test "Interval::new equal args" {
  let i = Interval::new(2.0, 2.0)
  assert_true((i.lo - 2.0).abs() < 0.001)
  assert_true((i.hi - 2.0).abs() < 0.001)
}

///|
test "interval_sub" {
  let r = interval_sub(Interval::new(3.0, 5.0), Interval::new(1.0, 2.0))
  assert_true((r.lo - 1.0).abs() < 0.001)
  assert_true((r.hi - 4.0).abs() < 0.001)
}

///|
test "interval_sub negative" {
  let r = interval_sub(Interval::new(-1.0, 1.0), Interval::new(-1.0, 1.0))
  assert_true((r.lo - -2.0).abs() < 0.001)
  assert_true((r.hi - 2.0).abs() < 0.001)
}

///|
test "interval_width" {
  let i = Interval::new(2.0, 8.0)
  assert_true((interval_width(i) - 6.0).abs() < 0.001)
}

///|
test "interval_width zero" {
  let i = Interval::new(3.0, 3.0)
  assert_true(interval_width(i).abs() < 0.001)
}

///|
test "interval_mul negative" {
  let r = interval_mul(Interval::new(-2.0, -1.0), Interval::new(3.0, 4.0))
  assert_true((r.lo - -8.0).abs() < 0.001)
  assert_true((r.hi - -3.0).abs() < 0.001)
}

///|
test "interval_mul mixed signs" {
  let r = interval_mul(Interval::new(-1.0, 2.0), Interval::new(-3.0, 4.0))
  assert_true((r.lo - -6.0).abs() < 0.001)
  assert_true((r.hi - 8.0).abs() < 0.001)
}

///|
test "interval_contains boundary" {
  let i = Interval::new(1.0, 3.0)
  assert_true(interval_contains(i, 1.0))
  assert_true(interval_contains(i, 3.0))
  assert_false(interval_contains(i, 0.5))
  assert_false(interval_contains(i, 3.5))
}

///|
test "interval_add negative" {
  let r = interval_add(Interval::new(-2.0, -1.0), Interval::new(-4.0, -3.0))
  assert_true((r.lo - -6.0).abs() < 0.001)
  assert_true((r.hi - -4.0).abs() < 0.001)
}
