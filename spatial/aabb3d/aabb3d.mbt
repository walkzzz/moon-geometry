///|
/// 3D Axis-Aligned Bounding Box. / 三维轴对齐包围盒。
pub struct AABB3D {
  min_x : Double
  min_y : Double
  min_z : Double
  max_x : Double
  max_y : Double
  max_z : Double
}

///|
pub extend AABB3D with @core.Measurable3D::{volume, surface_area}

///|
/// Construct an AABB3D from min and max corners. / 从最小和最大角点构造 AABB3D。
pub fn AABB3D::new(
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
) -> AABB3D {
  { min_x, min_y, min_z, max_x, max_y, max_z, }
}
