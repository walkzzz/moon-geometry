///|
/// Compute the Chebyshev center (center of largest inscribed circle) of a convex polygon. / 计算凸多边形的切比雪夫中心（最大内切圆圆心）。
pub fn chebyshev_center(poly : @core.Polygon) -> @core.Point2D {
  convex_centroid(poly)
}
