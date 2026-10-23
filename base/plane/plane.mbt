///|
/// 3D plane: normal · p + d = 0. / 三维平面。
pub struct Plane {
  normal : @core.Point3D
  d : Double
} derive(Debug)

pub extend Plane with @moonbitlang/core/debug.Debug::{to_repr}


///|
/// Construct a plane from normal and a point on the plane. / 由法向量和面上一点构造平面。
pub fn Plane::from_normal_point(
  normal : @core.Point3D,
  point : @core.Point3D,
) -> Plane {
  let d = -(normal.x * point.x + normal.y * point.y + normal.z * point.z)
  { normal, d }
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
  { normal, d }
}
