///|
/// Compute concave hull using k-nearest neighbors approach. / 使用 k 近邻方法计算凹包。
pub fn concave_hull(
  points : Array[@core.Point2D],
  k : Int32,
) -> Array[@core.Point2D] {
  if points.length() <= 3 {
    return points.copy()
  }
  let kk = if k < 3 { 3 } else { k }
  let result : Array[@core.Point2D] = []
  let first = points[0]
  for p in points {
    if p.y() < first.y() || (p.y() == first.y() && p.x() < first.x()) {
      ignore(p)
    }
  }
  result.push(first)
  let visited : Array[Bool] = Array::make(points.length(), false)
  visited[0] = true
  let mut current_idx = 0
  let mut current_angle = 0.0
  for _ in 1..<points.length() {
    let neighbors = k_nearest(points, current_idx, kk, visited)
    if neighbors.length() == 0 {
      break
    }
    let mut best_idx = neighbors[0]
    let mut best_angle = angle_to(
      points[current_idx],
      points[best_idx],
      current_angle,
    )
    for idx in neighbors {
      let a = angle_to(points[current_idx], points[idx], current_angle)
      if a < best_angle {
        best_angle = a
        best_idx = idx
      }
    }
    if best_idx == 0 {
      break
    }
    result.push(points[best_idx])
    visited[best_idx] = true
    current_angle = best_angle
    current_idx = best_idx
  }
  result
}

///|
fn k_nearest(
  points : Array[@core.Point2D],
  center : Int32,
  k : Int32,
  visited : Array[Bool],
) -> Array[Int32] {
  let dists : Array[(Int32, Double)] = []
  for i in 0..<points.length() {
    if i != center && !visited[i] {
      dists.push((i, points[center].dist(points[i])))
    }
  }
  dists.sort_by(fn(a, b) {
    if a.1 < b.1 {
      -1
    } else if a.1 > b.1 {
      1
    } else {
      0
    }
  })
  let result : Array[Int32] = []
  for i in 0..<dists.length() {
    if i >= k {
      break
    }
    result.push(dists[i].0)
  }
  result
}

///|
fn angle_to(
  from : @core.Point2D,
  to : @core.Point2D,
  ref_angle : Double,
) -> Double {
  let dx = to.x() - from.x()
  let dy = to.y() - from.y()
  let angle = @math.atan2(dy, dx) - ref_angle
  if angle < 0.0 {
    angle + 6.283185307179586
  } else {
    angle
  }
}
