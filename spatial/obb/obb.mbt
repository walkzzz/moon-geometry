///|
/// Oriented Bounding Box in 3D. / 三维定向包围盒。
pub struct OBB {
  center : @core.Point3D
  axes : Array[@core.Point3D]
  half_extents : Array[Double]
}


///|
pub extend OBB with @core.Measurable3D::{volume, surface_area}


///|
/// Construct an OBB. / 构造 OBB。
pub fn OBB::new(
  center : @core.Point3D,
  axes : Array[@core.Point3D],
  half_extents : Array[Double],
) -> OBB {
  { center, axes, half_extents }
}
