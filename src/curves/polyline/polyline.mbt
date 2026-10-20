///|
/// Total length of a polyline. / 折线总长度。
pub fn polyline_length(points : Array[@core.Point2D]) -> Double {
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
/// Simplify a polyline using Douglas-Peucker algorithm. / 使用 Douglas-Peucker 算法简化折线。
pub fn polyline_simplify(
  points : Array[@core.Point2D],
  eps : Double,
) -> Array[@core.Point2D] {
  let n = points.length()
  if n < 3 {
    return points
  }
  dp_simplify(points, 0, n - 1, eps)
}

fn dp_simplify(
  points : Array[@core.Point2D],
  start : Int,
  end : Int,
  eps : Double,
) -> Array[@core.Point2D] {
  if end - start < 2 {
    let result : Array[@core.Point2D] = []
    for i in start..=end {
      result.push(points[i])
    }
    return result
  }
  let mut max_dist = 0.0
  let mut max_idx = start
  let p1 = points[start]
  let p2 = points[end]
  for i in (start + 1)..<end {
    let d = point_to_line_dist(points[i], p1, p2)
    if d > max_dist {
      max_dist = d
      max_idx = i
    }
  }
  if max_dist > eps {
    let left = dp_simplify(points, start, max_idx, eps)
    let right = dp_simplify(points, max_idx, end, eps)
    let result : Array[@core.Point2D] = []
    for p in left {
      result.push(p)
    }
    for i in 1..<right.length() {
      result.push(right[i])
    }
    return result
  }
  [p1, p2]
}

fn point_to_line_dist(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  let len = (dx * dx + dy * dy).sqrt()
  if len < 0.000000000001 {
    return p.dist(a)
  }
  ((dx * (a.y() - p.y()) - dy * (a.x() - p.x())).abs()) / len
}

///|
/// Subdivide a polyline segment at parameter t. / 在参数 t 处细分折线段。
pub fn polyline_subdivide(
  points : Array[@core.Point2D],
  segment_idx : Int,
  t : Double,
) -> Array[@core.Point2D] {
  let n = points.length()
  if segment_idx < 0 || segment_idx >= n - 1 {
    return points
  }
  let p1 = points[segment_idx]
  let p2 = points[segment_idx + 1]
  let mid = @core.Point2D::new(
    p1.x() + t * (p2.x() - p1.x()),
    p1.y() + t * (p2.y() - p1.y()),
  )
  let result : Array[@core.Point2D] = []
  for i in 0..=segment_idx {
    result.push(points[i])
  }
  result.push(mid)
  for i in (segment_idx + 1)..<n {
    result.push(points[i])
  }
  result
}

///|
/// Count segments in a polyline. / 折线线段数。
pub fn polyline_segment_count(points : Array[@core.Point2D]) -> Int {
  let n = points.length()
  if n < 2 {
    return 0
  }
  n - 1
}