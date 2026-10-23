///|
/// Get a specific power cell by site index. / 按站点索引获取幂单元。
pub fn power_cell(pd : PowerDiagram, site_idx : Int32) -> PowerCell {
  for c in pd.cells {
    if c.site_idx == site_idx {
      return c
    }
  }
  { site_idx, vertices: [], }
}

///|
/// Compute the area of a power cell. / 计算幂单元面积。
pub fn power_cell_area(pd : PowerDiagram, site_idx : Int32) -> Double {
  let cell = power_cell(pd, site_idx)
  polygon_area(cell.vertices)
}

///|
fn polygon_area(poly : Array[@core.Point2D]) -> Double {
  let n = poly.length()
  if n < 3 {
    return 0.0
  }
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    area += poly[i].x() * poly[j].y() - poly[j].x() * poly[i].y()
  }
  (area * 0.5).abs()
}
