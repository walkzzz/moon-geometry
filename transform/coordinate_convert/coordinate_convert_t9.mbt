///|
/// Convert WGS84 to CGCS2000 (via ECEF). / WGS84 转 CGCS2000（经 ECEF）。
pub fn wgs84_to_cgcs2000(g : Geodetic) -> Geodetic {
  let e = wgs84_to_ecef(g)
  ecef_to_cgcs2000(e)
}

///|
/// Convert CGCS2000 to WGS84 (via ECEF). / CGCS2000 转 WGS84（经 ECEF）。
pub fn cgcs2000_to_wgs84(g : Geodetic) -> Geodetic {
  let e = cgcs2000_to_ecef(g)
  ecef_to_wgs84(e)
}

///|
/// ECEF distance (Euclidean, meters). / ECEF 欧氏距离（米）。
pub fn ecef_distance(e1 : ECEF, e2 : ECEF) -> Double {
  let dx = e1.x - e2.x
  let dy = e1.y - e2.y
  let dz = e1.z - e2.z
  (dx * dx + dy * dy + dz * dz).sqrt()
}
