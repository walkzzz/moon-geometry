///|
/// # Fractal Dimension
/// # 分形维数
///
/// Box-counting and correlation dimension estimation from point sets.
/// 从点集估计盒计数维数与相关维数。

///|
/// Box-counting dimension via least-squares fit of log(N(eps)) vs log(1/eps).
/// 通过对 log(N(eps)) 与 log(1/eps) 最小二乘拟合估计盒计数维数。
///
/// # Arguments / 参数
/// - `points`: the fractal point set / 分形点集
/// - `scales`: array of box sizes to sample / 采样盒尺寸数组
pub fn box_counting_dimension(
  points : Array[@core.Point2D],
  scales : Array[Double],
) -> Double {
  if points.length() == 0 || scales.length() < 2 {
    return 0.0
  }
  let xs : Array[Double] = []
  let ys : Array[Double] = []
  for eps in scales {
    if eps <= 0.0 {
      continue
    }
    let count = count_boxes(points, eps)
    if count > 0 {
      xs.push(@math.ln(1.0 / eps))
      ys.push(@math.ln(count.to_double()))
    }
  }
  if xs.length() < 2 {
    return 0.0
  }
  linear_fit_slope(xs, ys)
}

fn count_boxes(points : Array[@core.Point2D], eps : Double) -> Int {
  let keys : Array[Int] = []
  for p in points {
    let ix = (p.x() / eps).floor().to_int()
    let iy = (p.y() / eps).floor().to_int()
    keys.push(ix * 1000003 + iy)
  }
  keys.sort()
  let mut count = 0
  let mut prev = 0
  let mut first = true
  for k in keys {
    if first {
      count = 1
      prev = k
      first = false
    } else if k != prev {
      count += 1
      prev = k
    }
  }
  count
}

///|
/// Correlation dimension via the Grassberger-Procaccia approach.
/// C(r) = (2/N^2) * sum_{i<j} H(r - |x_i - x_j|)
/// Dimension = slope of log(C(r)) vs log(r).
/// 通过 Grassberger-Procaccia 方法估计相关维数。
pub fn correlation_dimension(
  points : Array[@core.Point2D],
  radii : Array[Double],
) -> Double {
  let n = points.length()
  if n < 2 || radii.length() < 2 {
    return 0.0
  }
  let xs : Array[Double] = []
  let ys : Array[Double] = []
  for r in radii {
    if r <= 0.0 {
      continue
    }
    let mut count = 0.0
    for i in 0..<n {
      for j in (i + 1)..<n {
        let d = points[i].dist(points[j])
        if d <= r {
          count += 1.0
        }
      }
    }
    let c_r = 2.0 * count / (n.to_double() * n.to_double())
    if c_r > 0.0 {
      xs.push(@math.ln(r))
      ys.push(@math.ln(c_r))
    }
  }
  if xs.length() < 2 {
    return 0.0
  }
  linear_fit_slope(xs, ys)
}

///|
/// Least-squares slope of y vs x. / y 对 x 的最小二乘拟合斜率。
pub fn linear_fit_slope(xs : Array[Double], ys : Array[Double]) -> Double {
  let n = xs.length()
  if n < 2 {
    return 0.0
  }
  let mut sx = 0.0
  let mut sy = 0.0
  let mut sxx = 0.0
  let mut sxy = 0.0
  for i in 0..<n {
    sx += xs[i]
    sy += ys[i]
    sxx += xs[i] * xs[i]
    sxy += xs[i] * ys[i]
  }
  let nd = n.to_double()
  let denom = nd * sxx - sx * sx
  if denom.abs() < 0.0000000001 {
    return 0.0
  }
  (nd * sxy - sx * sy) / denom
}

///|
/// Information dimension (entropy-based) from box probabilities.
/// 基于熵的信息维数。
pub fn information_dimension(
  points : Array[@core.Point2D],
  scales : Array[Double],
) -> Double {
  let n = points.length()
  if n == 0 || scales.length() < 2 {
    return 0.0
  }
  let xs : Array[Double] = []
  let ys : Array[Double] = []
  for eps in scales {
    if eps <= 0.0 {
      continue
    }
    let keys : Array[Int] = []
    for p in points {
      let ix = (p.x() / eps).floor().to_int()
      let iy = (p.y() / eps).floor().to_int()
      keys.push(ix * 1000003 + iy)
    }
    keys.sort()
    let counts : Array[Int] = []
    let mut prev = 0
    let mut first = true
    let mut run = 0
    for k in keys {
      if first {
        prev = k
        run = 1
        first = false
      } else if k == prev {
        run += 1
      } else {
        counts.push(run)
        prev = k
        run = 1
      }
    }
    if !first {
      counts.push(run)
    }
    let mut entropy = 0.0
    for c in counts {
      let prob = c.to_double() / n.to_double()
      if prob > 0.0 {
        entropy -= prob * @math.ln(prob)
      }
    }
    if entropy > 0.0 {
      xs.push(@math.ln(1.0 / eps))
      ys.push(entropy)
    }
  }
  if xs.length() < 2 {
    return 0.0
  }
  linear_fit_slope(xs, ys)
}

///|
/// Compute box counts N(eps) for a single scale. / 对单一尺度计算盒计数 N(eps)。
pub fn box_count(points : Array[@core.Point2D], eps : Double) -> Int {
  count_boxes(points, eps)
}

///|
/// Generate a range of scales geometrically from eps_min to eps_max.
/// 从 eps_min 到 eps_max 几何生成尺度序列。
pub fn geometric_scales(eps_min : Double, eps_max : Double, n : Int) -> Array[Double] {
  if n < 2 {
    return [eps_min]
  }
  let ratio = @math.pow(eps_max / eps_min, 1.0 / (n - 1).to_double())
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(eps_min * @math.pow(ratio, i.to_double()))
  }
  result
}