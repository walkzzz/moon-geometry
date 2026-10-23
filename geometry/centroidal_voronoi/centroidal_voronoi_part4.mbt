///|
/// Compute Voronoi cell for a site within bounds. / 计算站点在包围盒内的 Voronoi 单元。
fn voronoi_cell(
  sites : Array[@core.Point2D],
  idx : Int32,
  bounds : (@core.Point2D, @core.Point2D),
) -> Array[@core.Point2D] {
  let (bl, tr) = bounds
  let mut cell : Array[@core.Point2D] = [
    bl,
    @core.Point2D::new(tr.x(), bl.y()),
    tr,
    @core.Point2D::new(bl.x(), tr.y()),
  ]
  for i in 0..<sites.length() {
    if i == idx {
      continue
    }
    cell = clip_by_bisector(cell, sites[idx], sites[i])
  }
  cell
}
