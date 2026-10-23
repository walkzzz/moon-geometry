///|
/// Compute the power diagram of weighted sites within a bounding box. / 计算加权站点在包围盒内的幂图。
pub fn power_diagram(
  sites : Array[WeightedPoint],
  bounds : (@core.Point2D, @core.Point2D),
) -> PowerDiagram {
  let n = sites.length()
  if n == 0 {
    return { sites: [], cells: [] }
  }
  let (bl, tr) = bounds
  let cells : Array[PowerCell] = []
  for i in 0..<n {
    let mut cell : Array[@core.Point2D] = [
      bl,
      @core.Point2D::new(tr.x(), bl.y()),
      tr,
      @core.Point2D::new(bl.x(), tr.y()),
    ]
    for j in 0..<n {
      if i == j {
        continue
      }
      cell = clip_by_power(cell, sites[i], sites[j])
    }
    cells.push({ site_idx: i, vertices: cell })
  }
  { sites: sites.copy(), cells }
}
