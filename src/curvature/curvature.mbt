///|
/// Discrete curvature at middle point of three points. / 三点中间点的离散曲率。
pub fn curvature_at(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> Double {
  let dx1 = p2.x() - p1.x()
  let dy1 = p2.y() - p1.y()
  let dx2 = p3.x() - p2.x()
  let dy2 = p3.y() - p2.y()
  let cross = dx1 * dy2 - dy1 * dx2
  let len1 = (dx1 * dx1 + dy1 * dy1).sqrt()
  let len2 = (dx2 * dx2 + dy2 * dy2).sqrt()
  if len1 < 0.000000000001 || len2 < 0.000000000001 {
    return 0.0
  }
  let len3 = ((p3.x() - p1.x()) * (p3.x() - p1.x()) + (p3.y() - p1.y()) * (p3.y() - p1.y())).sqrt()
  if len3 < 0.000000000001 {
    return 0.0
  }
  2.0 * cross.abs() / (len1 * len2 * len3)
}

///|
/// Signed curvature (positive = left turn, negative = right turn). / 有符号曲率（正=左转，负=右转）。
pub fn curvature_signed(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> Double {
  let dx1 = p2.x() - p1.x()
  let dy1 = p2.y() - p1.y()
  let dx2 = p3.x() - p2.x()
  let dy2 = p3.y() - p2.y()
  let cross = dx1 * dy2 - dy1 * dx2
  let len1 = (dx1 * dx1 + dy1 * dy1).sqrt()
  let len2 = (dx2 * dx2 + dy2 * dy2).sqrt()
  if len1 < 0.000000000001 || len2 < 0.000000000001 {
    return 0.0
  }
  let len3 = ((p3.x() - p1.x()) * (p3.x() - p1.x()) + (p3.y() - p1.y()) * (p3.y() - p1.y())).sqrt()
  if len3 < 0.000000000001 {
    return 0.0
  }
  2.0 * cross / (len1 * len2 * len3)
}

///|
/// Curvature profile at all interior points. / 所有内部点的曲率分布。
pub fn curvature_profile(
  points : Array[@core.Point2D],
) -> Array[Double] {
  let n = points.length()
  let result : Array[Double] = []
  if n < 3 {
    return result
  }
  for i in 1..<(n - 1) {
    result.push(curvature_at(points[i - 1], points[i], points[i + 1]))
  }
  result
}

///|
/// Radius of curvature (1/curvature). / 曲率半径（1/曲率）。
pub fn curvature_radius(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> Double {
  let k = curvature_at(p1, p2, p3)
  if k < 0.000000000001 {
    return 1.0 / 0.000000000001
  }
  1.0 / k
}

///|
/// Total absolute curvature (approximation of total curvature). / 总绝对曲率。
pub fn curvature_total(
  points : Array[@core.Point2D],
) -> Double {
  let profile = curvature_profile(points)
  let mut total = 0.0
  for k in profile {
    total += k
  }
  total
}