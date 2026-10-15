///|

/// Three-point orientation test.
/// 三点方向判定。
/// Returns @core.CounterClockwise, @core.Clockwise, or @core.Collinear.
pub fn ccw(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> @core.Orientation {
  let cr = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
  if cr > 0.0 {
    @core.CounterClockwise
  } else if cr < 0.0 {
    @core.Clockwise
  } else {
    @core.Collinear
  }
}

///|
/// Remove consecutive duplicate points from a sorted array.
/// 从已排序数组中移除连续重复点。
fn dedup_sorted(pts : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<pts.length() {
    let last = result.length() - 1
    if last < 0 || !result[last].equals(pts[i]) {
      result.push(pts[i])
    }
  }
  result
}

///|
/// Andrew's monotone chain convex hull. O(n log n), numerically stable.
/// Returns hull vertices in counter-clockwise order, excluding collinear points.
/// 返回逆时针排列的凸包顶点，排除共线点。
pub fn convex_hull_andrew(points : Array[@core.Point2D]) -> Array[@core.Point2D] {
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
          @core.turn(lower[lower.length() - 2], lower[lower.length() - 1], unique[i]) <=
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
          @core.turn(upper[upper.length() - 2], upper[upper.length() - 1], unique[i]) <=
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

///|
/// Graham scan convex hull. O(n log n).
/// Returns hull vertices in counter-clockwise order, excluding collinear points.
/// 返回逆时针排列的凸包顶点，排除共线点。
pub fn convex_hull_graham(points : Array[@core.Point2D]) -> Array[@core.Point2D] {
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
