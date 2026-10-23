///|
/// Support point of a segment in a direction. / 线段在方向上的支持点。
pub fn support_segment(
  seg : @core.Segment,
  dir : @core.Point2D,
) -> @core.Point2D {
  let va = seg.start.x() * dir.x() + seg.start.y() * dir.y()
  let vb = seg.end.x() * dir.x() + seg.end.y() * dir.y()
  if va >= vb {
    seg.start
  } else {
    seg.end
  }
}
