///|
/// Whether a polygon is convex.
/// 多边形是否为凸。
pub fn is_convex(poly : @core.Polygon) -> Bool {
  let verts = poly.vertices
  let n = verts.length()
  if n < 3 {
    return false
  }
  let mut sign = 0
  for i in 0..<n {
    let a = verts[i]
    let b = verts[(i + 1) % n]
    let c = verts[(i + 2) % n]
    let cr = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
    if cr == 0.0 {
      // collinear: skip
    } else if cr > 0.0 {
      if sign == 0 {
        sign = 1
      } else if sign != 1 {
        return false
      }
    } else if sign == 0 {
      sign = -1
    } else if sign != -1 {
      return false
    }
  }
  true
}
