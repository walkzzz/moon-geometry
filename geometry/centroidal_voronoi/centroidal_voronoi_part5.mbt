///|
/// Compute Lloyd's energy (quantization error). / 计算 Lloyd 能量（量化误差）。
pub fn lloyd_energy(
  sites : Array[@core.Point2D],
  bounds : (@core.Point2D, @core.Point2D),
) -> Double {
  let mut energy = 0.0
  for i in 0..<sites.length() {
    let cell = voronoi_cell(sites, i, bounds)
    let n = cell.length()
    if n < 3 {
      continue
    }
    let site = sites[i]
    for ci in 0..<n {
      let cj = (ci + 1) % n
      let p0 = cell[ci]
      let p1 = cell[cj]
      let mx = (p0.x() + p1.x() + site.x()) / 3.0
      let my = (p0.y() + p1.y() + site.y()) / 3.0
      let tri_area = ((p1.x() - p0.x()) * (site.y() - p0.y()) -
        (site.x() - p0.x()) * (p1.y() - p0.y())).abs() * 0.5
      let dx = mx - site.x()
      let dy = my - site.y()
      energy += (dx * dx + dy * dy) * tri_area
    }
  }
  energy
}
