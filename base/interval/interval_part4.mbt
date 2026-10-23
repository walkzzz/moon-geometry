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