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
