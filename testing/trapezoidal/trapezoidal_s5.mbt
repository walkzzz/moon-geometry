///|
/// Compute the expected number of trapezoids (at most 3n + 1 for n segments). / 计算梯形期望数（n 条线段最多 3n + 1 个梯形）。
pub fn trapezoidal_expected_count(
  map : TrapezoidalMap,
) -> Int {
  3 * map.segments.length() + 1
}