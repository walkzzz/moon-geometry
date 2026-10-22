
test "interval: contains" {
  let i = Interval::new(1.0, 5.0)
  assert_true(Interval::contains(i, 3.0))
  assert_false(Interval::contains(i, 6.0))
}

test "interval: intersect" {
  let a = Interval::new(1.0, 5.0)
  let b = Interval::new(3.0, 7.0)
  match Interval::intersect(a, b) {
    Some(r) => {
      assert_true((r.lo - 3.0).abs() < 0.001)
      assert_true((r.hi - 5.0).abs() < 0.001)
    }
    None => assert_true(false)
  }
}

test "interval: intersect disjoint" {
  let a = Interval::new(1.0, 2.0)
  let b = Interval::new(5.0, 7.0)
  match Interval::intersect(a, b) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

test "interval: union" {
  let a = Interval::new(1.0, 5.0)
  let b = Interval::new(3.0, 7.0)
  let r = Interval::union(a, b)
  assert_true((r.lo - 1.0).abs() < 0.001)
  assert_true((r.hi - 7.0).abs() < 0.001)
}

test "interval: length" {
  let i = Interval::new(2.0, 8.0)
  assert_true((Interval::length(i) - 6.0).abs() < 0.001)
}

test "interval: midpoint" {
  let i = Interval::new(2.0, 8.0)
  assert_true((Interval::midpoint(i) - 5.0).abs() < 0.001)
}

test "interval: overlaps" {
  let a = Interval::new(1.0, 5.0)
  let b = Interval::new(3.0, 7.0)
  let c = Interval::new(6.0, 8.0)
  assert_true(Interval::overlaps(a, b))
  assert_false(Interval::overlaps(a, c))
}

test "interval: contains interval" {
  let a = Interval::new(0.0, 10.0)
  let b = Interval::new(3.0, 7.0)
  assert_true(Interval::contains_interval(a, b))
  assert_false(Interval::contains_interval(b, a))
}

test "interval: swapped construction" {
  let i = Interval::new(5.0, 1.0)
  assert_true((i.lo - 1.0).abs() < 0.001)
  assert_true((i.hi - 5.0).abs() < 0.001)
}