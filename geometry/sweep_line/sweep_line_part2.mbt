///|
/// Find all intersecting pairs of segments.
/// Returns array of (i, j) index pairs with i < j.
/// Brute-force O(n² + k) where k is the number of intersections.
///
/// 找出所有相交线段对。返回 (i, j) 索引对数组，i < j。
pub fn find_all_intersections(
  segments : Array[@core.Segment],
) -> Array[(Int32, Int32)] {
  let result : Array[(Int32, Int32)] = []
  let n = segments.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if @intersect.segments_intersect(segments[i], segments[j]) {
        result.push((i, j))
      }
    }
  }
  result
}
