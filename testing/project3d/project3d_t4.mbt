///|
/// Project a 3D point onto a plane defined by normal and distance. / 将三维点投影到由法向量和距离定义的平面。
pub fn project_to_plane(
  p : @core.Point3D,
  normal : @core.Point3D,
  d : Double,
) -> @core.Point3D {
  let denom = normal.dot(normal)
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return p
  }
  let t = (normal.dot(p) + d) / denom
  @core.Point3D::new(p.x - t * normal.x, p.y - t * normal.y, p.z - t * normal.z)
}

///|
/// Isometric projection of a 3D point to 2D. / 三维点到二维的等距投影。
pub fn isometric(p : @core.Point3D) -> @core.Point2D {
  let s = 0.8660254037844387
  let h = 0.5
  @core.Point2D::new(s * (p.x - p.y), h * (p.x + p.y) - p.z)
}
