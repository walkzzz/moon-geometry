///|
/// Sample points along a Reeds-Shepp path. / 沿 Reeds-Shepp 路径采样点。
pub fn reed_shepp_sample(
  path : RSPath,
  start : RSPose,
  num_samples : Int32,
) -> Array[@core.Point2D] {
  let points : Array[@core.Point2D] = []
  if num_samples <= 0 || path.total_length <= 0.0 {
    return points
  }
  let r = path.radius
  for i in 0..<num_samples {
    let t = path.total_length * i.to_double() / (num_samples - 1).to_double()
    let (x, y, _) = rs_sample_at(path, start, t, r)
    points.push(@core.Point2D::new(x, y))
  }
  points
}

///|
fn rs_sample_at(
  path : RSPath,
  start : RSPose,
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
    let dir = if seg.forward { 1.0 } else { -1.0 }
    let (dx, dy, dtheta) = match seg.seg_type {
      Left => {
        let r = radius
        let dth = seg_len / r * dir
        (
          r * (@math.sin(theta + dth) - @math.sin(theta)),
          r * (-@math.cos(theta + dth) + @math.cos(theta)),
          dth,
        )
      }
      Right => {
        let r = radius
        let dth = seg_len / r * dir
        (
          r * (-@math.sin(theta - dth) + @math.sin(theta)),
          r * (@math.cos(theta - dth) - @math.cos(theta)),
          -dth,
        )
      }
      Straight =>
        (
          seg_len * @math.cos(theta) * dir,
          seg_len * @math.sin(theta) * dir,
          0.0,
        )
    }
    x += dx
    y += dy
    theta += dtheta
    remaining -= seg_len
  }
  (x, y, theta)
}
