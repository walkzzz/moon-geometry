///|
/// Ray-segment intersection. Returns parameter t >= 0 or None. / 射线与线段交点。
pub fn ray_segment_intersect(r : Ray, seg : @core.Segment) -> @core.Point2D? {
  let x1 = r.origin.x()
  let y1 = r.origin.y()
  let x2 = r.origin.x() + r.dir.x()
  let y2 = r.origin.y() + r.dir.y()
  let x3 = seg.start.x()
  let y3 = seg.start.y()
  let x4 = seg.end.x()
  let y4 = seg.end.y()
  let denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
  if @core.approx_eq(denom, 0.0, 0.000000000001) {
    return None
  }
  let t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denom
  let u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denom
  if t >= 0.0 && u >= 0.0 && u <= 1.0 {
    Some(Ray::eval(r, t))
  } else {
    None
  }
}
