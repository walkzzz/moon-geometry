///|
/// Whether two segments intersect (including touching endpoints / collinear overlap).
/// 两线段是否相交（含端点接触/共线重叠）。
pub fn segments_intersect(s1 : @core.Segment, s2 : @core.Segment) -> Bool {
  let p1 = s1.start
  let p2 = s1.end
  let p3 = s2.start
  let p4 = s2.end
  let d1 = @core.turn(p3, p4, p1)
  let d2 = @core.turn(p3, p4, p2)
  let d3 = @core.turn(p1, p2, p3)
  let d4 = @core.turn(p1, p2, p4)
  if ((d1 > 0.0 && d2 < 0.0) || (d1 < 0.0 && d2 > 0.0)) &&
    ((d3 > 0.0 && d4 < 0.0) || (d3 < 0.0 && d4 > 0.0)) {
    return true
  }
  if d1 == 0.0 && on_segment(p3, p4, p1) {
    return true
  }
  if d2 == 0.0 && on_segment(p3, p4, p2) {
    return true
  }
  if d3 == 0.0 && on_segment(p1, p2, p3) {
    return true
  }
  if d4 == 0.0 && on_segment(p1, p2, p4) {
    return true
  }
  false
}
