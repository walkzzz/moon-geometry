///|
/// Albers Equal Area Conic forward (spherical, 2 standard parallels). / Albers 等面积圆锥正向投影（球面，双标准纬线）。
pub fn albers_equal_area_forward(
  lat : Double,
  lon : Double,
  lat1 : Double,
  lat2 : Double,
  lat0 : Double,
  lon0 : Double,
) -> ProjXY {
  let r = wgs84_radius
  let lat1_r = lat1 * deg2rad
  let lat2_r = lat2 * deg2rad
  let n = (@math.sin(lat1_r) + @math.sin(lat2_r)) / 2.0
  let c = @math.cos(lat1_r) * @math.cos(lat1_r) + 2.0 * n * @math.sin(lat1_r)
  let lat_r = lat * deg2rad
  let lon_r = lon * deg2rad
  let lon0_r = lon0 * deg2rad
  let lat0_r = lat0 * deg2rad
  let rho = r * (c - 2.0 * n * @math.sin(lat_r)).sqrt() / n
  let rho0 = r * (c - 2.0 * n * @math.sin(lat0_r)).sqrt() / n
  let theta = n * (lon_r - lon0_r)
  let x = rho * @math.sin(theta)
  let y = rho0 - rho * @math.cos(theta)
  { x, y }
}


///|
/// Scale factor at a given latitude for Mercator. / Mercator 在给定纬度的比例因子。
pub fn mercator_scale(lat : Double) -> Double {
  1.0 / @math.cos(lat * deg2rad)
}