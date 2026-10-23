///|
/// Compute the intersection point of two segments, if any.
/// Returns None for parallel/collinear cases with no unique intersection.
/// 平行/共线且无唯一交点时返回 None。
pub fn segment_intersection(
  s1 : @core.Segment,
  s2 : @core.Segment,
) -> @core.Point2D? {
  let p = s1.start
  let r = s1.end.sub(s1.start)
  let q = s2.start
  let s = s2.end.sub(s2.start)
  let rxs = r.cross(s)
  let qmp = q.sub(p)
  let qpxr = qmp.cross(r)
  if rxs == 0.0 {
    // Parallel or collinear
    if qpxr != 0.0 {
      return None
    }
    // @core.Collinear overlap: return first overlapping endpoint if any
    let r_dot_r = r.dot(r)
    if r_dot_r == 0.0 {
      // s1 is a point
      if on_segment(q, s2.end, p) {
        return Some(p)
      }
      return None
    }
    let t0 = qmp.dot(r) / r_dot_r
    let t1 = qmp.add(s).dot(r) / r_dot_r
    let (lo, hi) = if t0 < t1 { (t0, t1) } else { (t1, t0) }
    let overlap_lo = if lo > 0.0 { lo } else { 0.0 }
    let overlap_hi = if hi < 1.0 { hi } else { 1.0 }
    if overlap_lo > overlap_hi {
      return None
    }
    return Some(
      @core.Point2D::new(p.x + overlap_lo * r.x, p.y + overlap_lo * r.y),
    )
  }
  let t = qmp.cross(s) / rxs
  let u = qpxr / rxs
  if t >= 0.0 && t <= 1.0 && u >= 0.0 && u <= 1.0 {
    Some(@core.Point2D::new(p.x + t * r.x, p.y + t * r.y))
  } else {
    None
  }
}
