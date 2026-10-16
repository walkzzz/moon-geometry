test "interval add" {
  let a = Interval::new(1.0, 2.0)
  let b = Interval::new(3.0, 4.0)
  let c = a.add(b)
  assert_eq(c.lo, 4.0)
  assert_eq(c.hi, 6.0)
}

test "interval mul" {
  let a = Interval::new(1.0, 2.0)
  let b = Interval::new(3.0, 4.0)
  let c = a.mul(b)
  assert_eq(c.lo, 3.0)
  assert_eq(c.hi, 8.0)
}

test "interval contains zero" {
  let a = Interval::new(-1.0, 1.0)
  assert_true(a.contains_zero())
}
