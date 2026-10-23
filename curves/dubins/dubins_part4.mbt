///|
/// Sample points along a Dubins path. / 沿 Dubins 路径采样点。
///
/// # Arguments / 参数
/// - `path`: the Dubins path / Dubins 路径
/// - `start`: start pose / 起始位姿
/// - `num_samples`: number of sample points / 采样点数
pub fn dubins_sample(
  path : DubinsPath,
  start : DubinsPose,
  num_samples : Int32,
) -> Array[@core.Point2D] {
  let points : Array[@core.Point2D] = []
  if num_samples <= 0 || path.total_length <= 0.0 {
    return points
  }
  let r = path.radius
  for i in 0..<num_samples {
    let t = path.total_length * i.to_double() / (num_samples - 1).to_double()
    let (x, y, _) = dubins_sample_at(path, start, t, r)
    points.push(@core.Point2D::new(x, y))
  }
  points
}

///|
fn dubins_sample_at(
  path : DubinsPath,
  start : DubinsPose,
  s : Double,
  radius : Double,
) -> (Double, Double, Double) {
  let mut x = start.x
  let mut y = start.y
  let mut theta = start.theta
  let mut remaining = s
  for i in 0..<path.segments.length() {
    if remaining <= 0.0 {
      break
    }
    let seg = path.segments[i]
    let seg_len = if remaining < seg.length { remaining } else { seg.length }
    let (dx, dy, dtheta) = match seg.seg_type {
      Left => {
        let r = radius
        let dth = seg_len / r
        (
          r * (@math.sin(theta + dth) - @math.sin(theta)),
          r * (-@math.cos(theta + dth) + @math.cos(theta)),
          dth,
        )
      }
      Right => {
        let r = radius
        let dth = seg_len / r
        (
          r * (-@math.sin(theta - dth) + @math.sin(theta)),
          r * (@math.cos(theta - dth) - @math.cos(theta)),
          -dth,
        )
      }
      Straight => (seg_len * @math.cos(theta), seg_len * @math.sin(theta), 0.0)
    }
    x += dx
    y += dy
    theta += dtheta
    remaining -= seg_len
  }
  (x, y, theta)
}
