///|
/// Union of two overlapping intervals. / 两区间并集。
pub fn Interval::union(a : Interval, b : Interval) -> Interval {
  let lo = if a.lo < b.lo { a.lo } else { b.lo }
  let hi = if a.hi > b.hi { a.hi } else { b.hi }
  { lo, hi }
}


///|
/// Length of the interval. / 区间长度。
pub fn Interval::length(i : Interval) -> Double {
  i.hi - i.lo
}


///|
/// Midpoint of the interval. / 区间中点。
pub fn Interval::midpoint(i : Interval) -> Double {
  (i.lo + i.hi) / 2.0
}
