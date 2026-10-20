///|
/// # Texture Mapping | 纹理映射
/// Texture mapping coordinates. / 纹理映射坐标。
///|
pub fn spherical_mapping(point : (Double, Double, Double)) -> (Double, Double) {
  let r = (point.0 * point.0 + point.1 * point.1 + point.2 * point.2).sqrt()
  let theta = @math.atan2(point.1, point.0)
  let phi = if r.abs() < 0.000000000001 { 0.0 } else { @math.acos(point.2 / r) }
  (theta / (2.0 * @math.PI), phi / @math.PI)
}
///|
pub fn cylindrical_mapping(point : (Double, Double, Double)) -> (Double, Double) {
  let theta = @math.atan2(point.1, point.0)
  (theta / (2.0 * @math.PI), point.2)
}
///|
pub fn planar_mapping(point : (Double, Double, Double), u_axis : (Double, Double), v_axis : (Double, Double)) -> (Double, Double) {
  (point.0 * u_axis.0 + point.1 * u_axis.1, point.0 * v_axis.0 + point.1 * v_axis.1)
}
///|
pub fn tri_planar_mapping(point : (Double, Double, Double), normal : (Double, Double, Double)) -> (Double, Double) {
  let nx = normal.0.abs(); let ny = normal.1.abs(); let nz = normal.2.abs()
  if nx >= ny && nx >= nz { (point.1, point.2) }
  else if ny >= nz { (point.0, point.2) }
  else { (point.0, point.1) }
}
