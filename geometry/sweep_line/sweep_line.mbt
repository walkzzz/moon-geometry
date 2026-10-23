///|
/// Check if any pair of segments in the set intersects.
/// Returns true if at least one pair intersects.
/// Brute-force O(n²) check using existing intersection test.
///
/// 检测线段集合中是否有任何一对线段相交。暴力 O(n²) 检测。
pub fn has_any_intersection(segments : Array[@core.Segment]) -> Bool {
  let n = segments.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if @intersect.segments_intersect(segments[i], segments[j]) {
        return true
      }
    }
  }
  false
}
