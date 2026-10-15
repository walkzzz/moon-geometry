///|
/// Cross product of vectors OA and OB: (a-o) × (b-o).
/// Positive => O->A->B is a counter-clockwise turn.
fn turn(o : Point2D, a : Point2D, b : Point2D) -> Double {
  (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x)
}

///|
/// Three-point orientation test.
/// Returns CounterClockwise, Clockwise, or Collinear.
pub fn ccw(a : Point2D, b : Point2D, c : Point2D) -> Orientation {
  let cr = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
  if cr > 0.0 {
    CounterClockwise
  } else if cr < 0.0 {
    Clockwise
  } else {
    Collinear
  }
}

///|
/// Remove consecutive duplicate points from a sorted array.
fn dedup_sorted(pts : Array[Point2D]) -> Array[Point2D] {
  let result : Array[Point2D] = []
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
pub fn convex_hull_andrew(points : Array[Point2D]) -> Array[Point2D] {
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
  let lower : Array[Point2D] = []
  for i in 0..<m {
    while lower.length() >= 2 &&
          turn(lower[lower.length() - 2], lower[lower.length() - 1], unique[i]) <=
          0.0 {
      ignore(lower.pop())
    }
    lower.push(unique[i])
  }
  // Upper hull
  let upper : Array[Point2D] = []
  let mut i = m - 1
  while i >= 0 {
    while upper.length() >= 2 &&
          turn(upper[upper.length() - 2], upper[upper.length() - 1], unique[i]) <=
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
pub fn convex_hull_graham(points : Array[Point2D]) -> Array[Point2D] {
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
  let pts : Array[Point2D] = []
  for i in 0..<n {
    if i != pivot_idx {
      pts.push(points[i])
    }
  }
  // Sort by polar angle relative to pivot; tie-break by distance
  pts.sort_by(fn(a, b) {
    let cr = turn(pivot, a, b)
    if cr > 0.0 {
      -1
    } else if cr < 0.0 {
      1
    } else {
      // Collinear: nearer point first
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
  let filtered : Array[Point2D] = []
  for i in 0..<pts.length() {
    let flen = filtered.length()
    if flen >= 1 && turn(pivot, filtered[flen - 1], pts[i]) == 0.0 {
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
    let hull : Array[Point2D] = [pivot]
    for p in filtered {
      hull.push(p)
    }
    return hull
  }
  // Graham scan
  let stack : Array[Point2D] = [pivot, filtered[0]]
  for i in 1..<filtered.length() {
    while stack.length() >= 2 &&
          turn(
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
