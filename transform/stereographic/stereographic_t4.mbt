///|
/// Compute the scale factor of stereographic projection at a point. / 计算球极投影在某点的缩放因子。
pub fn stereographic_scale(
  p : @core.Point3D,
  radius : Double,
) -> Double {
  let denom = radius - p.z
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return 0.0
  }
  2.0 * radius * radius / (denom * denom)
}