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

///|
/// Vincenty inverse formula for geodesic distance on ellipsoid (meters). / 椭球面 Vincenty 反解公式测地距离（米）。
/// Returns -1.0 if the algorithm fails to converge. / 不收敛时返回 -1.0。
pub fn vincenty_distance(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  let a = wgs84_a
  let f = wgs84_f
  let b = (1.0 - f) * a
  let phi1 = lat1 * deg2rad
  let phi2 = lat2 * deg2rad
  let l = (lon2 - lon1) * deg2rad
  let u1 = @math.atan((1.0 - f) * @math.tan(phi1))
  let u2 = @math.atan((1.0 - f) * @math.tan(phi2))
  let sin_u1 = @math.sin(u1)
  let cos_u1 = @math.cos(u1)
  let sin_u2 = @math.sin(u2)
  let cos_u2 = @math.cos(u2)
  let mut lambda = l
  let mut iter = 0
  let max_iter = 100
  let mut sin_sigma = 0.0
  let mut cos_sigma = 0.0
  let mut sigma = 0.0
  let mut cos_sq_alpha = 0.0
  let mut cos2_sigma_m = 0.0
  let mut converged = false
  while iter < max_iter {
    let sin_lambda = @math.sin(lambda)
    let cos_lambda = @math.cos(lambda)
    sin_sigma = (cos_u2 * sin_lambda * (cos_u2 * sin_lambda) +
    (cos_u1 * sin_u2 - sin_u1 * cos_u2 * cos_lambda) *
    (cos_u1 * sin_u2 - sin_u1 * cos_u2 * cos_lambda)).sqrt()
    if sin_sigma == 0.0 {
      return 0.0
    }
    cos_sigma = sin_u1 * sin_u2 + cos_u1 * cos_u2 * cos_lambda
    sigma = @math.atan2(sin_sigma, cos_sigma)
    let sin_alpha = cos_u1 * cos_u2 * sin_lambda / sin_sigma
    cos_sq_alpha = 1.0 - sin_alpha * sin_alpha
    if cos_sq_alpha == 0.0 {
      cos2_sigma_m = 0.0
    } else {
      cos2_sigma_m = cos_sigma - 2.0 * sin_u1 * sin_u2 / cos_sq_alpha
    }
    let c = f / 16.0 * cos_sq_alpha * (4.0 + f * (4.0 - 3.0 * cos_sq_alpha))
    let lambda_prev = lambda
    lambda = l +
      (1.0 - c) *
      f *
      sin_alpha *
      (
        sigma +
        c *
        sin_sigma *
        (
          cos2_sigma_m +
          c * cos_sigma * (-1.0 + 2.0 * cos2_sigma_m * cos2_sigma_m)
        )
      )
    if (lambda - lambda_prev).abs() < 0.0000000000001 {
      converged = true
      break
    }
    iter += 1
  }
  if !converged {
    return -1.0
  }
  let u_sq = cos_sq_alpha * (a * a - b * b) / (b * b)
  let aa = 1.0 +
    u_sq / 16384.0 * (4096.0 + u_sq * (-768.0 + u_sq * (74.0 - 71.0 * u_sq)))
  let bb = u_sq /
    1024.0 *
    (256.0 + u_sq * (-128.0 + u_sq * (74.0 - 47.0 * u_sq)))
  let delta_sigma = bb *
    sin_sigma *
    (
      cos2_sigma_m +
      bb /
      4.0 *
      (
        cos_sigma * (-1.0 + 2.0 * cos2_sigma_m * cos2_sigma_m) -
        bb /
        6.0 *
        cos2_sigma_m *
        (-3.0 + 4.0 * sin_sigma * sin_sigma) *
        (-3.0 + 4.0 * cos2_sigma_m * cos2_sigma_m)
      )
    )
  b * aa * (sigma - delta_sigma)
}

///|
/// Antipodal check: are two points nearly antipodal? / 对跖点检查：两点是否近似对跖？
pub fn is_antipodal(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Bool {
  let d = haversine_distance(lat1, lon1, lat2, lon2)
  d > 19000000.0
}
