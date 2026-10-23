///|
/// UTM zone number from longitude (degrees). / 由经度（度）计算 UTM 带号。
pub fn utm_zone_from_lon(lon : Double) -> Int32 {
  let z = ((lon + 180.0) / 6.0).floor().to_int() + 1
  if z < 1 {
    1
  } else if z > 60 {
    60
  } else {
    z
  }
}
