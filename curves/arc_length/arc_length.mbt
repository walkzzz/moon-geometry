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
