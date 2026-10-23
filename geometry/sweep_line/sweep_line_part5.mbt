///|
/// Check if a set of segments forms a simple polygon (no self-intersections
/// except at shared endpoints). Segments should form a closed chain.
///
/// 检测线段集合是否构成简单多边形（无非端点自相交）。
pub fn is_simple_polygon_chain(segments : Array[@core.Segment]) -> Bool {
  let n = segments.length()
  if n < 3 {
    return false
  }
  for i in 0..<n {
    let j_start = i + 2
    let j_end = if i == 0 { n - 1 } else { n }
    for j in j_start..<j_end {
      if @intersect.segments_intersect(segments[i], segments[j]) {
        return false
      }
    }
  }
  true
}
