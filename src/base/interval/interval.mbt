///|
/// Closed interval [lo, hi]. / 闭区间 [lo, hi]。
pub struct Interval {
  lo : Double
  hi : Double
} derive(Debug)

pub extend Interval with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Construct an interval. / 构造区间。
pub fn Interval::new(lo : Double, hi : Double) -> Interval {
  if lo <= hi {
    { lo, hi }
  } else {
    { lo: hi, hi: lo }
  }
}

///|
/// Check if value is in the interval. / 检查值是否在区间内。
pub fn Interval::contains(i : Interval, x : Double) -> Bool {
  x >= i.lo && x <= i.hi
}

///|
/// Intersection of two intervals. Returns None if disjoint. / 两区间交集。
pub fn Interval::intersect(a : Interval, b : Interval) -> Interval? {
  let lo = if a.lo > b.lo { a.lo } else { b.lo }
  let hi = if a.hi < b.hi { a.hi } else { b.hi }
  if lo <= hi {
    Some({ lo, hi })
  } else {
    None
  }
}

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

///|
/// Check if two intervals overlap. / 检查两区间是否重叠。
pub fn Interval::overlaps(a : Interval, b : Interval) -> Bool {
  a.lo <= b.hi && b.lo <= a.hi
}

///|
/// Check if interval a contains interval b. / 检查区间 a 是否包含区间 b。
pub fn Interval::contains_interval(a : Interval, b : Interval) -> Bool {
  a.lo <= b.lo && b.hi <= a.hi
}