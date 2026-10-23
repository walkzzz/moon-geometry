///|
/// Count the number of intersecting pairs.
/// O(n²) brute-force. / 计数相交线段对数。O(n²) 暴力。
pub fn count_intersections(segments : Array[@core.Segment]) -> Int32 {
  let mut count = 0
  let n = segments.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if @intersect.segments_intersect(segments[i], segments[j]) {
        count += 1
      }
    }
  }
  count
}
