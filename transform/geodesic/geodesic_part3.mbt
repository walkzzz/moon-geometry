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
