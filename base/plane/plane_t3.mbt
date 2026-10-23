///|
/// Check if a point is on the plane. / 检查点是否在平面上。
pub fn Plane::contains(plane : Plane, p : @core.Point3D, eps : Double) -> Bool {
  Plane::distance(plane, p).abs() < eps
}
