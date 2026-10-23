///|
/// Prime vertical radius of curvature (N). / 卯酉圈曲率半径。
fn prime_vertical(lat_r : Double, a : Double, f : Double) -> Double {
  let e2 = f * (2.0 - f)
  a / (1.0 - e2 * @math.sin(lat_r) * @math.sin(lat_r)).sqrt()
}


///|
/// Convert WGS84 geodetic to ECEF. / WGS84 大地坐标转 ECEF。
pub fn wgs84_to_ecef(g : Geodetic) -> ECEF {
  let a = wgs84_a
  let f = wgs84_f()
  let e2 = f * (2.0 - f)
  let lat_r = g.lat * deg2rad
  let lon_r = g.lon * deg2rad
  let n = prime_vertical(lat_r, a, f)
  let x = (n + g.h) * @math.cos(lat_r) * @math.cos(lon_r)
  let y = (n + g.h) * @math.cos(lat_r) * @math.sin(lon_r)
  let z = (n * (1.0 - e2) + g.h) * @math.sin(lat_r)
  { x, y, z }
}
