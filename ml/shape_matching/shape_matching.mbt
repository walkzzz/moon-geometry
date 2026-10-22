///|
/// # Shape Matching
/// # 形状匹配
///
/// ICP + shape context + Hungarian algorithm for optimal point matching.
/// ICP + 形状上下文 + 匈牙利算法用于最优点匹配。
///
/// ## Complexity: O(n^3) for Hungarian, O(iter * n * m) for ICP
/// ## 复杂度: 匈牙利 O(n^3), ICP O(iter * n * m)

///|
/// Large constant for padding. / 填充用大常数。
let inf_val : Double = 1000000000000.0

///|
/// Hungarian (Kuhn-Munkres) algorithm for minimum-cost assignment.
/// 匈牙利（Kuhn-Munkres）算法求最小代价指派。
///
/// # Arguments / 参数
/// - `cost`: cost matrix (rows x cols) / 代价矩阵（行 x 列）
///
/// Returns array of length = rows, where result[i] = assigned column index,
/// or -1 if row i is unassigned (matrix was padded). / 返回长度为行数的数组，
/// result[i] 为指派的列索引，未指派时为 -1。
pub fn hungarian(cost : Array[Array[Double]]) -> Array[Int] {
  let n = cost.length()
  if n == 0 {
    return []
  }
  let m = cost[0].length()
  let sz = if n > m { n } else { m }
  let a : Array[Array[Double]] = []
  for _ in 0..=(sz) {
    a.push(Array::make(sz + 1, inf_val))
  }
  for i in 1..=sz {
    for j in 1..=sz {
      if i - 1 < n && j - 1 < m {
        a[i][j] = cost[i - 1][j - 1]
      }
    }
  }
  let u : Array[Double] = Array::make(sz + 1, 0.0)
  let v : Array[Double] = Array::make(sz + 1, 0.0)
  let p : Array[Int] = Array::make(sz + 1, 0)
  let way : Array[Int] = Array::make(sz + 1, 0)
  for i in 1..=sz {
    p[0] = i
    let mut j0 = 0
    let minv : Array[Double] = Array::make(sz + 1, inf_val)
    let used : Array[Bool] = Array::make(sz + 1, false)
    while true {
      used[j0] = true
      let i0 = p[j0]
      let mut delta = inf_val
      let mut j1 = -1
      for j in 1..=sz {
        if !used[j] {
          let cur = a[i0][j] - u[i0] - v[j]
          if cur < minv[j] {
            minv[j] = cur
            way[j] = j0
          }
          if minv[j] < delta {
            delta = minv[j]
            j1 = j
          }
        }
      }
      for j in 0..=sz {
        if used[j] {
          u[p[j]] = u[p[j]] + delta
          v[j] = v[j] - delta
        } else {
          minv[j] = minv[j] - delta
        }
      }
      j0 = j1
      if j0 < 0 {
        j0 = 0
        break
      }
      if p[j0] == 0 {
        break
      }
    }
    while j0 != 0 {
      let j1 = way[j0]
      p[j0] = p[j1]
      j0 = j1
    }
  }
  let result : Array[Int] = Array::make(n, -1)
  for j in 1..=sz {
    let row = p[j]
    if row > 0 && row - 1 < n && j - 1 < m {
      result[row - 1] = j - 1
    }
  }
  result
}

///|
/// Find closest point in target to a source point. / 在目标中找离源点最近的点。
fn closest_idx(
  target : Array[@core.Point2D],
  p : @core.Point2D,
) -> Int {
  let mut best = 0
  let mut best_d = 1.7976931348623157e+308
  for j in 0..<target.length() {
    let d = p.dist_sq(target[j])
    if d < best_d {
      best_d = d
      best = j
    }
  }
  best
}

///|
/// Estimate 2D rotation and translation aligning source to target (Procrustes).
/// 估计对齐源到目标的 2D 旋转和平移（Procrustes）。
fn estimate_rigid(
  src : Array[@core.Point2D],
  tgt : Array[@core.Point2D],
  correspondences : Array[Int],
) -> (Double, Double, Double) {
  let n = src.length()
  let mut sx = 0.0
  let mut sy = 0.0
  let mut tx = 0.0
  let mut ty = 0.0
  let mut cnt = 0.0
  for i in 0..<n {
    let j = correspondences[i]
    if j >= 0 {
      sx += src[i].x()
      sy += src[i].y()
      tx += tgt[j].x()
      ty += tgt[j].y()
      cnt += 1.0
    }
  }
  if cnt < 1.0 {
    return (0.0, 0.0, 0.0)
  }
  sx = sx / cnt
  sy = sy / cnt
  tx = tx / cnt
  ty = ty / cnt
  let mut num = 0.0
  let mut den = 0.0
  for i in 0..<n {
    let j = correspondences[i]
    if j >= 0 {
      let dx = src[i].x() - sx
      let dy = src[i].y() - sy
      let ex = tgt[j].x() - tx
      let ey = tgt[j].y() - ty
      num += dx * ey - dy * ex
      den += dx * ex + dy * ey
    }
  }
  let angle = if den.abs() < 0.000000000001 {
    0.0
  } else {
    @math.atan2(num, den)
  }
  (angle, tx - sx, ty - sy)
}

///|
/// Apply 2D rigid transform (angle, tx, ty) to a point.
/// 对点应用 2D 刚体变换（角度, tx, ty）。
fn apply_rigid(
  p : @core.Point2D,
  angle : Double,
  tx : Double,
  ty : Double,
) -> @core.Point2D {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  @core.Point2D::new(c * p.x() - s * p.y() + tx, s * p.x() + c * p.y() + ty)
}

///|
/// 2D ICP shape matching: iteratively align source to target.
/// 二维 ICP 形状匹配：迭代对齐源到目标。
///
/// Returns array of target indices for each source point.
/// 返回每个源点对应的目标点索引。
pub fn shape_matching_icp(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
  max_iter : Int,
) -> Array[Int] {
  let n = source.length()
  let aligned : Array[@core.Point2D] = []
  for p in source {
    aligned.push(p)
  }
  for _ in 0..<max_iter {
    let correspondences : Array[Int] = []
    for p in aligned {
      correspondences.push(closest_idx(target, p))
    }
    let (angle, tx, ty) = estimate_rigid(aligned, target, correspondences)
    if angle.abs() < 0.0000001 && tx.abs() < 0.0000001 && ty.abs() < 0.0000001 {
      break
    }
    for i in 0..<n {
      aligned[i] = apply_rigid(aligned[i], angle, tx, ty)
    }
  }
  let result : Array[Int] = []
  for p in aligned {
    result.push(closest_idx(target, p))
  }
  result
}

///|
/// Shape context cost between two point sets.
/// 两个点集之间的形状上下文代价矩阵。
fn sc_cost(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
) -> Array[Array[Double]] {
  let n_r = 5
  let n_theta = 8
  let sc1 = @shape_context.shape_context(source, n_r, n_theta)
  let sc2 = @shape_context.shape_context(target, n_r, n_theta)
  @shape_context.shape_context_cost(sc1, sc2)
}

///|
/// Shape matching via shape context + Hungarian algorithm.
/// 通过形状上下文 + 匈牙利算法进行形状匹配。
///
/// Returns array of target indices for each source point.
/// 返回每个源点对应的目标点索引。
pub fn shape_matching_hungarian(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
) -> Array[Int] {
  let cost = sc_cost(source, target)
  hungarian(cost)
}

///|
/// Overall shape matching score (lower = better match).
/// 整体形状匹配得分（越低匹配越好）。
pub fn shape_matching_score(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
) -> Double {
  let cost = sc_cost(source, target)
  let assign = hungarian(cost)
  let mut total = 0.0
  for i in 0..<assign.length() {
    let j = assign[i]
    if j >= 0 {
      total += cost[i][j]
    }
  }
  total
}