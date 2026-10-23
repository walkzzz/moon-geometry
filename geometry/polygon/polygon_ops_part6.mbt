///|
/// Ray-casting point-in-polygon test.
/// Returns true if the point lies inside or on the boundary.
/// 射线法点在多边形内测试。
/// 点在内部或边界上时返回 true。
pub fn point_in_polygon(p : @core.Point2D, poly : @core.Polygon) -> Bool {
  let verts = poly.vertices
  let n = verts.length()
  if n == 0 {
    return false
  }
  let mut inside = false
  let mut j = n - 1
  for i in 0..<n {
    let vi = verts[i]
    let vj = verts[j]
    if (vi.y > p.y) != (vj.y > p.y) {
      let x_intersect = (vj.x - vi.x) * (p.y - vi.y) / (vj.y - vi.y) + vi.x
      if p.x < x_intersect {
        inside = !inside
      }
    }
    j = i
  }
  inside
}
