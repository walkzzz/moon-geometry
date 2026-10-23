///|
/// Subdivide a polyline segment at parameter t. / 在参数 t 处细分折线段。
pub fn polyline_subdivide(
  points : Array[@core.Point2D],
  segment_idx : Int32,
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
  for i in 0..<=segment_idx {
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
pub fn polyline_segment_count(points : Array[@core.Point2D]) -> Int32 {
  let n = points.length()
  if n < 2 {
    return 0
  }
  n - 1
}
