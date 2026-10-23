///|
/// Projected coordinate pair (x, y) in meters. / 投影坐标对（x, y），单位米。
pub struct ProjXY {
  x : Double
  y : Double
}


///|
/// Construct projected coordinate. / 构造投影坐标。
pub fn ProjXY::new(x : Double, y : Double) -> ProjXY {
  { x, y }
}


///|
/// Mercator forward projection (spherical). / Mercator 正向投影（球面）。
/// lat/lon in degrees, returns meters. / 纬度/经度单位为度，返回米。
pub fn mercator_forward(lat : Double, lon : Double) -> ProjXY {
  let r = wgs84_radius
  let lat_r = lat * deg2rad
  let lon_r = lon * deg2rad
  let x = r * lon_r
  let y = r * @math.ln(@math.tan(0.7853981633974483 + lat_r / 2.0))
  { x, y }
}


///|
/// Mercator inverse projection (spherical). / Mercator 反向投影（球面）。
/// x/y in meters, returns degrees. / x/y 单位为米，返回度。
pub fn mercator_inverse(x : Double, y : Double) -> (Double, Double) {
  let r = wgs84_radius
  let lon = (x / r) * rad2deg
  let lat = (2.0 * @math.atan(@math.exp(y / r)) - 1.5707963267948966) * rad2deg
  (lat, lon)
}
