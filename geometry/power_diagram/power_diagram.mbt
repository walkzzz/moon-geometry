///|
/// Weighted point for power diagram. / 幂图的加权站点。
pub struct WeightedPoint {
  point : @core.Point2D
  weight : Double
}


///|
/// Construct a weighted point. / 构造加权点。
pub fn WeightedPoint::new(
  point : @core.Point2D,
  weight : Double,
) -> WeightedPoint {
  { point, weight }
}


///|
/// Power cell: region where a site has minimum power distance. / 幂单元：某站点幂距离最小的区域。
pub struct PowerCell {
  site_idx : Int
  vertices : Array[@core.Point2D]
}


///|
/// Power diagram (weighted Voronoi diagram). / 幂图（加权 Voronoi 图）。
pub struct PowerDiagram {
  sites : Array[WeightedPoint]
  cells : Array[PowerCell]
}


///|
/// Construct an empty power diagram. / 构造空的幂图。
pub fn PowerDiagram::new() -> PowerDiagram {
  { sites: [], cells: [] }
}


///|
/// Get the number of cells. / 获取单元数量。
pub fn PowerDiagram::cell_count(pd : PowerDiagram) -> Int {
  pd.cells.length()
}
