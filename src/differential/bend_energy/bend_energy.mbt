///|
/// # Bend Energy (Elastic Rod Model)
/// # 弯曲能量（弹性杆模型）
///
/// Integral of kappa^2 ds along a curve, measuring total bending.
/// 沿曲线的 kappa^2 ds 积分，度量总弯曲。
///
/// ## Complexity: O(n)
/// ## 复杂度: O(n)

///|
/// Discrete signed curvature at the middle of three points.
/// 三点中间点的离散有符号曲率。
fn curvature_at(
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
  let len3 = ((p3.x() - p1.x()) * (p3.x() - p1.x()) +
    (p3.y() - p1.y()) * (p3.y() - p1.y())).sqrt()
  if len3 < 0.000000000001 {
    return 0.0
  }
  2.0 * cross / (len1 * len2 * len3)
}

///|
/// Arc length element at a point (average of adjacent edge lengths).
/// 某点处的弧长元（相邻边长的平均值）。
fn arc_length_element(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> Double {
  let len1 = p1.dist(p2)
  let len2 = p2.dist(p3)
  (len1 + len2) / 2.0
}

///|
/// Bend energy of a closed curve: integral of kappa^2 ds.
/// 闭合曲线的弯曲能量：kappa^2 ds 积分。
pub fn bend_energy(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut energy = 0.0
  for i in 0..<n {
    let prev = points[(i - 1 + n) % n]
    let curr = points[i]
    let next = points[(i + 1) % n]
    let kappa = curvature_at(prev, curr, next)
    let ds = arc_length_element(prev, curr, next)
    energy += kappa * kappa * ds
  }
  energy
}

///|
/// Bend energy of an open curve (endpoints not wrapped).
/// 开放曲线的弯曲能量（端点不环绕）。
pub fn bend_energy_open(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut energy = 0.0
  for i in 1..<(n - 1) {
    let kappa = curvature_at(points[i - 1], points[i], points[i + 1])
    let ds = arc_length_element(points[i - 1], points[i], points[i + 1])
    energy += kappa * kappa * ds
  }
  energy
}

///|
/// Total absolute curvature: integral of |kappa| ds.
/// 总绝对曲率：|kappa| ds 积分。
pub fn total_curvature_energy(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut total = 0.0
  for i in 0..<n {
    let prev = points[(i - 1 + n) % n]
    let curr = points[i]
    let next = points[(i + 1) % n]
    let kappa = curvature_at(prev, curr, next)
    let ds = arc_length_element(prev, curr, next)
    total += kappa.abs() * ds
  }
  total
}

///|
/// Elastic energy: bend + tension (stretch) energy.
/// 弹性能量：弯曲 + 张力（拉伸）能量。
///
/// E = integral(kappa^2 ds) + tension * integral(ds).
/// E = kappa^2 ds 积分 + tension * ds 积分。
pub fn elastic_energy(
  points : Array[@core.Point2D],
  tension : Double,
) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut bend = 0.0
  let mut length = 0.0
  for i in 0..<n {
    let prev = points[(i - 1 + n) % n]
    let curr = points[i]
    let next = points[(i + 1) % n]
    let kappa = curvature_at(prev, curr, next)
    let ds = arc_length_element(prev, curr, next)
    bend += kappa * kappa * ds
    length += ds
  }
  bend + tension * length
}

///|
/// Total arc length of a closed curve. / 闭合曲线的总弧长。
pub fn curve_length(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  let mut len = 0.0
  for i in 0..<n {
    len += points[i].dist(points[(i + 1) % n])
  }
  len
}
///|
/// Normalized bend energy: E / (2π). / 归一化弯曲能量：E / (2π)。
///
/// Scale-invariant shape descriptor commonly used in computer vision.
/// 尺度不变的形状描述子，常用于计算机视觉。
pub fn normalized_bend_energy(points : Array[@core.Point2D]) -> Double {
  bend_energy(points) / (2.0 * @math.PI)
}