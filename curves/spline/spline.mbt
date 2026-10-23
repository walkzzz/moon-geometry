///|
/// Total length of a spline (sum of segment lengths). / 样条总长度（线段长度之和）。
pub fn spline_length(points : Array[@core.Point2D]) -> Double {
  @core.polyline_length(points)
}
