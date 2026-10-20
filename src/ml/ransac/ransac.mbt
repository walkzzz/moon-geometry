/// |
/// # RANSAC (Random Sample Consensus)
/// # RANSAC 随机采样一致性
///
/// Robust model fitting using the RANSAC algorithm.
/// 使用 RANSAC 算法进行鲁棒模型拟合。
///
/// ## Complexity: O(iterations * n)
/// ## 复杂度: O(iterations * n)

/// |
/// Fitted line model: y = a*x + b.
/// 拟合直线模型: y = a*x + b。
pub struct RansacLine {
  a : Double
  b : Double
  inliers : Array[Int]
}

pub fn RansacLine::new(
  a : Double,
  b : Double,
  inliers : Array[Int],
) -> RansacLine {
  { a, b, inliers }
}

/// |
/// Fitted circle model.
/// 拟合圆模型。
pub struct RansacCircle {
  cx : Double
  cy : Double
  radius : Double
  inliers : Array[Int]
}

pub fn RansacCircle::new(
  cx : Double,
  cy : Double,
  radius : Double,
  inliers : Array[Int],
) -> RansacCircle {
  { cx, cy, radius, inliers }
}

/// |
/// Fitted plane model: a*x + b*y + c*z + d = 0.
/// 拟合平面模型: a*x + b*y + c*z + d = 0。
pub struct RansacPlane {
  a : Double
  b : Double
  c : Double
  d : Double
  inliers : Array[Int]
}

pub fn RansacPlane::new(
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  inliers : Array[Int],
) -> RansacPlane {
  { a, b, c, d, inliers }
}

/// |
/// Fit a line to 2D points using RANSAC.
/// 使用 RANSAC 拟合 2D 点集的直线。
///
/// # Arguments / 参数
/// - `pts`: input points / 输入点集
/// - `iterations`: number of RANSAC iterations / RANSAC 迭代次数
/// - `threshold`: inlier distance threshold / 内点距离阈值
///
/// Returns the best fitting line with inlier indices.
/// 返回最佳拟合直线及内点索引。
pub fn ransac_line(
  pts : Array[@core.Point2D],
  iterations : Int,
  threshold : Double,
) -> RansacLine {
  let n = pts.length()
  if n < 2 {
    return RansacLine::new(0.0, 0.0, [])
  }
  let mut best_a = 0.0
  let mut best_b = 0.0
  let mut best_inliers : Array[Int] = []
  for _ in 0..<iterations {
    let i = (pts.length() * 31 + 17) % pts.length()
    let j = (i + 1 + (iterations % (pts.length() - 1))) % pts.length()
    if i == j {
      continue
    }
    let x1 = pts[i].x()
    let y1 = pts[i].y()
    let x2 = pts[j].x()
    let y2 = pts[j].y()
    let dx = x2 - x1
    let dy = y2 - y1
    if (dx * dx + dy * dy).sqrt() < 0.0000001 {
      continue
    }
    let a = dy / dx
    let b = y1 - a * x1
    let inliers : Array[Int] = []
    for k in 0..<n {
      let x = pts[k].x()
      let y = pts[k].y()
      let dist = (a * x + b - y).abs() / (a * a + 1.0).sqrt()
      if dist < threshold {
        inliers.push(k)
      }
    }
    if inliers.length() > best_inliers.length() {
      best_a = a
      best_b = b
      best_inliers = inliers
    }
  }
  if best_inliers.length() == 0 {
    let x1 = pts[0].x()
    let y1 = pts[0].y()
    let x2 = pts[1].x()
    let y2 = pts[1].y()
    let dx = x2 - x1
    let dy = y2 - y1
    if (dx * dx).abs() < 0.0000001 {
      best_a = 0.0
      best_b = y1
    } else {
      best_a = dy / dx
      best_b = y1 - best_a * x1
    }
    best_inliers = [0, 1]
  }
  RansacLine::new(best_a, best_b, best_inliers)
}

/// |
/// Fit a circle to 2D points using RANSAC.
/// 使用 RANSAC 拟合 2D 点集的圆。
///
/// # Arguments / 参数
/// - `pts`: input points / 输入点集
/// - `iterations`: number of RANSAC iterations / RANSAC 迭代次数
/// - `threshold`: inlier distance threshold / 内点距离阈值
pub fn ransac_circle(
  pts : Array[@core.Point2D],
  iterations : Int,
  threshold : Double,
) -> RansacCircle {
  let n = pts.length()
  if n < 3 {
    return RansacCircle::new(0.0, 0.0, 0.0, [])
  }
  let mut best_cx = 0.0
  let mut best_cy = 0.0
  let mut best_r = 0.0
  let mut best_inliers : Array[Int] = []
  for iter in 0..<iterations {
    let i = (iter * 7 + 3) % n
    let j = (iter * 11 + 5) % n
    let k = (iter * 13 + 7) % n
    if i == j || j == k || i == k {
      continue
    }
    let x1 = pts[i].x()
    let y1 = pts[i].y()
    let x2 = pts[j].x()
    let y2 = pts[j].y()
    let x3 = pts[k].x()
    let y3 = pts[k].y()
    let d = 2.0 * (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2))
    if d.abs() < 0.0000001 {
      continue
    }
    let cx = ((x1 * x1 + y1 * y1) * (y2 - y3) + (x2 * x2 + y2 * y2) *
      (y3 - y1) + (x3 * x3 + y3 * y3) * (y1 - y2)) / d
    let cy = ((x1 * x1 + y1 * y1) * (x3 - x2) + (x2 * x2 + y2 * y2) *
      (x1 - x3) + (x3 * x3 + y3 * y3) * (x2 - x1)) / d
    let r = ((x1 - cx) * (x1 - cx) + (y1 - cy) * (y1 - cy)).sqrt()
    let inliers : Array[Int] = []
    for idx in 0..<n {
      let x = pts[idx].x()
      let y = pts[idx].y()
      let dist = ((x - cx) * (x - cx) + (y - cy) * (y - cy)).sqrt() - r
      if dist.abs() < threshold {
        inliers.push(idx)
      }
    }
    if inliers.length() > best_inliers.length() {
      best_cx = cx
      best_cy = cy
      best_r = r
      best_inliers = inliers
    }
  }
  if best_inliers.length() == 0 {
    best_inliers = [0, 1, 2]
  }
  RansacCircle::new(best_cx, best_cy, best_r, best_inliers)
}

/// |
/// Fit a plane to 3D points using RANSAC.
/// 使用 RANSAC 拟合 3D 点集的平面。
///
/// # Arguments / 参数
/// - `pts`: input 3D points / 输入 3D 点集
/// - `iterations`: number of RANSAC iterations / RANSAC 迭代次数
/// - `threshold`: inlier distance threshold / 内点距离阈值
pub fn ransac_plane(
  pts : Array[@core.Point3D],
  iterations : Int,
  threshold : Double,
) -> RansacPlane {
  let n = pts.length()
  if n < 3 {
    return RansacPlane::new(0.0, 0.0, 1.0, 0.0, [])
  }
  let mut best_a = 0.0
  let mut best_b = 0.0
  let mut best_c = 0.0
  let mut best_d = 0.0
  let mut best_inliers : Array[Int] = []
  for iter in 0..<iterations {
    let i = (iter * 7 + 3) % n
    let j = (iter * 11 + 5) % n
    let k = (iter * 13 + 7) % n
    if i == j || j == k || i == k {
      continue
    }
    let v1x = pts[j].x - pts[i].x
    let v1y = pts[j].y - pts[i].y
    let v1z = pts[j].z - pts[i].z
    let v2x = pts[k].x - pts[i].x
    let v2y = pts[k].y - pts[i].y
    let v2z = pts[k].z - pts[i].z
    let a = v1y * v2z - v1z * v2y
    let b = v1z * v2x - v1x * v2z
    let c = v1x * v2y - v1y * v2x
    let norm = (a * a + b * b + c * c).sqrt()
    if norm < 0.0000001 {
      continue
    }
    let na = a / norm
    let nb = b / norm
    let nc = c / norm
    let nd = -(na * pts[i].x + nb * pts[i].y + nc * pts[i].z)
    let inliers : Array[Int] = []
    for idx in 0..<n {
      let dist = (na * pts[idx].x + nb * pts[idx].y + nc * pts[idx].z + nd).abs()
      if dist < threshold {
        inliers.push(idx)
      }
    }
    if inliers.length() > best_inliers.length() {
      best_a = na
      best_b = nb
      best_c = nc
      best_d = nd
      best_inliers = inliers
    }
  }
  if best_inliers.length() == 0 {
    best_inliers = [0, 1, 2]
  }
  RansacPlane::new(best_a, best_b, best_c, best_d, best_inliers)
}

/// |
/// Refit a line using all inliers via least squares.
/// 使用所有内点通过最小二乘法重新拟合直线。
pub fn ransac_refit_line(
  pts : Array[@core.Point2D],
  inliers : Array[Int],
) -> (Double, Double) {
  let m = inliers.length()
  if m < 2 {
    return (0.0, 0.0)
  }
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  let mut sum_xx = 0.0
  let mut sum_xy = 0.0
  for i in 0..<m {
    let x = pts[inliers[i]].x()
    let y = pts[inliers[i]].y()
    sum_x = sum_x + x
    sum_y = sum_y + y
    sum_xx = sum_xx + x * x
    sum_xy = sum_xy + x * y
  }
  let denom = (m.to_double()) * sum_xx - sum_x * sum_x
  if denom.abs() < 0.0000001 {
    return (0.0, sum_y / (m.to_double()))
  }
  let a = ((m.to_double()) * sum_xy - sum_x * sum_y) / denom
  let b = (sum_y - a * sum_x) / (m.to_double())
  (a, b)
}

/// |
/// Count inliers for a given line model.
/// 计算给定直线模型的内点数量。
pub fn count_line_inliers(
  pts : Array[@core.Point2D],
  a : Double,
  b : Double,
  threshold : Double,
) -> Int {
  let mut count = 0
  for i in 0..<pts.length() {
    let x = pts[i].x()
    let y = pts[i].y()
    let dist = (a * x + b - y).abs() / (a * a + 1.0).sqrt()
    if dist < threshold {
      count = count + 1
    }
  }
  count
}