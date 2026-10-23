///|
/// Centroid (arithmetic mean) of a point set.
/// 点集质心（算术平均）。
pub fn centroid(points : Array[@core.Point2D]) -> @core.Point2D? {
  let n = points.length()
  if n == 0 {
    return None
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for p in points {
    sx += p.x()
    sy += p.y()
  }
  let nd = n.to_double()
  Some(@core.Point2D::new(sx / nd, sy / nd))
}
