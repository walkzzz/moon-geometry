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
