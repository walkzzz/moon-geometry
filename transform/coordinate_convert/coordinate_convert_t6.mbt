///|
/// Convert ECEF to WGS84 geodetic (iterative). / ECEF 转 WGS84 大地坐标（迭代法）。
pub fn ecef_to_wgs84(e : ECEF) -> Geodetic {
  let a = wgs84_a
  let f = wgs84_f()
  let e2 = f * (2.0 - f)

  let p = (e.x * e.x + e.y * e.y).sqrt()
  let mut lat = @math.atan2(e.z, p * (1.0 - e2))
  let mut iter = 0
  let mut n = 0.0
  while iter < 10 {
    n = a / (1.0 - e2 * @math.sin(lat) * @math.sin(lat)).sqrt()
    let new_lat = @math.atan2(e.z + e2 * n * @math.sin(lat), p)
    if (new_lat - lat).abs() < 0.0000000000001 {
      lat = new_lat
      break
    }
    lat = new_lat
    iter += 1
  }
  let lon = @math.atan2(e.y, e.x)
  let h = p / @math.cos(lat) - n
  { lat: lat * rad2deg, lon: lon * rad2deg, h, }
}
