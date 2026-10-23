///| Construct a HoughCircle from center, radius, and votes. / 由圆心、半径与投票数构造 HoughCircle。
pub fn HoughCircle::new(
  cx : Double,
  cy : Double,
  radius : Double,
  votes : Int,
) -> HoughCircle {
  { cx, cy, radius, votes }
}

/// |
/// Detect lines in a point set using the Hough transform.
/// 使用霍夫变换检测点集中的直线。
///
/// # Arguments / 参数
/// - `pts`: input points / 输入点集
/// - `threshold`: minimum votes to accept a line / 接受直线的最小投票数
/// - `theta_steps`: number of theta discretization steps / theta 离散化步数
///
/// Returns detected lines sorted by votes descending.
/// 返回按投票数降序排列的检测直线。
pub fn hough_lines(
  pts : Array[@core.Point2D],
  threshold : Int,
  theta_steps : Int,
) -> Array[HoughLine] {
  if pts.length() < 2 {
    return []
  }
  let n = pts.length()
  let mut max_dist = 0.0
  for i in 0..<n {
    let d = (pts[i].x() * pts[i].x() + pts[i].y() * pts[i].y()).sqrt()
    if d > max_dist {
      max_dist = d
    }
  }
  let rho_range = max_dist * 2.0
  let rho_steps = theta_steps * 2
  let rho_min = -max_dist
  let theta_max = 3.141592653589793
  let accumulator : Array[Array[Int]] = Array::make(theta_steps, [])
  for i in 0..<theta_steps {
    accumulator[i] = Array::make(rho_steps, 0)
  }
  for i in 0..<n {
    let x = pts[i].x()
    let y = pts[i].y()
    for t in 0..<theta_steps {
      let theta = (t.to_double()) * theta_max / (theta_steps.to_double())
      let rho = x * @math.cos(theta) + y * @math.sin(theta)
      let rho_idx = (((rho - rho_min) / rho_range) * (rho_steps.to_double()))
        .to_int()
      if rho_idx >= 0 && rho_idx < rho_steps {
        accumulator[t][rho_idx] = accumulator[t][rho_idx] + 1
      }
    }
  }
  let lines : Array[HoughLine] = []
  for t in 0..<theta_steps {
    for r in 0..<rho_steps {
      if accumulator[t][r] >= threshold {
        let theta = (t.to_double()) * theta_max / (theta_steps.to_double())
        let rho = rho_min + (r.to_double()) * rho_range / (rho_steps.to_double())
        lines.push(HoughLine::new(theta, rho, accumulator[t][r]))
      }
    }
  }
  lines.sort_by(fn(a, b) { b.votes - a.votes })
  lines
}

/// |
/// Detect circles in a point set using the Hough transform.
/// 使用霍夫变换检测点集中的圆。
///
/// # Arguments / 参数
/// - `pts`: input points / 输入点集
/// - `radius`: expected circle radius / 期望圆半径
/// - `threshold`: minimum votes / 最小投票数
/// - `resolution`: accumulator grid resolution / 累加器网格分辨率
///
/// Returns detected circles sorted by votes descending.
/// 返回按投票数降序排列的检测圆。
pub fn hough_circles(
  pts : Array[@core.Point2D],
  radius : Double,
  threshold : Int,
  resolution : Int,
) -> Array[HoughCircle] {
  if pts.length() < 3 || radius <= 0.0 {
    return []
  }
  let n = pts.length()
  let mut min_x = 0.0
  let mut max_x = 0.0
  let mut min_y = 0.0
  let mut max_y = 0.0
  for i in 0..<n {
    let x = pts[i].x()
    let y = pts[i].y()
    if i == 0 {
      min_x = x
      max_x = x
      min_y = y
      max_y = y
    } else {
      if x < min_x {
        min_x = x
      }
      if x > max_x {
        max_x = x
      }
      if y < min_y {
        min_y = y
      }
      if y > max_y {
        max_y = y
      }
    }
  }
  let width = max_x - min_x + radius * 2.0
  let height = max_y - min_y + radius * 2.0
  let cell_w = width / (resolution.to_double())
  let cell_h = height / (resolution.to_double())
  let accumulator : Array[Array[Int]] = Array::make(resolution, [])
  for i in 0..<resolution {
    accumulator[i] = Array::make(resolution, 0)
  }
  let theta_steps = 60
  for i in 0..<n {
    let x = pts[i].x()
    let y = pts[i].y()
    for t in 0..<theta_steps {
      let theta = (t.to_double()) * 6.283185307179586 / (theta_steps.to_double())
      let cx = x - radius * @math.cos(theta)
      let cy = y - radius * @math.sin(theta)
      let cx_idx = (((cx - min_x + radius) / cell_w)).to_int()
      let cy_idx = (((cy - min_y + radius) / cell_h)).to_int()
      if cx_idx >= 0 && cx_idx < resolution && cy_idx >= 0 &&
        cy_idx < resolution {
        accumulator[cx_idx][cy_idx] = accumulator[cx_idx][cy_idx] + 1
      }
    }
  }
  let circles : Array[HoughCircle] = []
  for i in 0..<resolution {
    for j in 0..<resolution {
      if accumulator[i][j] >= threshold {
        let cx = min_x - radius + (i.to_double()) * cell_w + cell_w / 2.0
        let cy = min_y - radius + (j.to_double()) * cell_h + cell_h / 2.0
        circles.push(HoughCircle::new(cx, cy, radius, accumulator[i][j]))
      }
    }
  }
  circles.sort_by(fn(a, b) { b.votes - a.votes })
  circles
}

/// |
/// Build a Hough accumulator for line detection.
/// 构建直线检测的霍夫累加器。
///
/// Returns 2D accumulator array [theta_idx][rho_idx].
/// 返回二维累加器数组 [theta_idx][rho_idx]。
pub fn hough_accumulator(
  pts : Array[@core.Point2D],
  theta_steps : Int,
  rho_steps : Int,
) -> Array[Array[Int]] {
  let n = pts.length()
  let mut max_dist = 0.0
  for i in 0..<n {
    let d = (pts[i].x() * pts[i].x() + pts[i].y() * pts[i].y()).sqrt()
    if d > max_dist {
      max_dist = d
    }
  }
  let rho_range = max_dist * 2.0
  let rho_min = -max_dist
  let theta_max = 3.141592653589793
  let accumulator : Array[Array[Int]] = Array::make(theta_steps, [])
  for i in 0..<theta_steps {
    accumulator[i] = Array::make(rho_steps, 0)
  }
  for i in 0..<n {
    let x = pts[i].x()
    let y = pts[i].y()
    for t in 0..<theta_steps {
      let theta = (t.to_double()) * theta_max / (theta_steps.to_double())
      let rho = x * @math.cos(theta) + y * @math.sin(theta)
      let rho_idx = (((rho - rho_min) / rho_range) * (rho_steps.to_double()))
        .to_int()
      if rho_idx >= 0 && rho_idx < rho_steps {
        accumulator[t][rho_idx] = accumulator[t][rho_idx] + 1
      }
    }
  }
  accumulator
}

/// |
/// Find peaks in a Hough accumulator.
/// 在霍夫累加器中寻找峰值。
///
/// # Arguments / 参数
/// - `accumulator`: 2D Hough accumulator / 二维霍夫累加器
/// - `threshold`: minimum vote count / 最小投票数
/// - `window`: non-maximum suppression window size / 非极大值抑制窗口大小
///
/// Returns (theta_idx, rho_idx, votes) tuples sorted by votes descending.
/// 返回 (theta_idx, rho_idx, votes) 元组，按投票数降序排列。
pub fn hough_peaks(
  accumulator : Array[Array[Int]],
  threshold : Int,
  window : Int,
) -> Array[(Int, Int, Int)] {
  let theta_steps = accumulator.length()
  if theta_steps == 0 {
    return []
  }
  let rho_steps = accumulator[0].length()
  let peaks : Array[(Int, Int, Int)] = []
  let half = window / 2
  for t in 0..<theta_steps {
    for r in 0..<rho_steps {
      let val = accumulator[t][r]
      if val < threshold {
        continue
      }
      let mut is_peak = true
      let t_start = if t - half < 0 { 0 } else { t - half }
      let t_end = if t + half >= theta_steps { theta_steps } else { t + half + 1 }
      let r_start = if r - half < 0 { 0 } else { r - half }
      let r_end = if r + half >= rho_steps { rho_steps } else { r + half + 1 }
      for dt in t_start..<t_end {
        for dr in r_start..<r_end {
          if accumulator[dt][dr] > val {
            is_peak = false
          }
        }
      }
      if is_peak {
        peaks.push((t, r, val))
      }
    }
  }
  peaks.sort_by(fn(a, b) {
    let (_, _, va) = a
    let (_, _, vb) = b
    vb - va
  })
  peaks
}

/// |
/// Convert a Hough line (theta, rho) to two endpoint points.
/// 将霍夫直线（theta, rho）转换为两个端点。
///
/// # Arguments / 参数
/// - `theta`: angle in radians / 角度（弧度）
/// - `rho`: distance from origin / 到原点距离
/// - `length`: desired line segment length / 所需线段长度
pub fn hough_line_to_points(
  theta : Double,
  rho : Double,
  length : Double,
) -> (@core.Point2D, @core.Point2D) {
  let ct = @math.cos(theta)
  let st = @math.sin(theta)
  let x0 = rho * ct
  let y0 = rho * st
  let dx = -st * length / 2.0
  let dy = ct * length / 2.0
  (@core.Point2D::new(x0 - dx, y0 - dy), @core.Point2D::new(x0 + dx, y0 + dy))
}