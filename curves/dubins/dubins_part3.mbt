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

///|
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

///|
fn dubins_LSL(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = d * d +
    2.0 -
    2.0 * @math.cos(alpha - beta) +
    2.0 * d * (@math.sin(alpha) - @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    -alpha +
    @math.atan2(
      @math.cos(alpha) - @math.cos(beta),
      d + @math.sin(alpha) - @math.sin(beta),
    ),
  )
  let q = mod2pi(
    beta -
    @math.atan2(
      @math.cos(alpha) - @math.cos(beta),
      d + @math.sin(alpha) - @math.sin(beta),
    ),
  )
  let segs = [
    DubinsSegment::new(Left, t),
    DubinsSegment::new(Straight, p),
    DubinsSegment::new(Left, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

///|
fn dubins_RSR(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = d * d +
    2.0 -
    2.0 * @math.cos(alpha - beta) -
    2.0 * d * (@math.sin(alpha) - @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    alpha -
    @math.atan2(
      @math.cos(alpha) - @math.cos(beta),
      d - @math.sin(alpha) + @math.sin(beta),
    ),
  )
  let q = mod2pi(
    -beta +
    @math.atan2(
      @math.cos(alpha) - @math.cos(beta),
      d - @math.sin(alpha) + @math.sin(beta),
    ),
  )
  let segs = [
    DubinsSegment::new(Right, t),
    DubinsSegment::new(Straight, p),
    DubinsSegment::new(Right, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

///|
fn dubins_LSR(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = -2.0 +
    d * d +
    2.0 * @math.cos(alpha - beta) +
    2.0 * d * (@math.sin(alpha) + @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    -alpha +
    @math.atan2(
      -@math.cos(alpha) - @math.cos(beta),
      d + @math.sin(alpha) + @math.sin(beta),
    ) -
    @math.atan2(-2.0, p),
  )
  let q = mod2pi(
    beta -
    @math.atan2(
      -@math.cos(alpha) - @math.cos(beta),
      d + @math.sin(alpha) + @math.sin(beta),
    ) -
    @math.atan2(-2.0, p),
  )
  let segs = [
    DubinsSegment::new(Left, t),
    DubinsSegment::new(Straight, p),
    DubinsSegment::new(Right, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

///|
fn dubins_RSL(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = -2.0 +
    d * d +
    2.0 * @math.cos(alpha - beta) -
    2.0 * d * (@math.sin(alpha) + @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    alpha -
    @math.atan2(
      @math.cos(alpha) + @math.cos(beta),
      d - @math.sin(alpha) - @math.sin(beta),
    ) -
    @math.atan2(2.0, p),
  )
  let q = mod2pi(
    -beta +
    @math.atan2(
      @math.cos(alpha) + @math.cos(beta),
      d - @math.sin(alpha) - @math.sin(beta),
    ) -
    @math.atan2(2.0, p),
  )
  let segs = [
    DubinsSegment::new(Right, t),
    DubinsSegment::new(Straight, p),
    DubinsSegment::new(Left, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

///|
fn dubins_RLR(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = 6.0 -
    d * d +
    2.0 * @math.cos(alpha - beta) +
    2.0 * d * (@math.sin(alpha) - @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    alpha -
    @math.atan2(
      @math.cos(alpha) - @math.cos(beta),
      d - @math.sin(alpha) + @math.sin(beta),
    ) +
    p / 2.0,
  )
  let q = mod2pi(alpha - beta - t + p)
  let segs = [
    DubinsSegment::new(Right, t),
    DubinsSegment::new(Left, p),
    DubinsSegment::new(Right, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}

///|
fn dubins_LRL(alpha : Double, beta : Double, d : Double) -> DubinsPath {
  let tmp = 6.0 -
    d * d +
    2.0 * @math.cos(alpha - beta) -
    2.0 * d * (@math.sin(alpha) - @math.sin(beta))
  if tmp < 0.0 {
    return DubinsPath::new([], -1.0, 1.0)
  }
  let p = tmp.sqrt()
  let t = mod2pi(
    -alpha +
    @math.atan2(
      -@math.cos(alpha) + @math.cos(beta),
      d + @math.sin(alpha) - @math.sin(beta),
    ) +
    p / 2.0,
  )
  let q = mod2pi(beta - alpha - t + p)
  let segs = [
    DubinsSegment::new(Left, t),
    DubinsSegment::new(Right, p),
    DubinsSegment::new(Left, q),
  ]
  DubinsPath::new(segs, t + p + q, 1.0)
}
