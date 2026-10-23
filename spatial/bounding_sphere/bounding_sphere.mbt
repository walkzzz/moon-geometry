///|
/// Bounding sphere (center + radius). / 包围球（中心 + 半径）。
pub struct BoundingSphere {
  center : @core.Point3D
  radius : Double
}


///|
pub extend BoundingSphere with @core.Measurable3D::{volume, surface_area}


///|
/// Construct a bounding sphere. / 构造包围球。
pub fn BoundingSphere::new(center : @core.Point3D, radius : Double) -> BoundingSphere {
  { center, radius }
}


///|
/// Trivial sphere from 0 points. / 零点的平凡球。
fn sphere_from_0() -> BoundingSphere {
  { center: @core.Point3D::new(0.0, 0.0, 0.0), radius: 0.0 }
}


///|
/// Sphere from 1 point. / 一点的球。
fn sphere_from_1(p0 : @core.Point3D) -> BoundingSphere {
  { center: p0, radius: 0.0 }
}


///|
/// Sphere from 2 points (diameter = segment). / 两点的球（直径为线段）。
fn sphere_from_2(p0 : @core.Point3D, p1 : @core.Point3D) -> BoundingSphere {
  let c = @core.Point3D::new(
    (p0.x + p1.x) / 2.0,
    (p0.y + p1.y) / 2.0,
    (p0.z + p1.z) / 2.0,
  )
  let r = p0.dist(p1) / 2.0
  { center: c, radius: r }
}
