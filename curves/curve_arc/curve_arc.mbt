///|
/// Total arc length of a polyline. / 折线总弧长。
pub fn arc_length(points : Array[@core.Point2D]) -> Double {
  @core.polyline_length(points)
}


///|
/// Arc length from start to parameter t (0..1 along the curve). / 从起点到参数 t（0..1）的弧长。
pub fn arc_length_at(
  points : Array[@core.Point2D],
  t : Double,
) -> Double {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  let total = arc_length(points)
  total * t
}
