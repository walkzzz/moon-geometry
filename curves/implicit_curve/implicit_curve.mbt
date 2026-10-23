///|
/// # Implicit Curve Tracing
/// # 隐式曲线追踪
///
/// Trace an implicit curve f(x, y) = 0 using a predictor-corrector (continuation) method.
/// 使用预测-校正（延拓）方法追踪隐式曲线 f(x, y) = 0。

///|
/// Trace an implicit curve starting from a seed point.
/// Uses tangent prediction followed by Newton correction along the normal.
/// 从种子点追踪隐式曲线，沿切线预测后沿法向牛顿校正。
///
/// # Arguments / 参数
/// - `f`: implicit function / 隐函数
/// - `fx`: partial derivative df/dx / 偏导数 df/dx
/// - `fy`: partial derivative df/dy / 偏导数 df/dy
/// - `seed`: starting point on (or near) the curve / 起点
/// - `step`: prediction step size / 预测步长
/// - `n_steps`: number of steps / 步数
pub fn trace_curve(
  f : (Double, Double) -> Double,
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  seed : @core.Point2D,
  step : Double,
  n_steps : Int32,
) -> Array[@core.Point2D] {
  let points : Array[@core.Point2D] = []
  let mut p = newton_correct(f, fx, fy, seed, 20)
  points.push(p)
  for _ in 0..<n_steps {
    let gx = fx(p.x(), p.y())
    let gy = fy(p.x(), p.y())
    let norm = (gx * gx + gy * gy).sqrt()
    if norm < 0.0000000001 {
      break
    }
    let tx = -gy / norm
    let ty = gx / norm
    let pred = @core.Point2D::new(p.x() + step * tx, p.y() + step * ty)
    p = newton_correct(f, fx, fy, pred, 20)
    points.push(p)
  }
  points
}

///|
/// Newton correction along the gradient to bring a point onto the curve.
/// 沿梯度牛顿校正将点拉回曲线上。
pub fn newton_correct(
  f : (Double, Double) -> Double,
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : @core.Point2D,
  max_iter : Int32,
) -> @core.Point2D {
  let mut x = p.x()
  let mut y = p.y()
  for _ in 0..<max_iter {
    let val = f(x, y)
    if val.abs() < 0.0000000001 {
      return @core.Point2D::new(x, y)
    }
    let gx = fx(x, y)
    let gy = fy(x, y)
    let grad_sq = gx * gx + gy * gy
    if grad_sq < 0.0000000001 {
      return @core.Point2D::new(x, y)
    }
    let lambda = val / grad_sq
    x -= lambda * gx
    y -= lambda * gy
  }
  @core.Point2D::new(x, y)
}

///|
/// Tangent direction at a point on the curve. / 曲线上一点处的切线方向。
pub fn tangent(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : @core.Point2D,
) -> @core.Point2D {
  let gx = fx(p.x(), p.y())
  let gy = fy(p.x(), p.y())
  let norm = (gx * gx + gy * gy).sqrt()
  if norm < 0.0000000001 {
    return @core.Point2D::new(1.0, 0.0)
  }
  @core.Point2D::new(-gy / norm, gx / norm)
}

///|
/// Unit normal at a point on the curve. / 曲线上一点处的单位法向量。
pub fn normal(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : @core.Point2D,
) -> @core.Point2D {
  let gx = fx(p.x(), p.y())
  let gy = fy(p.x(), p.y())
  let norm = (gx * gx + gy * gy).sqrt()
  if norm < 0.0000000001 {
    return @core.Point2D::new(0.0, 0.0)
  }
  @core.Point2D::new(gx / norm, gy / norm)
}

///|
/// Curvature of the implicit curve at a point.
/// kappa = (fxx*fy^2 - 2*fxy*fx*fy + fyy*fx^2) / (fx^2 + fy^2)^(3/2)
/// 隐式曲线在一点处的曲率。
pub fn curvature(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  fxx : (Double, Double) -> Double,
  fxy : (Double, Double) -> Double,
  fyy : (Double, Double) -> Double,
  p : @core.Point2D,
) -> Double {
  let x = p.x()
  let y = p.y()
  let a = fx(x, y)
  let b = fy(x, y)
  let aa = fxx(x, y)
  let ab = fxy(x, y)
  let bb = fyy(x, y)
  let denom = @math.pow(a * a + b * b, 1.5)
  if denom < 0.0000000001 {
    return 0.0
  }
  (aa * b * b - 2.0 * ab * a * b + bb * a * a) / denom
}

///|
/// Find a seed point on the curve by scanning a grid. / 通过网格扫描寻找曲线上的种子点。
pub fn find_seed(
  f : (Double, Double) -> Double,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  n_samples : Int32,
) -> @core.Point2D? {
  let dx = (x_hi - x_lo) / n_samples.to_double()
  let dy = (y_hi - y_lo) / n_samples.to_double()
  let mut x = x_lo
  while x < x_hi {
    let mut y = y_lo
    while y < y_hi {
      let v = f(x, y)
      if v.abs() < 0.01 {
        return Some(@core.Point2D::new(x, y))
      }
      y += dy
    }
    x += dx
  }
  None
}

///|
/// Trace the curve in both directions from a seed. / 从种子点向两个方向追踪曲线。
pub fn trace_both_directions(
  f : (Double, Double) -> Double,
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  seed : @core.Point2D,
  step : Double,
  n_steps : Int32,
) -> Array[@core.Point2D] {
  let forward = trace_curve(f, fx, fy, seed, step, n_steps)
  let backward = trace_curve(f, fx, fy, seed, -step, n_steps)
  let result : Array[@core.Point2D] = []
  let mut i = backward.length() - 1
  while i >= 0 {
    result.push(backward[i])
    i -= 1
  }
  for j in 1..<forward.length() {
    result.push(forward[j])
  }
  result
}
