///|
/// Bounding circle (approximate, using centroid + max distance).
/// 包围圆（近似，使用质心 + 最大距离）。
pub fn bounding_circle(
  points : Array[@core.Point2D],
) -> (@core.Point2D, Double) {
  let n = points.length()
  if n == 0 {
    return (@core.Point2D::new(0.0, 0.0), 0.0)
  }
  let mut cx = 0.0
  let mut cy = 0.0
  for p in points {
    cx += p.x
    cy += p.y
  }
  cx = cx / n.to_double()
  cy = cy / n.to_double()
  let center = @core.Point2D::new(cx, cy)
  let mut max_r = 0.0
  for p in points {
    let d = p.dist(center)
    if d > max_r {
      max_r = d
    }
  }
  (center, max_r)
}
