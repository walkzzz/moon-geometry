///|
/// Check if point p lies on segment (a, b), assuming collinearity.
fn on_segment(a : Point2D, b : Point2D, p : Point2D) -> Bool {
  let eps = default_eps
  p.x <= (if a.x > b.x { a.x } else { b.x }) + eps &&
  p.x >= (if a.x < b.x { a.x } else { b.x }) - eps &&
  p.y <= (if a.y > b.y { a.y } else { b.y }) + eps &&
  p.y >= (if a.y < b.y { a.y } else { b.y }) - eps
}

///|
/// Whether two segments intersect (including touching endpoints / collinear overlap).
pub fn segments_intersect(s1 : Segment, s2 : Segment) -> Bool {
  let p1 = s1.start
  let p2 = s1.end
  let p3 = s2.start
  let p4 = s2.end
  let d1 = turn(p3, p4, p1)
  let d2 = turn(p3, p4, p2)
  let d3 = turn(p1, p2, p3)
  let d4 = turn(p1, p2, p4)
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

///|
/// Compute the intersection point of two segments, if any.
/// Returns None for parallel/collinear cases with no unique intersection.
pub fn segment_intersection(s1 : Segment, s2 : Segment) -> Point2D? {
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
    // Collinear overlap: return first overlapping endpoint if any
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
    return Some(Point2D::new(p.x + overlap_lo * r.x, p.y + overlap_lo * r.y))
  }
  let t = qmp.cross(s) / rxs
  let u = qpxr / rxs
  if t >= 0.0 && t <= 1.0 && u >= 0.0 && u <= 1.0 {
    Some(Point2D::new(p.x + t * r.x, p.y + t * r.y))
  } else {
    None
  }
}

///|
/// Intersection of a line (general form) with a segment.
pub fn line_segment_intersection(line : Line, seg : Segment) -> Point2D? {
  let d = seg.end.sub(seg.start)
  let denom = line.a * d.x + line.b * d.y
  if denom == 0.0 {
    // Parallel
    if line.evaluate(seg.start) == 0.0 {
      // Collinear: return segment start as a point on both
      return Some(seg.start)
    }
    return None
  }
  let t = -(line.a * seg.start.x + line.b * seg.start.y + line.c) / denom
  if t >= 0.0 && t <= 1.0 {
    Some(Point2D::new(seg.start.x + t * d.x, seg.start.y + t * d.y))
  } else {
    None
  }
}
