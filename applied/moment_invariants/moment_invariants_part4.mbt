///|
/// Zernike moment V_n^m (returns real and imaginary parts).
/// Zernike 矩 V_n^m（返回实部和虚部）。
///
/// Points are mapped to the unit disk centered at centroid.
/// 点被映射到以质心为中心的单位圆盘。
pub fn zernike_moment(
  points : Array[@core.Point2D],
  n : Int,
  m : Int,
) -> (Double, Double) {
  let (c, _) = centroid(points)
  let mut r_max = 0.0
  for pt in points {
    let d = pt.dist(c)
    if d > r_max {
      r_max = d
    }
  }
  if r_max < 0.000000000001 {
    return (0.0, 0.0)
  }
  let count = points.length().to_double()
  let mut re = 0.0
  let mut im = 0.0
  for pt in points {
    let dx = (pt.x() - c.x()) / r_max
    let dy = (pt.y() - c.y()) / r_max
    let r = (dx * dx + dy * dy).sqrt()
    let theta = @math.atan2(dy, dx)
    let radial = zernike_radial(n, m, r)
    re += radial * @math.cos(m.to_double() * theta)
    im += radial * @math.sin(m.to_double() * theta)
  }
  (re / count, im / count)
}


///|
/// Magnitude of a Zernike moment (rotation invariant).
/// Zernike 矩的模长（旋转不变）。
pub fn zernike_magnitude(
  points : Array[@core.Point2D],
  n : Int,
  m : Int,
) -> Double {
  let (re, im) = zernike_moment(points, n, m)
  (re * re + im * im).sqrt()
}