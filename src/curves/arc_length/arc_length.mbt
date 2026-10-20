///|
/// Arc length of a single segment. / 单线段弧长。
pub fn arc_length_segment(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
) -> Double {
  p1.dist(p2)
}

///|
/// Total arc length of a polyline. / 折线总弧长。
pub fn arc_length_total(points : Array[@core.Point2D]) -> Double {
  @core.polyline_length(points)
}

///|
/// Cumulative arc lengths at each point. / 每个点处的累积弧长。
pub fn arc_length_cumulative(
  points : Array[@core.Point2D],
) -> Array[Double] {
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

///|
/// Average segment length. / 平均线段长度。
pub fn arc_length_average(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  arc_length_total(points) / (n - 1).to_double()
}

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