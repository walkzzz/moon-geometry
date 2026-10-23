///|
/// 3D plane: normal · p + d = 0. / 三维平面。
pub struct Plane {
  normal : @core.Point3D
  d : Double
} derive(Debug)

///|
pub extend Plane with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Construct a plane from normal and a point on the plane. / 由法向量和面上一点构造平面。
pub fn Plane::from_normal_point(
  normal : @core.Point3D,
  point : @core.Point3D,
) -> Plane {
  let d = -(normal.x * point.x + normal.y * point.y + normal.z * point.z)
  { normal, d, }
}

///|
/// Construct a plane from three points. / 由三点构造平面。
pub fn Plane::from_three_points(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
) -> Plane {
  let ux = b.x - a.x
  let uy = b.y - a.y
  let uz = b.z - a.z
  let vx = c.x - a.x
  let vy = c.y - a.y
  let vz = c.z - a.z
  let nx = uy * vz - uz * vy
  let ny = uz * vx - ux * vz
  let nz = ux * vy - uy * vx
  let normal = @core.Point3D::new(nx, ny, nz)
  let d = -(nx * a.x + ny * a.y + nz * a.z)
  { normal, d, }
}

///|
/// Signed distance from point to plane. / 点到平面的有符号距离。
pub fn Plane::distance(plane : Plane, p : @core.Point3D) -> Double {
  let nlen = (plane.normal.x * plane.normal.x +
  plane.normal.y * plane.normal.y +
  plane.normal.z * plane.normal.z).sqrt()
  if nlen < 0.000000000001 {
    return 0.0
  }
  (plane.normal.x * p.x + plane.normal.y * p.y + plane.normal.z * p.z + plane.d) /
  nlen
}

///|
/// Check if a point is on the plane. / 检查点是否在平面上。
pub fn Plane::contains(plane : Plane, p : @core.Point3D, eps : Double) -> Bool {
  Plane::distance(plane, p).abs() < eps
}

///|
/// Intersection of a plane and a 3D ray (origin + t*dir). Returns t or None. / 平面与三维射线交点。
pub fn Plane::line_intersect(
  plane : Plane,
  origin : @core.Point3D,
  dir : @core.Point3D,
) -> @core.Point3D? {
  let denom = plane.normal.x * dir.x +
    plane.normal.y * dir.y +
    plane.normal.z * dir.z
  if @core.approx_eq(denom, 0.0, 0.000000000001) {
    return None
  }
  let t = -(plane.normal.x * origin.x +
    plane.normal.y * origin.y +
    plane.normal.z * origin.z +
    plane.d) /
    denom
  Some(
    @core.Point3D::new(
      origin.x + dir.x * t,
      origin.y + dir.y * t,
      origin.z + dir.z * t,
    ),
  )
}

///|
/// Normalize the plane normal to unit length. / 归一化平面法向量。
pub fn Plane::normalize(plane : Plane) -> Plane {
  let nlen = (plane.normal.x * plane.normal.x +
  plane.normal.y * plane.normal.y +
  plane.normal.z * plane.normal.z).sqrt()
  if nlen < 0.000000000001 {
    return plane
  }
  {
    normal: @core.Point3D::new(
      plane.normal.x / nlen,
      plane.normal.y / nlen,
      plane.normal.z / nlen,
    ),
    d: plane.d / nlen,
  }
}

///|
/// Project a point onto the plane. / 将点投影到平面。
pub fn Plane::project(plane : Plane, p : @core.Point3D) -> @core.Point3D {
  let dist = Plane::distance(plane, p)
  let nlen = (plane.normal.x * plane.normal.x +
  plane.normal.y * plane.normal.y +
  plane.normal.z * plane.normal.z).sqrt()
  if nlen < 0.000000000001 {
    return p
  }
  let nx = plane.normal.x / nlen
  let ny = plane.normal.y / nlen
  let nz = plane.normal.z / nlen
  @core.Point3D::new(p.x - dist * nx, p.y - dist * ny, p.z - dist * nz)
}
