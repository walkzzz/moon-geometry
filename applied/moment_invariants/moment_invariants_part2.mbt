///|
/// Raw (geometric) moment M_pq = sum x^p * y^q.
/// 原始（几何）矩 M_pq = sum x^p * y^q。
pub fn raw_moment(
  points : Array[@core.Point2D],
  p : Int32,
  q : Int32,
) -> Double {
  let mut m = 0.0
  for pt in points {
    m += powi(pt.x(), p) * powi(pt.y(), q)
  }
  m
}

///|
/// Centroid of a point set. / 点集质心。
pub fn centroid(points : Array[@core.Point2D]) -> (@core.Point2D, Double) {
  let m00 = raw_moment(points, 0, 0)
  if m00.abs() < 0.000000000001 {
    return (@core.Point2D::new(0.0, 0.0), 0.0)
  }
  let m10 = raw_moment(points, 1, 0)
  let m01 = raw_moment(points, 0, 1)
  (@core.Point2D::new(m10 / m00, m01 / m00), m00)
}

///|
/// Central moment mu_pq = sum (x-x_bar)^p * (y-y_bar)^q.
/// 中心矩 mu_pq = sum (x-x_bar)^p * (y-y_bar)^q。
pub fn central_moment(
  points : Array[@core.Point2D],
  p : Int32,
  q : Int32,
) -> Double {
  let (c, m00) = centroid(points)
  if m00.abs() < 0.000000000001 {
    return 0.0
  }
  let mut m = 0.0
  for pt in points {
    m += powi(pt.x() - c.x(), p) * powi(pt.y() - c.y(), q)
  }
  m
}
