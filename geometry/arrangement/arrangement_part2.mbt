///|
/// Build an arrangement from a set of segments using brute-force intersection. / 使用暴力相交从线段集构建排列。
pub fn build_arrangement(segments : Array[@core.Segment]) -> Arrangement {
  let vertices : Array[ArrangementVertex] = []
  for i in 0..<segments.length() {
    let v : ArrangementVertex = { point: segments[i].start, seg_ids: [i], }
    vertices.push(v)
    let v2 : ArrangementVertex = { point: segments[i].end, seg_ids: [i], }
    vertices.push(v2)
  }
  for i in 0..<segments.length() {
    for j in (i + 1)..<segments.length() {
      match
        segment_intersect(
          segments[i].start,
          segments[i].end,
          segments[j].start,
          segments[j].end,
        ) {
        Some(pt) => {
          let v : ArrangementVertex = { point: pt, seg_ids: [i, j], }
          vertices.push(v)
        }
        None => continue
      }
    }
  }
  { segments, vertices, }
}

///|
fn segment_intersect(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  p4 : @core.Point2D,
) -> @core.Point2D? {
  let d1x = p2.x() - p1.x()
  let d1y = p2.y() - p1.y()
  let d2x = p4.x() - p3.x()
  let d2y = p4.y() - p3.y()
  let denom = d1x * d2y - d1y * d2x
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return None
  }
  let t = ((p3.x() - p1.x()) * d2y - (p3.y() - p1.y()) * d2x) / denom
  let u = ((p3.x() - p1.x()) * d1y - (p3.y() - p1.y()) * d1x) / denom
  if t >= 0.0 && t <= 1.0 && u >= 0.0 && u <= 1.0 {
    Some(@core.Point2D::new(p1.x() + t * d1x, p1.y() + t * d1y))
  } else {
    None
  }
}
