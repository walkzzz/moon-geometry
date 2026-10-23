///|
/// Compute LCA (Lowest Common Ancestor) using the Euler tour + RMQ. / 使用欧拉回路 + RMQ 计算最近公共祖先。
pub fn euler_tour_lca(tour : EulerTour, u : Int32, v : Int32) -> Int32 {
  let pu = euler_tour_first_occurrence(tour, u)
  let pv = euler_tour_first_occurrence(tour, v)
  if pu == -1 || pv == -1 {
    return -1
  }
  let lo = if pu < pv { pu } else { pv }
  let hi = if pu > pv { pu } else { pv }
  let mut min_depth = tour.depth[lo]
  let mut min_idx = lo
  for i in (lo + 1)..<=hi {
    if tour.depth[i] < min_depth {
      min_depth = tour.depth[i]
      min_idx = i
    }
  }
  tour.tour[min_idx]
}
