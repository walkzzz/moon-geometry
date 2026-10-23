///|
/// WGS84 equatorial radius (meters). / WGS84 赤道半径（米）。
pub let wgs84_a : Double = 6378137.0

///|
/// WGS84 polar radius (meters). / WGS84 极半径（米）。
pub let wgs84_b : Double = 6356752.314245

///|
/// WGS84 flattening. / WGS84 扁率。
pub let wgs84_f : Double = 0.0033528106647474805

///|
/// Degree to radian. / 度转弧度。
pub let deg2rad : Double = 0.017453292519943295

///|
/// Radian to degree. / 弧度转度。
pub let rad2deg : Double = 57.29577951308232

///|
/// Haversine great-circle distance on a sphere (meters). / 球面 Haversine 大圆距离（米）。
/// lat1/lon1/lat2/lon2 in degrees. / 纬度/经度单位为度。
pub fn haversine_distance(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  let r = wgs84_a
  let phi1 = lat1 * deg2rad
  let phi2 = lat2 * deg2rad
  let dphi = (lat2 - lat1) * deg2rad
  let dlambda = (lon2 - lon1) * deg2rad
  let a = @math.sin(dphi / 2.0) * @math.sin(dphi / 2.0) +
    @math.cos(phi1) *
    @math.cos(phi2) *
    @math.sin(dlambda / 2.0) *
    @math.sin(dlambda / 2.0)
  let c = 2.0 * @math.atan2(a.sqrt(), (1.0 - a).sqrt())
  r * c
}
