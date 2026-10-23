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
