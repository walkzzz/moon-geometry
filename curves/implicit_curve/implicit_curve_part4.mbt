///|
/// Find a seed point on the curve by scanning a grid. / 通过网格扫描寻找曲线上的种子点。
pub fn find_seed(
  f : (Double, Double) -> Double,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  n_samples : Int,
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
  n_steps : Int,
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