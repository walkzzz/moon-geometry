///|
/// Total length of a polyline (sum of consecutive point distances).
/// 折线总长度（相邻点距离之和）。
pub fn polyline_length(points : Array[Point2D]) -> Double where {
  proof_ensure: result => result >= 0.0,
} {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  let mut total = 0.0
  for i in 0..<(n - 1) {
    total += points[i].dist(points[i + 1])
  }
  total
}


///|
/// Minimum distance from a point to a set of points.
/// 点到点集的最小距离。
pub fn min_dist_to_set(p : Point2D, set : Array[Point2D]) -> Double where {
  proof_ensure: result => result >= 0.0,
} {
  if set.length() == 0 {
    return 1.0 / 0.000000000001
  }
  let mut best = p.dist(set[0])
  for q in set {
    let d = p.dist(q)
    if d < best {
      best = d
    }
  }
  best
}
