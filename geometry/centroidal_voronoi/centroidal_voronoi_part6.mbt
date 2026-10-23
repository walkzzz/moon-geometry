///|
/// Perform one Lloyd iteration: move each site to its cell centroid. / 执行一次 Lloyd 迭代：将每个站点移至其单元质心。
pub fn lloyd_iteration(
  sites : Array[@core.Point2D],
  bounds : (@core.Point2D, @core.Point2D),
  max_iter : Int,
) -> Array[@core.Point2D] {
  let result = sites.copy()
  let mut iter = 0
  while iter < max_iter {
    let mut max_move = 0.0
    for i in 0..<result.length() {
      let cell = voronoi_cell(result, i, bounds)
      if cell.length() < 3 {
        continue
      }
      let centroid = compute_centroid(cell)
      let move_dist = result[i].dist(centroid)
      if move_dist > max_move {
        max_move = move_dist
      }
      result[i] = centroid
    }
    if max_move < 0.0000001 {
      break
    }
    iter += 1
  }
  result
}
