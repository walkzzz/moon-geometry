///|
/// Closed interval type. / 闭区间类型。
pub type Interval = @interval.Interval


///|
/// Construct an interval. / 构造区间。
pub fn interval_new(lo : Double, hi : Double) -> Interval {
  @interval.Interval::new(lo, hi)
}


///|
/// Check if value is in the interval. / 检查值是否在区间内。
pub fn interval_contains(i : Interval, x : Double) -> Bool {
  @interval.Interval::contains(i, x)
}


///|
/// Intersection of two intervals. / 两区间交集。
pub fn interval_intersect(a : Interval, b : Interval) -> Interval? {
  @interval.Interval::intersect(a, b)
}


///|
/// Union of two overlapping intervals. / 两区间并集。
pub fn interval_union(a : Interval, b : Interval) -> Interval {
  @interval.Interval::union(a, b)
}


///|
/// Length of the interval. / 区间长度。
pub fn interval_length(i : Interval) -> Double {
  @interval.Interval::length(i)
}
