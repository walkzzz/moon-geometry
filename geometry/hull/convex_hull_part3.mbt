///|
/// Andrew's monotone chain convex hull. O(n log n), numerically stable.
/// Returns hull vertices in counter-clockwise order, excluding collinear points.
/// 返回逆时针排列的凸包顶点，排除共线点。
pub fn convex_hull_andrew(
  points : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let n = points.length()
  if n <= 1 {
    return points.copy()
  }
  let pts = points.copy()
  pts.sort_by(fn(a, b) {
    if a.x < b.x {
      -1
    } else if a.x > b.x {
      1
    } else if a.y < b.y {
      -1
    } else if a.y > b.y {
      1
    } else {
      0
    }
  })
  let unique = dedup_sorted(pts)
  let m = unique.length()
  if m <= 2 {
    return unique
  }
  // Lower hull
  let lower : Array[@core.Point2D] = []
  for i in 0..<m {
    while lower.length() >= 2 &&
          @core.turn(
            lower[lower.length() - 2],
            lower[lower.length() - 1],
            unique[i],
          ) <=
          0.0 {
      ignore(lower.pop())
    }
    lower.push(unique[i])
  }
  // Upper hull
  let upper : Array[@core.Point2D] = []
  let mut i = m - 1
  while i >= 0 {
    while upper.length() >= 2 &&
          @core.turn(
            upper[upper.length() - 2],
            upper[upper.length() - 1],
            unique[i],
          ) <=
          0.0 {
      ignore(upper.pop())
    }
    upper.push(unique[i])
    i -= 1
  }
  // Concatenate, removing duplicated endpoints
  ignore(lower.pop())
  ignore(upper.pop())
  for p in upper {
    lower.push(p)
  }
  lower
}
