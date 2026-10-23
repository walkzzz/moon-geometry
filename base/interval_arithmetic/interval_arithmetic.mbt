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
  if lo <= hi {
    { lo, hi, }
  } else {
    { hi, lo, }
  }
}

///|
pub fn interval_add(a : Interval, b : Interval) -> Interval {
  { lo: a.lo + b.lo, hi: a.hi + b.hi, }
}

///|
pub fn interval_sub(a : Interval, b : Interval) -> Interval {
  { lo: a.lo - b.hi, hi: a.hi - b.lo, }
}

///|
pub fn interval_mul(a : Interval, b : Interval) -> Interval {
  let p1 = a.lo * b.lo
  let p2 = a.lo * b.hi
  let p3 = a.hi * b.lo
  let p4 = a.hi * b.hi
  let lo = if p1 <= p2 && p1 <= p3 && p1 <= p4 {
    p1
  } else if p2 <= p3 && p2 <= p4 {
    p2
  } else if p3 <= p4 {
    p3
  } else {
    p4
  }
  let hi = if p1 >= p2 && p1 >= p3 && p1 >= p4 {
    p1
  } else if p2 >= p3 && p2 >= p4 {
    p2
  } else if p3 >= p4 {
    p3
  } else {
    p4
  }
  { lo, hi, }
}

///|
pub fn interval_contains(i : Interval, x : Double) -> Bool {
  x >= i.lo && x <= i.hi
}

///|
pub fn interval_width(i : Interval) -> Double {
  i.hi - i.lo
}

///|
pub fn interval_midpoint(i : Interval) -> Double {
  (i.lo + i.hi) / 2.0
}
