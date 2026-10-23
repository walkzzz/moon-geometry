///|
/// ECEF (Earth-Centered Earth-Fixed) coordinate. / 地心地固坐标。
pub struct ECEF {
  x : Double
  y : Double
  z : Double
}

///|
/// Construct ECEF coordinate. / 构造 ECEF 坐标。
pub fn ECEF::new(x : Double, y : Double, z : Double) -> ECEF {
  { x, y, z, }
}

///|
/// Geodetic coordinate (lat/lon in degrees, h in meters). / 大地坐标（纬度/经度单位为度，高程单位为米）。
pub struct Geodetic {
  lat : Double
  lon : Double
  h : Double
}
