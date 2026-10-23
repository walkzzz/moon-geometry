///|
/// Compute the maximum width of a convex polygon. / 计算凸多边形的最大宽度。
pub fn convex_max_width(poly : @core.Polygon) -> Double {
  let n = poly.size()
  if n < 2 {
    return 0.0
  }
  let mut max_width = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let p1 = poly.get(i)
    let p2 = poly.get(j)
    let dx = p2.x() - p1.x()
    let dy = p2.y() - p1.y()
    let len = (dx * dx + dy * dy).sqrt()
    if len < 0.000000001 {
      continue
    }
    let nx = -dy / len
    let ny = dx / len
    let mut max_proj = -999999.0
    let mut min_proj = 999999.0
    for k in 0..<n {
      let p = poly.get(k)
      let proj = (p.x() - p1.x()) * nx + (p.y() - p1.y()) * ny
      max_proj = max_proj.max(proj)
      min_proj = min_proj.min(proj)
    }
    let w = max_proj - min_proj
    max_width = max_width.max(w)
  }
  max_width
}
