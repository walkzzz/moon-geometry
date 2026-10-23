///|
/// Spherical great-circle distance using law of cosines (meters). / 球面大圆距离（余弦定理，米）。
pub fn spherical_distance(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  let r = wgs84_a
  let phi1 = lat1 * deg2rad
  let phi2 = lat2 * deg2rad
  let dlambda = (lon2 - lon1) * deg2rad
  let cos_d = @math.sin(phi1) * @math.sin(phi2) +
    @math.cos(phi1) * @math.cos(phi2) * @math.cos(dlambda)
  let clamped = if cos_d > 1.0 {
    1.0
  } else if cos_d < -1.0 {
    -1.0
  } else {
    cos_d
  }
  r * @math.acos(clamped)
}

///|
/// Initial bearing (azimuth) from point 1 to point 2 (degrees, 0=N, 90=E). / 起始方位角（度，0=北，90=东）。
pub fn initial_bearing(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  let phi1 = lat1 * deg2rad
  let phi2 = lat2 * deg2rad
  let dlambda = (lon2 - lon1) * deg2rad
  let y = @math.sin(dlambda) * @math.cos(phi2)
  let x = @math.cos(phi1) * @math.sin(phi2) -
    @math.sin(phi1) * @math.cos(phi2) * @math.cos(dlambda)
  let theta = @math.atan2(y, x)
  (theta * rad2deg + 360.0) % 360.0
}

///|
/// Destination point given start, bearing, and distance on a sphere. / 球面上给定起点、方位角和距离的终点。
/// bearing in degrees, distance in meters. / 方位角单位为度，距离单位为米。
pub fn destination_point(
  lat1 : Double,
  lon1 : Double,
  bearing : Double,
  distance : Double,
) -> (Double, Double) {
  let r = wgs84_a
  let phi1 = lat1 * deg2rad
  let lambda1 = lon1 * deg2rad
  let theta = bearing * deg2rad
  let delta = distance / r
  let sin_phi2 = @math.sin(phi1) * @math.cos(delta) +
    @math.cos(phi1) * @math.sin(delta) * @math.cos(theta)
  let clamped = if sin_phi2 > 1.0 {
    1.0
  } else if sin_phi2 < -1.0 {
    -1.0
  } else {
    sin_phi2
  }
  let phi2 = @math.asin(clamped)
  let y = @math.sin(theta) * @math.sin(delta) * @math.cos(phi1)
  let x = @math.cos(delta) - @math.sin(phi1) * sin_phi2
  let lambda2 = lambda1 + @math.atan2(y, x)
  let lat2 = phi2 * rad2deg
  let lon2 = (lambda2 * rad2deg + 540.0) % 360.0 - 180.0
  (lat2, lon2)
}
