///|
/// Find the point closest to the centroid. / 找到最接近质心的点。
pub fn closest_to_centroid(
  points : Array[@core.Point2D],
) -> @core.Point2D? {
  if points.length() == 0 {
    return None
  }
  let c = centroid(points)
  let mut best = points[0]
  let mut best_dist = c.dist(points[0])
  for p in points {
    let d = c.dist(p)
    if d < best_dist {
      best_dist = d
      best = p
    }
  }
  Some(best)
}