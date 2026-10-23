///|
/// Minimum distance between two line segments.
/// 两线段之间的最小距离。
pub fn segment_to_segment_distance(
  s1 : @core.Segment,
  s2 : @core.Segment,
) -> Double {
  if @intersect.segments_intersect(s1, s2) {
    return 0.0
  }
  let p1 = s1.start
  let p2 = s1.end
  let p3 = s2.start
  let p4 = s2.end
  let d1 = point_to_segment_distance(p1, s2)
  let d2 = point_to_segment_distance(p2, s2)
  let d3 = point_to_segment_distance(p3, s1)
  let d4 = point_to_segment_distance(p4, s1)
  let mut min_d = d1
  if d2 < min_d {
    min_d = d2
  }
  if d3 < min_d {
    min_d = d3
  }
  if d4 < min_d {
    min_d = d4
  }
  min_d
}
