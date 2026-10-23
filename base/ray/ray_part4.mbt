///|
/// Check if ray origin is inside polygon (odd crossing count). / 检查射线起点是否在多边形内。
pub fn ray_polygon_contains(r : Ray, poly : @core.Polygon) -> Bool {
  let n = poly.vertices.length()
  let mut inside = false
  let px = r.origin.x()
  let py = r.origin.y()
  for i in 0..<n {
    let j = (i + n - 1) % n
    let xi = poly.vertices[i].x()
    let yi = poly.vertices[i].y()
    let xj = poly.vertices[j].x()
    let yj = poly.vertices[j].y()
    if (yi > py) != (yj > py) {
      let x_cross = (xj - xi) * (py - yi) / (yj - yi) + xi
      if px < x_cross {
        inside = !inside
      }
    }
  }
  inside
}
