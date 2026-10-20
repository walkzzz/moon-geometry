///|
/// Result of a line fit: y = slope * x + intercept.
/// 直线拟合结果：y = slope * x + intercept。
pub struct LineFit {
  slope : Double
  intercept : Double
  r_squared : Double
} derive(Debug)

///|
pub extend LineFit with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Result of a circle fit: center (cx, cy) and radius.
/// 圆拟合结果：圆心 (cx, cy) 和半径。
pub struct CircleFit {
  cx : Double
  cy : Double
  radius : Double
  r_squared : Double
} derive(Debug)

///|
pub extend CircleFit with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Least-squares line fit: y = slope * x + intercept.
/// Returns None if fewer than 2 points or vertical line.
/// R² is the coefficient of determination.
///
/// 最小二乘直线拟合。少于 2 点或垂直线返回 None。
pub fn fit_line(points : Array[@core.Point2D]) -> LineFit? {
  let n = points.length()
  if n < 2 {
    return None
  }
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  let mut sum_xy = 0.0
  let mut sum_x2 = 0.0
  for p in points {
    let x = p.x()
    let y = p.y()
    sum_x += x
    sum_y += y
    sum_xy += x * y
    sum_x2 += x * x
  }
  let nd = n.to_double()
  let denom = nd * sum_x2 - sum_x * sum_x
  if @core.approx_eq(denom, 0.0, 0.000000000001) {
    return None
  }
  let slope = (nd * sum_xy - sum_x * sum_y) / denom
  let intercept = (sum_y - slope * sum_x) / nd
  let ss_res = {
    let mut s = 0.0
    for p in points {
      let residual = p.y() - (slope * p.x() + intercept)
      s += residual * residual
    }
    s
  }
  let mean_y = sum_y / nd
  let ss_tot = {
    let mut s = 0.0
    for p in points {
      let d = p.y() - mean_y
      s += d * d
    }
    s
  }
  let r2 = if @core.approx_eq(ss_tot, 0.0, 0.000000000001) {
    1.0
  } else {
    1.0 - ss_res / ss_tot
  }
  Some({ slope, intercept, r_squared: r2, })
}

///|
/// Orthogonal distance regression (total least squares) line fit.
/// Minimizes perpendicular distances to the line.
/// Returns (a, b, c) for line ax + by + c = 0, normalized.
///
/// 正交距离回归（全最小二乘）直线拟合。
/// 最小化到直线的垂直距离。返回 (a, b, c) 满足 ax + by + c = 0。
pub fn fit_line_orthogonal(
  points : Array[@core.Point2D],
) -> (Double, Double, Double)? {
  let n = points.length()
  if n < 2 {
    return None
  }
  let nd = n.to_double()
  let mut mean_x = 0.0
  let mut mean_y = 0.0
  for p in points {
    mean_x += p.x()
    mean_y += p.y()
  }
  mean_x /= nd
  mean_y /= nd
  let mut sxx = 0.0
  let mut syy = 0.0
  let mut sxy = 0.0
  for p in points {
    let dx = p.x() - mean_x
    let dy = p.y() - mean_y
    sxx += dx * dx
    syy += dy * dy
    sxy += dx * dy
  }
  let theta = 0.5 * @math.atan2(2.0 * sxy, sxx - syy)
  let a = @math.sin(theta)
  let b = -@math.cos(theta)
  let c = -(a * mean_x + b * mean_y)
  Some((a, b, c))
}

///|
/// Least-squares circle fit using Kåsa method.
/// Solves the linear system from (x-a)² + (y-b)² = r².
/// Returns None if fewer than 3 points.
///
/// 最小二乘圆拟合（Kåsa 方法）。少于 3 点返回 None。
pub fn fit_circle(points : Array[@core.Point2D]) -> CircleFit? {
  let n = points.length()
  if n < 3 {
    return None
  }
  let nd = n.to_double()
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  let mut sum_x2 = 0.0
  let mut sum_y2 = 0.0
  let mut sum_x3 = 0.0
  let mut sum_y3 = 0.0
  let mut sum_xy = 0.0
  let mut sum_x1y2 = 0.0
  let mut sum_x2y1 = 0.0
  for p in points {
    let x = p.x()
    let y = p.y()
    let x2 = x * x
    let y2 = y * y
    sum_x += x
    sum_y += y
    sum_x2 += x2
    sum_y2 += y2
    sum_x3 += x2 * x
    sum_y3 += y2 * y
    sum_xy += x * y
    sum_x1y2 += x * y2
    sum_x2y1 += x2 * y
  }
  let a11 = sum_x2 - sum_x * sum_x / nd
  let a12 = sum_xy - sum_x * sum_y / nd
  let a21 = sum_xy - sum_x * sum_y / nd
  let a22 = sum_y2 - sum_y * sum_y / nd
  let b1 = (sum_x3 + sum_x1y2 - sum_x * (sum_x2 + sum_y2) / nd) / 2.0
  let b2 = (sum_x2y1 + sum_y3 - sum_y * (sum_x2 + sum_y2) / nd) / 2.0
  let det = a11 * a22 - a12 * a21
  if @core.approx_eq(det, 0.0, 0.000000000001) {
    return None
  }
  let cx = (a22 * b1 - a12 * b2) / det
  let cy = (-a21 * b1 + a11 * b2) / det
  let radius = {
    let mut s = 0.0
    for p in points {
      let dx = p.x() - cx
      let dy = p.y() - cy
      s += (dx * dx + dy * dy).sqrt()
    }
    s / nd
  }
  let ss_res = {
    let mut s = 0.0
    for p in points {
      let dx = p.x() - cx
      let dy = p.y() - cy
      let d = (dx * dx + dy * dy).sqrt() - radius
      s += d * d
    }
    s
  }
  let ss_tot = {
    let mut s = 0.0
    for p in points {
      let dx = p.x() - cx
      let dy = p.y() - cy
      let d = (dx * dx + dy * dy).sqrt()
      s += d * d
    }
    s
  }
  let r2 = if @core.approx_eq(ss_tot, 0.0, 0.000000000001) {
    1.0
  } else {
    1.0 - ss_res / ss_tot
  }
  Some({ cx, cy, radius, r_squared: r2, })
}

///|
/// Centroid (arithmetic mean) of a point set.
/// 点集质心（算术平均）。
pub fn centroid(points : Array[@core.Point2D]) -> @core.Point2D? {
  let n = points.length()
  if n == 0 {
    return None
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for p in points {
    sx += p.x()
    sy += p.y()
  }
  let nd = n.to_double()
  Some(@core.Point2D::new(sx / nd, sy / nd))
}
