///|
/// Greedy shape context matching: for each source point find best target.
/// 贪心形状上下文匹配：为每个源点找最佳目标点。
///
/// Returns array of target indices for each source point.
/// 返回每个源点对应的目标点索引。
pub fn shape_context_match(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
  n_r_bins : Int32,
  n_theta_bins : Int32,
) -> Array[Int32] {
  let sc1 = shape_context(source, n_r_bins, n_theta_bins)
  let sc2 = shape_context(target, n_r_bins, n_theta_bins)
  let result : Array[Int32] = []
  for i in 0..<sc1.length() {
    let mut best_idx = 0
    let mut best_d = 1.7976931348623157e+308
    for j in 0..<sc2.length() {
      let d = shape_context_distance(sc1[i], sc2[j])
      if d < best_d {
        best_d = d
        best_idx = j
      }
    }
    result.push(best_idx)
  }
  result
}
