///|
/// Inverse polar dual of a point. / 点的逆极对偶。
pub fn inverse_polar_dual_point(p : @core.Point2D) -> @core.Point2D {
  polar_dual_point(p)
}


///|
/// Inverse polar dual of a polygon. / 多边形的逆极对偶。
pub fn inverse_polar_dual(poly : @core.Polygon) -> Array[@core.Point2D] {
  polar_dual(poly)
}
