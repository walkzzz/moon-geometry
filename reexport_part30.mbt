///|
/// 3D plane type. / 三维平面类型。
pub type Plane = @plane.Plane


///|
/// Plane from normal and point. / 由法向量和点构造平面。
pub fn plane_from_normal_point(normal : Point3D, point : Point3D) -> Plane {
  @plane.Plane::from_normal_point(normal, point)
}


///|
/// Plane from three points. / 由三点构造平面。
pub fn plane_from_three_points(a : Point3D, b : Point3D, c : Point3D) -> Plane {
  @plane.Plane::from_three_points(a, b, c)
}


///|
/// Signed distance from point to plane. / 点到平面有符号距离。
pub fn plane_distance(plane : Plane, p : Point3D) -> Double {
  @plane.Plane::distance(plane, p)
}


///|
/// Check if point is on plane. / 检查点是否在平面上。
pub fn plane_contains(plane : Plane, p : Point3D, eps : Double) -> Bool {
  @plane.Plane::contains(plane, p, eps)
}


///|
/// Plane-line intersection. / 平面与直线交点。
pub fn plane_line_intersect(
  plane : Plane,
  origin : Point3D,
  dir : Point3D,
) -> Point3D? {
  @plane.Plane::line_intersect(plane, origin, dir)
}
