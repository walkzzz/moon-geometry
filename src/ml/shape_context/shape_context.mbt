///|
/// # Shape Context Descriptor
/// # 形状上下文描述子
///
/// Log-polar histogram of relative point positions around each point.
/// 每个点周围相对点位置的极对数直方图。
///
/// ## Complexity: O(n^2 * (r_bins * theta_bins))
/// ## 复杂度: O(n^2 * (r_bins * theta_bins))

///|
/// Natural log helper using log2. / 使用 log2 的自然对数辅助函数。
fn ln(x : Double) -> Double {
  @math.log2(x) * 0.6931471805599453
}

///|
/// Compute shape context descriptors for all points.
/// 为所有点计算形状上下文描述子。
///
/// # Arguments / 参数
/// - `points`: boundary points / 边界点
/// - `n_r_bins`: number of log-radius bins / 极径箱数
/// - `n_theta_bins`: number of angle bins / 角度箱数
///
/// Returns a histogram (flattened r_bins * theta_bins) per point.
/// 返回每个点的直方图（展平为 r_bins * theta_bins）。
pub fn shape_context(
  points : Array[@core.Point2D],
  n_r_bins : Int,
  n_theta_bins : Int,
) -> Array[Array[Double]] {
  let n = points.length()
  let result : Array[Array[Double]] = []
  if n == 0 || n_r_bins <= 0 || n_theta_bins <= 0 {
    return result
  }
  let two_pi = 6.283185307179586
  let mut r_min = 1.7976931348623157e+308
  let mut r_max = 0.0
  for i in 0..<n {
    for j in 0..<n {
      if i != j {
        let d = points[i].dist(points[j])
        if d > 0.000000000001 {
          if d < r_min {
            r_min = d
          }
          if d > r_max {
            r_max = d
          }
        }
      }
    }
  }
  if r_max <= r_min {
    r_max = r_min * 2.0
  }
  let log_min = ln(r_min)
  let log_max = ln(r_max)
  let bin_width = (log_max - log_min) / n_r_bins.to_double()
  if bin_width < 0.000000000001 {
    for _ in 0..<n {
      result.push(Array::make(n_r_bins * n_theta_bins, 0.0))
    }
    return result
  }
  for i in 0..<n {
    let hist : Array[Double] = Array::make(n_r_bins * n_theta_bins, 0.0)
    for j in 0..<n {
      if i == j {
        continue
      }
      let dx = points[j].x() - points[i].x()
      let dy = points[j].y() - points[i].y()
      let r = (dx * dx + dy * dy).sqrt()
      if r < 0.000000000001 {
        continue
      }
      let theta = @math.atan2(dy, dx)
      let theta_norm = if theta < 0.0 { theta + two_pi } else { theta }
      let log_r = ln(r)
      let r_idx_raw = ((log_r - log_min) / bin_width).to_int()
      let r_idx = if r_idx_raw < 0 {
        0
      } else if r_idx_raw >= n_r_bins {
        n_r_bins - 1
      } else {
        r_idx_raw
      }
      let theta_idx_raw = (theta_norm / two_pi * n_theta_bins.to_double()).to_int()
      let theta_idx = if theta_idx_raw >= n_theta_bins {
        n_theta_bins - 1
      } else {
        theta_idx_raw
      }
      let idx = r_idx * n_theta_bins + theta_idx
      hist[idx] = hist[idx] + 1.0
    }
    let mut total = 0.0
    for v in hist {
      total += v
    }
    if total > 0.000000000001 {
      for k in 0..<(n_r_bins * n_theta_bins) {
        hist[k] = hist[k] / total
      }
    }
    result.push(hist)
  }
  result
}

///|
/// Chi-square distance between two shape context histograms.
/// 两个形状上下文直方图间的卡方距离。
pub fn shape_context_distance(
  h1 : Array[Double],
  h2 : Array[Double],
) -> Double {
  let n = h1.length()
  let m = h2.length()
  let len = if n < m { n } else { m }
  let mut dist = 0.0
  for i in 0..<len {
    let sum = h1[i] + h2[i]
    if sum > 0.000000000001 {
      let diff = h1[i] - h2[i]
      dist += diff * diff / sum
    }
  }
  dist / 2.0
}

///|
/// Cost matrix between two sets of shape context descriptors.
/// 两组形状上下文描述子之间的代价矩阵。
pub fn shape_context_cost(
  sc1 : Array[Array[Double]],
  sc2 : Array[Array[Double]],
) -> Array[Array[Double]] {
  let n = sc1.length()
  let m = sc2.length()
  let cost : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<m {
      row.push(shape_context_distance(sc1[i], sc2[j]))
    }
    cost.push(row)
  }
  cost
}

///|
/// Greedy shape context matching: for each source point find best target.
/// 贪心形状上下文匹配：为每个源点找最佳目标点。
///
/// Returns array of target indices for each source point.
/// 返回每个源点对应的目标点索引。
pub fn shape_context_match(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
  n_r_bins : Int,
  n_theta_bins : Int,
) -> Array[Int] {
  let sc1 = shape_context(source, n_r_bins, n_theta_bins)
  let sc2 = shape_context(target, n_r_bins, n_theta_bins)
  let result : Array[Int] = []
  for i in 0..<sc1.length() {
    let mut best_idx = 0
    let mut best_d = 1.7976931348623157e+308
    for j in 0..<sc2.length() {
      let d = shape_context_distance(sc1[i], sc2[j])
      if d < best_d {
        best_d = d
        best_idx = j
      }
    }
    result.push(best_idx)
  }
  result
}