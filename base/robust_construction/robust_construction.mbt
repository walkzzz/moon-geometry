///|
/// # Robust Geometric Construction
/// # 鲁棒几何构造
///
/// Robust construction of circumcenters, intersections, midpoints.
/// 鲁棒构造外心、交点、中点。

///|
pub fn robust_circumcenter(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ax = a.x()
  let ay = a.y()
  let bx = b.x()
  let by = b.y()
  let cx = c.x()
  let cy = c.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d.abs() < 0.000000000001 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let ux = (
      (ax * ax + ay * ay) * (by - cy) +
      (bx * bx + by * by) * (cy - ay) +
      (cx * cx + cy * cy) * (ay - by)
    ) /
    d
  let uy = (
      (ax * ax + ay * ay) * (cx - bx) +
      (bx * bx + by * by) * (ax - cx) +
      (cx * cx + cy * cy) * (bx - ax)
    ) /
    d
  @core.Point2D::new(ux, uy)
}

///|
pub fn robust_intersection(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  d : @core.Point2D,
) -> @core.Point2D {
  let x1 = a.x()
  let y1 = a.y()
  let x2 = b.x()
  let y2 = b.y()
  let x3 = c.x()
  let y3 = c.y()
  let x4 = d.x()
  let y4 = d.y()
  let denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
  if denom.abs() < 0.000000000001 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denom
  @core.Point2D::new(x1 + t * (x2 - x1), y1 + t * (y2 - y1))
}

///|
pub fn robust_midpoint(a : @core.Point2D, b : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new((a.x() + b.x()) / 2.0, (a.y() + b.y()) / 2.0)
}
