///|
/// Compute centroidal Voronoi tessellation via Lloyd iteration. / 通过 Lloyd 迭代计算质心 Voronoi 镶嵌。
pub fn centroidal_voronoi(
  sites : Array[@core.Point2D],
  bounds : (@core.Point2D, @core.Point2D),
  max_iter : Int32,
) -> CVTResult {
  let final_sites = lloyd_iteration(sites, bounds, max_iter)
  let cells : Array[Array[@core.Point2D]] = []
  let mut actual_iter = 0
  let work_sites = sites.copy()
  while actual_iter < max_iter {
    let mut max_move = 0.0
    for i in 0..<work_sites.length() {
      let cell = voronoi_cell(work_sites, i, bounds)
      if cell.length() < 3 {
        continue
      }
      let centroid = compute_centroid(cell)
      let move_dist = work_sites[i].dist(centroid)
      if move_dist > max_move {
        max_move = move_dist
      }
      work_sites[i] = centroid
    }
    actual_iter += 1
    if max_move < 0.0000001 {
      break
    }
  }
  for i in 0..<final_sites.length() {
    cells.push(voronoi_cell(final_sites, i, bounds))
  }
  let energy = lloyd_energy(final_sites, bounds)
  { sites: final_sites, cells, iterations: actual_iter, energy, }
}
