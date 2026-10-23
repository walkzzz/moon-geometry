///|
/// Project a 3D point to 2D using orthographic projection (drop z). / 正交投影：将三维点投影到二维（丢弃 z）。
pub fn orthographic(p : @core.Point3D) -> @core.Point2D {
  @core.Point2D::new(p.x, p.y)
}


///|
/// Project a 3D point to 2D using perspective projection with focal length f. / 透视投影：以焦距 f 将三维点投影到二维。
pub fn perspective_project(
  p : @core.Point3D,
  f : Double,
) -> @core.Point2D? {
  if @core.approx_eq(p.z, 0.0, 0.000000001) {
    return None
  }
  Some(@core.Point2D::new(f * p.x / p.z, f * p.y / p.z))
}
