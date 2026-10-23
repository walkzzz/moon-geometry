///|
/// Theoretical upper bound on zone complexity: O(n) for n segments. / 区域复杂度的理论上界：n 条线段为 O(n)。
pub fn zone_complexity_bound(n : Int32) -> Int32 {
  5 * n + 1
}
