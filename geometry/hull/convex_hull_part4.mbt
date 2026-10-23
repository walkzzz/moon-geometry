///|
/// Graham scan convex hull. O(n log n).
/// Returns hull vertices in counter-clockwise order, excluding collinear points.
/// 返回逆时针排列的凸包顶点，排除共线点。
pub fn convex_hull_graham(
  points : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let n = points.length()
  if n <= 1 {
    return points.copy()
  }
  // Find pivot: lowest y, then lowest x
  let mut pivot_idx = 0
  for i in 1..<n {
    if points[i].y < points[pivot_idx].y ||
      (points[i].y == points[pivot_idx].y && points[i].x < points[pivot_idx].x) {
      pivot_idx = i
    }
  }
  let pivot = points[pivot_idx]
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    if i != pivot_idx {
      pts.push(points[i])
    }
  }
  // Sort by polar angle relative to pivot; tie-break by distance
  pts.sort_by(fn(a, b) {
    let cr = @core.turn(pivot, a, b)
    if cr > 0.0 {
      -1
    } else if cr < 0.0 {
      1
    } else {
      // @core.Collinear: nearer point first
      let da = pivot.dist_sq(a)
      let db = pivot.dist_sq(b)
      if da < db {
        -1
      } else if da > db {
        1
      } else {
        0
      }
    }
  })
  // Remove collinear duplicates keeping only the farthest in same direction
  let filtered : Array[@core.Point2D] = []
  for i in 0..<pts.length() {
    let flen = filtered.length()
    if flen >= 1 && @core.turn(pivot, filtered[flen - 1], pts[i]) == 0.0 {
      // Same direction: keep farther
      if pivot.dist_sq(pts[i]) > pivot.dist_sq(filtered[flen - 1]) {
        ignore(filtered.pop())
        filtered.push(pts[i])
      }
    } else {
      filtered.push(pts[i])
    }
  }
  if filtered.length() < 2 {
    // All points collinear: return endpoints
    let hull : Array[@core.Point2D] = [pivot]
    for p in filtered {
      hull.push(p)
    }
    return hull
  }
  // Graham scan
  let stack : Array[@core.Point2D] = [pivot, filtered[0]]
  for i in 1..<filtered.length() {
    while stack.length() >= 2 &&
          @core.turn(
            stack[stack.length() - 2],
            stack[stack.length() - 1],
            filtered[i],
          ) <=
          0.0 {
      ignore(stack.pop())
    }
    stack.push(filtered[i])
  }
  stack
}
