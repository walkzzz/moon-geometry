///|
/// Maximum segment length. / 最大线段长度。
pub fn arc_length_max_segment(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  let mut max_len = 0.0
  for i in 0..<(n - 1) {
    let len = arc_length_segment(points[i], points[i + 1])
    if len > max_len {
      max_len = len
    }
  }
  max_len
}