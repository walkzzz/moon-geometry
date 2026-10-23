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
  n_steps : Int,
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
