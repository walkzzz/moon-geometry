///|
/// Intersection of two intervals. Returns None if disjoint. / 两区间交集。
pub fn Interval::intersect(a : Interval, b : Interval) -> Interval? {
  let lo = if a.lo > b.lo { a.lo } else { b.lo }
  let hi = if a.hi < b.hi { a.hi } else { b.hi }
  if lo <= hi {
    Some({ lo, hi, })
  } else {
    None
  }
}
