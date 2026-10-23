///|
/// Signed area of a polygon using the Shoelace formula.
/// Positive for counter-clockwise, negative for clockwise.
/// 使用 Shoelace 公式计算多边形有符号面积。
/// 逆时针为正，顺时针为负。
pub fn polygon_signed_area(poly : @core.Polygon) -> Double {
  let verts = poly.vertices
  let n = verts.length()
  if n < 3 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    sum += verts[i].x * verts[j].y - verts[j].x * verts[i].y
  }
  sum / 2.0
}
