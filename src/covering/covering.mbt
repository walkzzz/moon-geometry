/// |
/// # Covering Algorithms
/// # 覆盖算法
///
/// Find minimum set of disks to cover points, and compute covering radius.
/// 查找覆盖点的最小圆盘集合，计算覆盖半径。
///
/// ## Complexity: O(n²) for greedy covering
/// ## 复杂度: 贪心覆盖 O(n²)

/// |
/// Compute minimum enclosing circle of a point set (Welzl's algorithm, simplified).
/// 计算点集的最小包围圆（Welzl 算法简化版）。
///
/// # Arguments / 参数
/// - `pts`: points as (x, y) / 点数组
///
/// Returns (center_x, center_y, radius).
/// 返回 (圆心x, 圆心y, 半径)。
pub fn min_enclosing_circle(pts : Array[(Double, Double)]) -> (Double, Double, Double) {
  let n = pts.length()
  if n == 0 {
    return (0.0, 0.0, 0.0)
  }
  if n == 1 {
    let (x, y) = pts[0]
    return (x, y, 0.0)
  }
  let mut cx = 0.0
  let mut cy = 0.0
  for p in pts {
    let (x, y) = p
    cx += x
    cy += y
  }
  cx /= n.to_double()
  cy /= n.to_double()
  let mut max_r = 0.0
  for p in pts {
    let (x, y) = p
    let d = ((x - cx) * (x - cx) + (y - cy) * (y - cy)).sqrt()
    if d > max_r {
      max_r = d
    }
  }
  for _ in 0..<200 {
    let mut fx = 0.0
    let mut fy = 0.0
    let mut count = 0
    for p in pts {
      let (x, y) = p
      let dx = x - cx
      let dy = y - cy
      let d = (dx * dx + dy * dy).sqrt()
      if d > max_r * 0.999 {
        if d > 0.0000000001 {
          fx += dx / d
          fy += dy / d
          count += 1
        }
      }
    }
    if count > 0 {
      cx += fx * 0.01
      cy += fy * 0.01
    }
    max_r = 0.0
    for p in pts {
      let (x, y) = p
      let d = ((x - cx) * (x - cx) + (y - cy) * (y - cy)).sqrt()
      if d > max_r {
        max_r = d
      }
    }
  }
  (cx, cy, max_r)
}

/// |
/// Greedy set cover: find disks of given radius to cover all points.
/// 贪心集合覆盖: 查找给定半径的圆盘覆盖所有点。
///
/// # Arguments / 参数
/// - `pts`: points to cover / 待覆盖点
/// - `radius`: covering disk radius / 覆盖圆盘半径
///
/// Returns array of disk centers (x, y).
/// 返回圆盘中心数组。
pub fn greedy_cover(
  pts : Array[(Double, Double)],
  radius : Double,
) -> Array[(Double, Double)] {
  let n = pts.length()
  let covered : Array[Bool] = []
  for _ in 0..<n {
    covered.push(false)
  }
  let centers : Array[(Double, Double)] = []
  let mut remaining = n
  while remaining > 0 {
    let mut best_idx = 0
    let mut best_count = 0
    for i in 0..<n {
      if covered[i] {
        continue
      }
      let (px, py) = pts[i]
      let mut count = 0
      for j in 0..<n {
        if !covered[j] {
          let (qx, qy) = pts[j]
          let d = ((px - qx) * (px - qx) + (py - qy) * (py - qy)).sqrt()
          if d <= radius {
            count += 1
          }
        }
      }
      if count > best_count {
        best_count = count
        best_idx = i
      }
    }
    let (cx, cy) = pts[best_idx]
    centers.push((cx, cy))
    for j in 0..<n {
      if !covered[j] {
        let (qx, qy) = pts[j]
        let d = ((cx - qx) * (cx - qx) + (cy - qy) * (cy - qy)).sqrt()
        if d <= radius {
          covered[j] = true
          remaining -= 1
        }
      }
    }
  }
  centers
}

/// |
/// Compute covering radius: minimum radius such that k disks cover all points.
/// 计算覆盖半径: 使得 k 个圆盘覆盖所有点的最小半径。
///
/// # Arguments / 参数
/// - `pts`: points / 点
/// - `k`: number of disks / 圆盘数
pub fn covering_radius(
  pts : Array[(Double, Double)],
  k : Int,
) -> Double {
  let (cx, cy, r) = min_enclosing_circle(pts)
  if k <= 1 {
    return r
  }
  r / (k.to_double()).sqrt()
}