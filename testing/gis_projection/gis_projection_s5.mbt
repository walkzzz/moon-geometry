///|
/// UTM central meridian (degrees) for a zone. / 某带的 UTM 中央经线（度）。
pub fn utm_central_meridian(zone : Int32) -> Double {
  (zone - 1).to_double() * 6.0 - 180.0 + 3.0
}

///|
/// UTM forward projection (spherical transverse Mercator). / UTM 正向投影（球面横轴 Mercator）。
/// lat/lon in degrees, zone computed automatically. / 纬度/经度单位为度，带号自动计算。
pub fn utm_forward(lat : Double, lon : Double) -> ProjXY {
  let zone = utm_zone_from_lon(lon)
  utm_forward_zone(lat, lon, zone)
}
