///|
/// Separating distance between two convex polygons (0 if intersecting). / 两凸多边形分离距离。
pub fn separating_distance(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Double {
  let axes1 = edge_normals(poly1)
  let axes2 = edge_normals(poly2)
  let mut max_dist = 0.0
  for i in 0..<axes1.length() {
    let (a, b) = axes1[i]
    let (min1, max1) = projection_range(poly1, a, b)
    let (min2, max2) = projection_range(poly2, a, b)
    if max1 < min2 {
      let d = min2 - max1
      if d > max_dist {
        max_dist = d
      }
    } else if max2 < min1 {
      let d = min1 - max2
      if d > max_dist {
        max_dist = d
      }
    }
  }
  for i in 0..<axes2.length() {
    let (a, b) = axes2[i]
    let (min1, max1) = projection_range(poly1, a, b)
    let (min2, max2) = projection_range(poly2, a, b)
    if max1 < min2 {
      let d = min2 - max1
      if d > max_dist {
        max_dist = d
      }
    } else if max2 < min1 {
      let d = min1 - max2
      if d > max_dist {
        max_dist = d
      }
    }
  }
  max_dist
}
