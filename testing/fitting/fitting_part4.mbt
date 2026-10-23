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
