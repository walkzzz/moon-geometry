///|
/// Dual area (sum of 1/|v_i|^2 for polygon vertices). / 对偶面积。
pub fn dual_area(poly : @core.Polygon) -> Double {
  let mut sum = 0.0
  let n = poly.vertices.length()
  for i in 0..<n {
    let d = poly.vertices[i].x() * poly.vertices[i].x() +
      poly.vertices[i].y() * poly.vertices[i].y()
    if d > 0.000000000001 {
      sum += 1.0 / d
    }
  }
  sum
}
