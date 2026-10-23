///|
/// Convert CGCS2000 geodetic to ECEF. / CGCS2000 大地坐标转 ECEF。
pub fn cgcs2000_to_ecef(g : Geodetic) -> ECEF {
  let a = cgcs2000_a
  let f = cgcs2000_f()
  let e2 = f * (2.0 - f)
  let lat_r = g.lat * deg2rad
  let lon_r = g.lon * deg2rad
  let n = prime_vertical(lat_r, a, f)
  let x = (n + g.h) * @math.cos(lat_r) * @math.cos(lon_r)
  let y = (n + g.h) * @math.cos(lat_r) * @math.sin(lon_r)
  let z = (n * (1.0 - e2) + g.h) * @math.sin(lat_r)
  { x, y, z }
}
