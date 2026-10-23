///|
/// Find all intersection points between segments.
/// Returns array of (i, j, point) triples.
/// For overlapping segments, returns one endpoint.
///
/// 找出所有线段交点。返回 (i, j, 交点) 三元组数组。
pub fn find_intersection_points(
  segments : Array[@core.Segment],
) -> Array[(Int, Int, @core.Point2D)] {
  let result : Array[(Int, Int, @core.Point2D)] = []
  let n = segments.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      match @intersect.segment_intersection(segments[i], segments[j]) {
        Some(p) => result.push((i, j, p))
        None => continue
      }
    }
  }
  result
}
