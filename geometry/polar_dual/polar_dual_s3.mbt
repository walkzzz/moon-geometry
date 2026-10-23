///|
/// Check if origin is inside a polygon. / 检查原点是否在多边形内。
pub fn origin_inside(poly : @core.Polygon) -> Bool {
  let n = poly.vertices.length()
  let mut inside = false
  let px = 0.0
  let py = 0.0
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
