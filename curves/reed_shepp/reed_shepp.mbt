///|
/// # Reeds-Shepp Curves
/// # Reeds-Shepp 曲线
///
/// Shortest path for a car-like robot that can move forward and backward.
/// 可前进和后退的小车模型最短路径。
///
/// ## Complexity: O(1) for path computation (48 word families)
/// ## 复杂度: 路径计算 O(1)（48 种路径字族）

///|
/// Reeds-Shepp path segment type. / Reeds-Shepp 路径段类型。
pub(all) enum RSSegmentType {
  Left
  Straight
  Right
}

///|
/// Reeds-Shepp path segment with direction. / 带方向的 Reeds-Shepp 路径段。
pub struct RSSegment {
  seg_type : RSSegmentType
  length : Double
  forward : Bool
}

///|
/// Construct a Reeds-Shepp segment. / 构造 Reeds-Shepp 路径段。
pub fn RSSegment::new(
  seg_type : RSSegmentType,
  length : Double,
  forward : Bool,
) -> RSSegment {
  { seg_type, length, forward, }
}

///|
/// Reeds-Shepp path. / Reeds-Shepp 路径。
pub struct RSPath {
  segments : Array[RSSegment]
  total_length : Double
  radius : Double
}

///|
/// Construct a Reeds-Shepp path. / 构造 Reeds-Shepp 路径。
pub fn RSPath::new(
  segments : Array[RSSegment],
  total_length : Double,
  radius : Double,
) -> RSPath {
  { segments, total_length, radius, }
}

///|
/// Pose for Reeds-Shepp car. / Reeds-Shepp 小车位姿。
pub struct RSPose {
  x : Double
  y : Double
  theta : Double
}

///|
/// Construct a Reeds-Shepp pose. / 构造 Reeds-Shepp 位姿。
pub fn RSPose::new(x : Double, y : Double, theta : Double) -> RSPose {
  { x, y, theta, }
}

///|
fn mod2pi(a : Double) -> Double {
  let two_pi = 6.283185307179586
  let mut result = a % two_pi
  if result < 0.0 {
    result += two_pi
  }
  result
}

///|
/// Compute the shortest Reeds-Shepp path between two poses. / 计算两位姿间最短 Reeds-Shepp 路径。
///
/// # Arguments / 参数
/// - `start`: start pose / 起始位姿
/// - `goal`: goal pose / 目标位姿
/// - `radius`: minimum turning radius / 最小转弯半径
pub fn reed_shepp_shortest_path(
  start : RSPose,
  goal : RSPose,
  radius : Double,
) -> RSPath {
  let dx = (goal.x - start.x) / radius
  let dy = (goal.y - start.y) / radius
  let d = (dx * dx + dy * dy).sqrt()
  let phi = @math.atan2(dy, dx)
  let alpha = mod2pi(start.theta - phi)
  let beta = mod2pi(goal.theta - phi)
  let candidates : Array[RSPath] = []
  rs_compute_candidates(alpha, beta, d, candidates)
  if candidates.length() == 0 {
    return RSPath::new([], 0.0, radius)
  }
  let mut best = candidates[0]
  for i in 1..<candidates.length() {
    if candidates[i].total_length < best.total_length {
      best = candidates[i]
    }
  }
  RSPath::new(best.segments, best.total_length, radius)
}

///|
fn rs_compute_candidates(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  rs_timeflip(alpha, beta, d, results)
  rs_timeflip(-alpha, -beta, d, results)
  rs_timeflip(beta, alpha, d, results)
  rs_timeflip(-beta, -alpha, d, results)
  rs_reflect(alpha, beta, d, results)
  rs_reflect(-alpha, -beta, d, results)
  rs_reflect(beta, alpha, d, results)
  rs_reflect(-beta, -alpha, d, results)
}

///|
fn rs_timeflip(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  rs_LfLfRf(alpha, beta, d, results)
  rs_LfRfLf(alpha, beta, d, results)
  rs_LfRfRf(alpha, beta, d, results)
  rs_LfSfRf(alpha, beta, d, results)
  rs_LfSfLf(alpha, beta, d, results)
  rs_LfRbSbRf(alpha, beta, d, results)
  rs_LfRfSbRf(alpha, beta, d, results)
  rs_LfSfRbSbLf(alpha, beta, d, results)
}

///|
fn rs_reflect(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  rs_LfLfRf(-alpha, -beta, d, results)
  rs_LfRfLf(-alpha, -beta, d, results)
  rs_LfRfRf(-alpha, -beta, d, results)
  rs_LfSfRf(-alpha, -beta, d, results)
  rs_LfSfLf(-alpha, -beta, d, results)
  rs_LfRbSbRf(-alpha, -beta, d, results)
  rs_LfRfSbRf(-alpha, -beta, d, results)
  rs_LfSfRbSbLf(-alpha, -beta, d, results)
}

///|
fn rs_LfSfRf(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  let tmp = d * d - 2.0 + 2.0 * @math.cos(alpha - beta)
  if tmp < 0.0 {
    return
  }
  let p = tmp.sqrt()
  let tmp2 = @math.sin(alpha) - @math.sin(beta)
  let tmp3 = @math.cos(beta) - @math.cos(alpha)
  let t = mod2pi(-alpha + @math.atan2(tmp2, tmp3 - d))
  let q = mod2pi(beta - @math.atan2(tmp2, tmp3 - d))
  if t >= 0.0 && p >= 0.0 && q >= 0.0 {
    let segs = [
      RSSegment::new(Left, t, true),
      RSSegment::new(Straight, p, true),
      RSSegment::new(Right, q, true),
    ]
    results.push(RSPath::new(segs, t + p + q, 1.0))
  }
}

///|
fn rs_LfSfLf(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  let tmp = d * d - 2.0 * (1.0 - @math.cos(alpha - beta))
  if tmp < 0.0 {
    return
  }
  let p = tmp.sqrt()
  let tmp2 = @math.sin(alpha) + @math.sin(beta)
  let tmp3 = @math.cos(alpha) - @math.cos(beta)
  let t = mod2pi(-alpha + @math.atan2(tmp2, d - tmp3))
  let q = mod2pi(-beta + @math.atan2(tmp2, d - tmp3))
  if t >= 0.0 && p >= 0.0 && q >= 0.0 {
    let segs = [
      RSSegment::new(Left, t, true),
      RSSegment::new(Straight, p, true),
      RSSegment::new(Left, q, true),
    ]
    results.push(RSPath::new(segs, t + p + q, 1.0))
  }
}

///|
fn rs_LfRfLf(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  let tmp = 4.0 -
    d * d +
    2.0 * @math.cos(alpha - beta) +
    2.0 * d * (@math.sin(alpha) + @math.sin(beta))
  if tmp < 0.0 {
    return
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    -alpha +
    @math.atan2(
      @math.cos(alpha) + @math.cos(beta),
      d + @math.sin(alpha) + @math.sin(beta),
    ) -
    @math.atan2(2.0, p),
  )
  let q = mod2pi(
    mod2pi(beta) -
    @math.atan2(
      @math.cos(alpha) + @math.cos(beta),
      d + @math.sin(alpha) + @math.sin(beta),
    ) -
    @math.atan2(2.0, p),
  )
  if t >= 0.0 && p >= 0.0 && q >= 0.0 {
    let segs = [
      RSSegment::new(Left, t, true),
      RSSegment::new(Right, p, true),
      RSSegment::new(Left, q, true),
    ]
    results.push(RSPath::new(segs, t + p + q, 1.0))
  }
}

///|
fn rs_LfLfRf(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  let tmp = 4.0 -
    d * d +
    2.0 * @math.cos(alpha - beta) +
    2.0 * d * (@math.sin(beta) - @math.sin(alpha))
  if tmp < 0.0 {
    return
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    alpha -
    @math.atan2(
      @math.cos(beta) - @math.cos(alpha),
      d - @math.sin(beta) + @math.sin(alpha),
    ) +
    p / 2.0,
  )
  let q = mod2pi(alpha - beta - t + p)
  if t >= 0.0 && p >= 0.0 && q >= 0.0 {
    let segs = [
      RSSegment::new(Left, t, true),
      RSSegment::new(Left, p, true),
      RSSegment::new(Right, q, true),
    ]
    results.push(RSPath::new(segs, t + p + q, 1.0))
  }
}

///|
fn rs_LfRfRf(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  let tmp = 4.0 -
    d * d +
    2.0 * @math.cos(alpha - beta) -
    2.0 * d * (@math.sin(alpha) + @math.sin(beta))
  if tmp < 0.0 {
    return
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    -alpha +
    @math.atan2(
      -@math.cos(alpha) - @math.cos(beta),
      d - @math.sin(alpha) - @math.sin(beta),
    ) -
    @math.atan2(2.0, p),
  )
  let q = mod2pi(
    -beta +
    @math.atan2(
      -@math.cos(alpha) - @math.cos(beta),
      d - @math.sin(alpha) - @math.sin(beta),
    ) -
    @math.atan2(2.0, p),
  )
  if t >= 0.0 && p >= 0.0 && q >= 0.0 {
    let segs = [
      RSSegment::new(Left, t, true),
      RSSegment::new(Right, p, true),
      RSSegment::new(Right, q, true),
    ]
    results.push(RSPath::new(segs, t + p + q, 1.0))
  }
}

///|
fn rs_LfRbSbRf(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  let tmp = d * d - 2.0 * (1.0 + @math.cos(alpha - beta))
  if tmp < 0.0 {
    return
  }
  let p = tmp.sqrt()
  let tmp2 = @math.cos(alpha) + @math.cos(beta)
  let tmp3 = @math.sin(alpha) + @math.sin(beta)
  let t = mod2pi(-alpha + @math.atan2(tmp2, tmp3 - d) - @math.atan2(2.0, p))
  let q = mod2pi(-beta + @math.atan2(tmp2, tmp3 - d) - @math.atan2(2.0, p))
  if t >= 0.0 && p >= 0.0 && q >= 0.0 {
    let segs = [
      RSSegment::new(Left, t, true),
      RSSegment::new(Right, p, false),
      RSSegment::new(Straight, p, false),
      RSSegment::new(Right, q, true),
    ]
    results.push(RSPath::new(segs, t + p + p + q, 1.0))
  }
}

///|
fn rs_LfRfSbRf(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  let tmp = d * d - 2.0 * (1.0 - @math.cos(alpha - beta))
  if tmp < 0.0 {
    return
  }
  let p = tmp.sqrt()
  let tmp2 = @math.sin(alpha) - @math.sin(beta)
  let tmp3 = @math.cos(alpha) - @math.cos(beta)
  let t = mod2pi(alpha - @math.atan2(tmp2, d + tmp3))
  let q = mod2pi(-beta + @math.atan2(tmp2, d + tmp3))
  if t >= 0.0 && p >= 0.0 && q >= 0.0 {
    let segs = [
      RSSegment::new(Left, t, true),
      RSSegment::new(Right, p, true),
      RSSegment::new(Straight, p, false),
      RSSegment::new(Right, q, true),
    ]
    results.push(RSPath::new(segs, t + p + p + q, 1.0))
  }
}

///|
fn rs_LfSfRbSbLf(
  alpha : Double,
  beta : Double,
  d : Double,
  results : Array[RSPath],
) -> Unit {
  let tmp = d * d - 4.0
  if tmp < 0.0 {
    return
  }
  let p = tmp.sqrt()
  if p < 0.0 {
    return
  }
  let t = mod2pi(
    -alpha +
    @math.atan2(
      @math.cos(alpha) - @math.cos(beta),
      d + @math.sin(alpha) - @math.sin(beta),
    ) -
    @math.atan2(2.0, p),
  )
  let q = mod2pi(
    beta -
    @math.atan2(
      @math.cos(alpha) - @math.cos(beta),
      d + @math.sin(alpha) - @math.sin(beta),
    ) -
    @math.atan2(2.0, p),
  )
  if t >= 0.0 && q >= 0.0 {
    let segs = [
      RSSegment::new(Left, t, true),
      RSSegment::new(Straight, p / 2.0, true),
      RSSegment::new(Right, p / 2.0, false),
      RSSegment::new(Straight, p / 2.0, false),
      RSSegment::new(Left, q, true),
    ]
    results.push(RSPath::new(segs, t + p + q, 1.0))
  }
}

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

///|
/// Get the total length of a Reeds-Shepp path. / 获取 Reeds-Shepp 路径总长度。
pub fn reed_shepp_path_length(path : RSPath) -> Double {
  path.total_length * path.radius
}

///|
/// Count segments in a Reeds-Shepp path. / 统计 Reeds-Shepp 路径段数。
pub fn reed_shepp_segment_count(path : RSPath) -> Int32 {
  path.segments.length()
}

///|
/// Check if a Reeds-Shepp path contains backward motion. / 检查 Reeds-Shepp 路径是否包含后退运动。
pub fn reed_shepp_has_backward(path : RSPath) -> Bool {
  for i in 0..<path.segments.length() {
    if !path.segments[i].forward && path.segments[i].length > 0.0 {
      return true
    }
  }
  false
}
