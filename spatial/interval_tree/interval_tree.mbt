/// |
/// # Interval Tree
/// # 区间树
///
/// Interval tree for 1D interval stabbing queries.
/// 用于一维区间刺查的区间树。
///
/// ## Complexity: O(n log n) build, O(log n + k) query
/// ## 复杂度: 构建 O(n log n)，查询 O(log n + k)

/// |
/// Interval entry.
/// 区间条目。
pub struct Interval {
  lo : Double
  hi : Double
  id : Int
}
