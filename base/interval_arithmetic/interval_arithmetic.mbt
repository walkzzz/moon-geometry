///|
/// # Interval Arithmetic
/// # 区间算术
///
/// Interval arithmetic for robust geometric computation.
/// 用于鲁棒几何计算的区间算术。


///|
pub struct Interval {
  lo : Double
  hi : Double
}


///|
pub fn Interval::new(lo : Double, hi : Double) -> Interval {
  if lo <= hi { { lo, hi } } else { { hi, lo } }
}


///|
pub fn interval_add(a : Interval, b : Interval) -> Interval {
  { lo: a.lo + b.lo, hi: a.hi + b.hi }
}


///|
pub fn interval_sub(a : Interval, b : Interval) -> Interval {
  { lo: a.lo - b.hi, hi: a.hi - b.lo }
}
