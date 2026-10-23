///|
/// Convert ECEF to CGCS2000 geodetic. / ECEF 转 CGCS2000 大地坐标。
pub fn ecef_to_cgcs2000(e : ECEF) -> Geodetic {
  let a = cgcs2000_a
  let f = cgcs2000_f()
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
