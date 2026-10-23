///|
/// UTM forward projection for a given zone. / 指定带的 UTM 正向投影。
pub fn utm_forward_zone(lat : Double, lon : Double, zone : Int32) -> ProjXY {
  let r = wgs84_radius
  let k0 = 0.9996
  let lat_r = lat * deg2rad
  let lon_r = lon * deg2rad
  let lon0 = utm_central_meridian(zone) * deg2rad
  let dlon = lon_r - lon0
  let x = k0 * r * dlon * @math.cos(lat_r)
  let y = k0 *
    r *
    @math.ln(
      @math.tan(0.7853981633974483 + lat_r / 2.0) * @math.cos(dlon / 2.0),
    )
  let easting = x + 500000.0
  let northing = if lat < 0.0 { y + 10000000.0 } else { y }
  { x: easting, y: northing, }
}

///|
/// Lambert Conformal Conic forward (spherical, 2 standard parallels). / Lambert 等角圆锥正向投影（球面，双标准纬线）。
pub fn lambert_conformal_forward(
  lat : Double,
  lon : Double,
  lat1 : Double,
  lat2 : Double,
  lat0 : Double,
  lon0 : Double,
) -> ProjXY {
  let r = wgs84_radius
  let lat1_r = lat1 * deg2rad
  let lat2_r = lat2 * deg2rad
  let n = @math.ln(@math.cos(lat1_r) / @math.cos(lat2_r)) /
    @math.ln(
      @math.tan(0.7853981633974483 + lat2_r / 2.0) /
      @math.tan(0.7853981633974483 + lat1_r / 2.0),
    )
  let lat_r = lat * deg2rad
  let lon_r = lon * deg2rad
  let lon0_r = lon0 * deg2rad
  let lat0_r = lat0 * deg2rad
  let rho = r / @math.tan(lat_r)
  let rho0 = r / @math.tan(lat0_r)
  let theta = n * (lon_r - lon0_r)
  let x = rho * @math.sin(theta)
  let y = rho0 - rho * @math.cos(theta)
  { x, y, }
}
