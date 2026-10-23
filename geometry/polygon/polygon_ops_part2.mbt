///|
/// Perimeter of a polygon.
/// 多边形周长。
pub fn polygon_perimeter(poly : @core.Polygon) -> Double {
  let verts = poly.vertices
  let n = verts.length()
  if n < 2 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    sum += verts[i].dist(verts[j])
  }
  sum
}
