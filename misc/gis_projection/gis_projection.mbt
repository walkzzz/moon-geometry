///|
/// WGS84 equatorial radius (meters). / WGS84 赤道半径（米）。
pub let wgs84_radius : Double = 6378137.0

///|
/// WGS84 flattening. / WGS84 扁率。
pub let wgs84_flattening : Double = 0.0033528106647474805

///|
/// Degree to radian. / 度转弧度。
pub let deg2rad : Double = 0.017453292519943295

///|
/// Radian to degree. / 弧度转度。
pub let rad2deg : Double = 57.29577951308232

///|
/// Projected coordinate pair (x, y) in meters. / 投影坐标对（x, y），单位米。
pub struct ProjXY {
  x : Double
  y : Double
}

///|
/// Construct projected coordinate. / 构造投影坐标。
pub fn ProjXY::new(x : Double, y : Double) -> ProjXY {
  { x, y }
}

///|
/// Mercator forward projection (spherical). / Mercator 正向投影（球面）。
/// lat/lon in degrees, returns meters. / 纬度/经度单位为度，返回米。
pub fn mercator_forward(lat : Double, lon : Double) -> ProjXY {
  let r = wgs84_radius
  let lat_r = lat * deg2rad
  let lon_r = lon * deg2rad
  let x = r * lon_r
  let y = r * @math.ln(@math.tan(0.7853981633974483 + lat_r / 2.0))
  { x, y }
}

///|
/// Mercator inverse projection (spherical). / Mercator 反向投影（球面）。
/// x/y in meters, returns degrees. / x/y 单位为米，返回度。
pub fn mercator_inverse(x : Double, y : Double) -> (Double, Double) {
  let r = wgs84_radius
  let lon = (x / r) * rad2deg
  let lat = (2.0 * @math.atan(@math.exp(y / r)) - 1.5707963267948966) * rad2deg
  (lat, lon)
}

///|
/// Web Mercator (EPSG:3857) forward. / Web Mercator 正向投影。
pub fn web_mercator_forward(lat : Double, lon : Double) -> ProjXY {
  mercator_forward(lat, lon)
}

///|
/// Web Mercator inverse. / Web Mercator 反向投影。
pub fn web_mercator_inverse(x : Double, y : Double) -> (Double, Double) {
  mercator_inverse(x, y)
}

///|
/// UTM zone number from longitude (degrees). / 由经度（度）计算 UTM 带号。
pub fn utm_zone_from_lon(lon : Double) -> Int {
  let z = ((lon + 180.0) / 6.0).floor().to_int() + 1
  if z < 1 {
    1
  } else if z > 60 {
    60
  } else {
    z
  }
}

///|
/// UTM central meridian (degrees) for a zone. / 某带的 UTM 中央经线（度）。
pub fn utm_central_meridian(zone : Int) -> Double {
  (zone - 1).to_double() * 6.0 - 180.0 + 3.0
}

///|
/// UTM forward projection (spherical transverse Mercator). / UTM 正向投影（球面横轴 Mercator）。
/// lat/lon in degrees, zone computed automatically. / 纬度/经度单位为度，带号自动计算。
pub fn utm_forward(lat : Double, lon : Double) -> ProjXY {
  let zone = utm_zone_from_lon(lon)
  utm_forward_zone(lat, lon, zone)
}

///|
/// UTM forward projection for a given zone. / 指定带的 UTM 正向投影。
pub fn utm_forward_zone(lat : Double, lon : Double, zone : Int) -> ProjXY {
  let r = wgs84_radius
  let k0 = 0.9996
  let lat_r = lat * deg2rad
  let lon_r = lon * deg2rad
  let lon0 = utm_central_meridian(zone) * deg2rad
  let dlon = lon_r - lon0
  let x = k0 * r * dlon * @math.cos(lat_r)
  let y = k0 * r * @math.ln(@math.tan(0.7853981633974483 + lat_r / 2.0) * @math.cos(dlon / 2.0))
  let easting = x + 500000.0
  let northing = if lat < 0.0 { y + 10000000.0 } else { y }
  { x: easting, y: northing }
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
  let n = (@math.ln(@math.cos(lat1_r) / @math.cos(lat2_r))) /
    (@math.ln(@math.tan(0.7853981633974483 + lat2_r / 2.0) / @math.tan(0.7853981633974483 + lat1_r / 2.0)))
  let lat_r = lat * deg2rad
  let lon_r = lon * deg2rad
  let lon0_r = lon0 * deg2rad
  let lat0_r = lat0 * deg2rad
  let rho = r / @math.tan(lat_r)
  let rho0 = r / @math.tan(lat0_r)
  let theta = n * (lon_r - lon0_r)
  let x = rho * @math.sin(theta)
  let y = rho0 - rho * @math.cos(theta)
  { x, y }
}

///|
/// Albers Equal Area Conic forward (spherical, 2 standard parallels). / Albers 等面积圆锥正向投影（球面，双标准纬线）。
pub fn albers_equal_area_forward(
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
  let n = (@math.sin(lat1_r) + @math.sin(lat2_r)) / 2.0
  let c = @math.cos(lat1_r) * @math.cos(lat1_r) + 2.0 * n * @math.sin(lat1_r)
  let lat_r = lat * deg2rad
  let lon_r = lon * deg2rad
  let lon0_r = lon0 * deg2rad
  let lat0_r = lat0 * deg2rad
  let rho = r * (c - 2.0 * n * @math.sin(lat_r)).sqrt() / n
  let rho0 = r * (c - 2.0 * n * @math.sin(lat0_r)).sqrt() / n
  let theta = n * (lon_r - lon0_r)
  let x = rho * @math.sin(theta)
  let y = rho0 - rho * @math.cos(theta)
  { x, y }
}

///|
/// Scale factor at a given latitude for Mercator. / Mercator 在给定纬度的比例因子。
pub fn mercator_scale(lat : Double) -> Double {
  1.0 / @math.cos(lat * deg2rad)
}