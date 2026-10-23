///|
/// Shape context cost between two point sets.
/// 两个点集之间的形状上下文代价矩阵。
fn sc_cost(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
) -> Array[Array[Double]] {
  let n_r = 5
  let n_theta = 8
  let sc1 = @shape_context.shape_context(source, n_r, n_theta)
  let sc2 = @shape_context.shape_context(target, n_r, n_theta)
  @shape_context.shape_context_cost(sc1, sc2)
}


///|
/// Shape matching via shape context + Hungarian algorithm.
/// 通过形状上下文 + 匈牙利算法进行形状匹配。
///
/// Returns array of target indices for each source point.
/// 返回每个源点对应的目标点索引。
pub fn shape_matching_hungarian(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
) -> Array[Int] {
  let cost = sc_cost(source, target)
  hungarian(cost)
}


///|
/// Overall shape matching score (lower = better match).
/// 整体形状匹配得分（越低匹配越好）。
pub fn shape_matching_score(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
) -> Double {
  let cost = sc_cost(source, target)
  let assign = hungarian(cost)
  let mut total = 0.0
  for i in 0..<assign.length() {
    let j = assign[i]
    if j >= 0 {
      total += cost[i][j]
    }
  }
  total
}