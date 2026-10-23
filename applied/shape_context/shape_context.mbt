///|
/// # Shape Context Descriptor
/// # 形状上下文描述子
///
/// Log-polar histogram of relative point positions around each point.
/// 每个点周围相对点位置的极对数直方图。
///
/// ## Complexity: O(n^2 * (r_bins * theta_bins))
/// ## 复杂度: O(n^2 * (r_bins * theta_bins))

///|
/// Natural log helper using log2. / 使用 log2 的自然对数辅助函数。
fn ln(x : Double) -> Double {
  @math.log2(x) * 0.6931471805599453
}
