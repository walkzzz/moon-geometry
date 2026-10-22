///|
/// # Dubins Curves
/// # Dubins 曲线
///
/// Shortest path for a car-like robot with minimum turning radius (forward only).
/// 前向行驶小车模型的最短路径（最小转弯半径约束）。
///
/// ## Complexity: O(1) for path computation
/// ## 复杂度: 路径计算 O(1)

///|
/// Dubins path segment type. / Dubins 路径段类型。
pub(all) enum DubinsSegmentType {
  Left
  Straight
  Right
}

///|
/// Dubins path segment. / Dubins 路径段。
pub struct DubinsSegment {
  seg_type : DubinsSegmentType
  length : Double
}

///|
/// Construct a Dubins segment. / 构造 Dubins 路径段。
pub fn DubinsSegment::new(seg_type : DubinsSegmentType, length : Double) -> DubinsSegment {
  { seg_type, length }
}

///|
/// Dubins path consisting of up to 3 segments. / Dubins 路径（最多 3 段）。
pub struct DubinsPath {
  segments : Array[DubinsSegment]
  total_length : Double
  radius : Double
}

///|
/// Construct a Dubins path. / 构造 Dubins 路径。
pub fn DubinsPath::new(
  segments : Array[DubinsSegment],
  total_length : Double,
  radius : Double,
) -> DubinsPath {
  { segments, total_length, radius }
}

///|
/// Pose (position + heading) for Dubins car. / Dubins 小车的位姿（位置 + 朝向）。
pub struct DubinsPose {
  x : Double
  y : Double
  theta : Double
}

///|
/// Construct a Dubins pose. / 构造 Dubins 位姿。
pub fn DubinsPose::new(x : Double, y : Double, theta : Double) -> DubinsPose {
  { x, y, theta }
}

fn normalize_angle(a : Double) -> Double {
  let two_pi = 6.283185307179586
  let mut result = a % two_pi
  if result < 0.0 {
    result += two_pi
  }
  result
}

fn mod2pi(a : Double) -> Double {
  normalize_angle(a)
}

///|
/// Compute the shortest Dubins path between two poses. / 计算两位姿间最短 Dubins 路径。
///
/// # Arguments / 参数
/// - `start`: start pose / 起始位姿
/// - `goal`: goal pose / 目标位姿
/// - `radius`: minimum turning radius / 最小转弯半径
pub fn dubins_shortest_path(
  start : DubinsPose,
  goal : DubinsPose,
  radius : Double,
) -> DubinsPath {
  let dx = (goal.x - start.x) / radius
  let dy = (goal.y - start.y) / radius
  let d = (dx * dx + dy * dy).sqrt()
  let phi = @math.atan2(dy, dx)
  let alpha = mod2pi(start.theta - phi)
  let beta = mod2pi(goal.theta - phi)
  let paths = dubins_all_words(alpha, beta, d)
  let mut best = paths[0]
  for i in 1..<paths.length() {
    if paths[i].total_length < best.total_length {
      best = paths[i]
    }
  }
  DubinsPath::new(best.segments, best.total_length, radius)
}

fn dubins_all_words(
  alpha : Double,
  beta : Double,
  d : Double,
) -> Array[DubinsPath] {
  let results : Array[DubinsPath] = []
  let r = dubins_LSL(alpha, beta, d)
  if r.total_length >= 0.0 {
    results.push(r)
  }
  let r2 = dubins_RSR(alpha, beta, d)
  if r2.total_length >= 0.0 {
    results.push(r2)
  }
  let r3 = dubins_LSR(alpha, beta, d)
  if r3.total_length >= 0.0 {
    results.push(r3)
  }
  let r4 = dubins_RSL(alpha, beta, d)
  if r4.total_length >= 0.0 {
    results.push(r4)
  }
  let r5 = dubins_RLR(alpha, beta, d)
  if r5.total_length >= 0.0 {
    results.push(r5)
  }
  let r6 = dubins_LRL(alpha, beta, d)
  if r6.total_length >= 0.0 {
    results.push(r6)
  }
  if results.length() == 0 {
    results.push(DubinsPath::new([], 0.0, 1.0))
  }
  results
}

fn dubins_LSL(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = d * d + 2.0 - 2.0 * @math.cos(alpha - beta) + 2.0 * d * (@math.sin(alpha) - @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(-alpha + @math.atan2(@math.cos(alpha) - @math.cos(beta), d + @math.sin(alpha) - @math.sin(beta)))
  let q = mod2pi(beta - @math.atan2(@math.cos(alpha) - @math.cos(beta), d + @math.sin(alpha) - @math.sin(beta)))
  let segs = [
    DubinsSegment::new(Left, t),
    DubinsSegment::new(Straight, p),
    DubinsSegment::new(Left, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

fn dubins_RSR(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = d * d + 2.0 - 2.0 * @math.cos(alpha - beta) - 2.0 * d * (@math.sin(alpha) - @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(alpha - @math.atan2(@math.cos(alpha) - @math.cos(beta), d - @math.sin(alpha) + @math.sin(beta)))
  let q = mod2pi(-beta + @math.atan2(@math.cos(alpha) - @math.cos(beta), d - @math.sin(alpha) + @math.sin(beta)))
  let segs = [
    DubinsSegment::new(Right, t),
    DubinsSegment::new(Straight, p),
    DubinsSegment::new(Right, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

fn dubins_LSR(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = -2.0 + d * d + 2.0 * @math.cos(alpha - beta) + 2.0 * d * (@math.sin(alpha) + @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(-alpha + @math.atan2(-@math.cos(alpha) - @math.cos(beta), d + @math.sin(alpha) + @math.sin(beta)) - @math.atan2(-2.0, p))
  let q = mod2pi(beta - @math.atan2(-@math.cos(alpha) - @math.cos(beta), d + @math.sin(alpha) + @math.sin(beta)) - @math.atan2(-2.0, p))
  let segs = [
    DubinsSegment::new(Left, t),
    DubinsSegment::new(Straight, p),
    DubinsSegment::new(Right, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

fn dubins_RSL(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = -2.0 + d * d + 2.0 * @math.cos(alpha - beta) - 2.0 * d * (@math.sin(alpha) + @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(alpha - @math.atan2(@math.cos(alpha) + @math.cos(beta), d - @math.sin(alpha) - @math.sin(beta)) - @math.atan2(2.0, p))
  let q = mod2pi(-beta + @math.atan2(@math.cos(alpha) + @math.cos(beta), d - @math.sin(alpha) - @math.sin(beta)) - @math.atan2(2.0, p))
  let segs = [
    DubinsSegment::new(Right, t),
    DubinsSegment::new(Straight, p),
    DubinsSegment::new(Left, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

fn dubins_RLR(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = 6.0 - d * d + 2.0 * @math.cos(alpha - beta) + 2.0 * d * (@math.sin(alpha) - @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(alpha - @math.atan2(@math.cos(alpha) - @math.cos(beta), d - @math.sin(alpha) + @math.sin(beta)) + p / 2.0)
  let q = mod2pi(alpha - beta - t + p)
  let segs = [
    DubinsSegment::new(Right, t),
    DubinsSegment::new(Left, p),
    DubinsSegment::new(Right, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

fn dubins_LRL(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = 6.0 - d * d + 2.0 * @math.cos(alpha - beta) - 2.0 * d * (@math.sin(alpha) - @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(-alpha + @math.atan2(-@math.cos(alpha) + @math.cos(beta), d + @math.sin(alpha) - @math.sin(beta)) + p / 2.0)
  let q = mod2pi(beta - alpha - t + p)
  let segs = [
    DubinsSegment::new(Left, t),
    DubinsSegment::new(Right, p),
    DubinsSegment::new(Left, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

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
  num_samples : Int,
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
    let seg_len = if remaining < seg.length {
      remaining
    } else {
      seg.length
    }
    let (dx, dy, dtheta) = match seg.seg_type {
      Left => {
        let r = radius
        let dth = seg_len / r
        (r * (@math.sin(theta + dth) - @math.sin(theta)), r * (-@math.cos(theta + dth) + @math.cos(theta)), dth)
      }
      Right => {
        let r = radius
        let dth = seg_len / r
        (r * (-@math.sin(theta - dth) + @math.sin(theta)), r * (@math.cos(theta - dth) - @math.cos(theta)), -dth)
      }
      Straight => {
        (seg_len * @math.cos(theta), seg_len * @math.sin(theta), 0.0)
      }
    }
    x += dx
    y += dy
    theta += dtheta
    remaining -= seg_len
  }
  (x, y, theta)
}

///|
/// Get the total length of a Dubins path. / 获取 Dubins 路径总长度。
pub fn dubins_path_length(path : DubinsPath) -> Double {
  path.total_length * path.radius
}

///|
/// Count segments in a Dubins path. / 统计 Dubins 路径段数。
pub fn dubins_segment_count(path : DubinsPath) -> Int {
  path.segments.length()
}