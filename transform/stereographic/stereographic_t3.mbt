///|
/// Check if a 3D point lies on a sphere of given radius. / 检查三维点是否在给定半径的球面上。
pub fn on_sphere(
  p : @core.Point3D,
  radius : Double,
) -> Bool {
  let r2 = p.x * p.x + p.y * p.y + p.z * p.z
  @core.approx_eq(r2, radius * radius, 0.0001)
}
