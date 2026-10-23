///|
/// Compute the zone of a line with respect to a set of segments. / 计算线相对于线段集的区域。
pub fn compute_zone(
  line : @core.Line,
  segments : Array[@core.Segment],
) -> Zone {
  let crossed_faces : Array[Int] = []
  let entry_points : Array[@core.Point2D] = []
  for i in 0..<segments.length() {
    match line_segment_intersect(line, segments[i]) {
      Some(pt) => {
        crossed_faces.push(i)
        entry_points.push(pt)
      }
      None => continue
    }
  }
  { line, crossed_faces, entry_points }
}

fn line_segment_intersect(
  line : @core.Line,
  seg : @core.Segment,
) -> @core.Point2D? {
  let p1 = seg.start
  let p2 = seg.end
  let v1 = line.evaluate(p1)
  let v2 = line.evaluate(p2)
  if v1 == 0.0 {
    return Some(p1)
  }
  if v2 == 0.0 {
    return Some(p2)
  }
  if v1 * v2 > 0.0 {
    return None
  }
  let t = v1 / (v1 - v2)
  Some(@core.Point2D::new(p1.x() + t * (p2.x() - p1.x()), p1.y() + t * (p2.y() - p1.y())))
}
