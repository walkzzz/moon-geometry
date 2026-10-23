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
