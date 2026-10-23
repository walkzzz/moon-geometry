///|
/// Cumulative arc lengths at each point. / 每个点处的累积弧长。
pub fn arc_length_cumulative(points : Array[@core.Point2D]) -> Array[Double] {
  let n = points.length()
  let result : Array[Double] = []
  if n == 0 {
    return result
  }
  result.push(0.0)
  for i in 1..<n {
    result.push(result[i - 1] + arc_length_segment(points[i - 1], points[i]))
  }
  result
}
