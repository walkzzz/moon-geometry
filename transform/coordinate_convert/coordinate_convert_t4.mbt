///|
/// Construct geodetic coordinate. / 构造大地坐标。
pub fn Geodetic::new(lat : Double, lon : Double, h : Double) -> Geodetic {
  { lat, lon, h }
}


///|
/// WGS84 flattening. / WGS84 扁率。
fn wgs84_f() -> Double {
  1.0 / wgs84_inv_f
}


///|
/// CGCS2000 flattening. / CGCS2000 扁率。
fn cgcs2000_f() -> Double {
  1.0 / cgcs2000_inv_f
}
