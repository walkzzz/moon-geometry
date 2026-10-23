///|
/// Compute the width of a convex polygon (minimum distance between parallel supporting lines). / 计算凸多边形的宽度（平行支撑线间的最小距离）。
pub fn convex_width(poly : @core.Polygon) -> Double {
  let n = poly.size()
  if n < 2 {
    return 0.0
  }
  let mut min_width = 999999.0
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
    min_width = min_width.min(w)
  }
  min_width
}

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

///|
/// Compute the aspect ratio of a convex polygon (max_width / min_width). / 计算凸多边形的宽高比（最大宽度/最小宽度）。
pub fn convex_aspect_ratio(poly : @core.Polygon) -> Double {
  let mw = convex_width(poly)
  if mw < 0.000000001 {
    return 0.0
  }
  convex_max_width(poly) / mw
}
