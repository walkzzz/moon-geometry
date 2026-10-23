/// |
/// # Point Cloud Registration
/// # 点云配准
///
/// Iterative Closest Point (ICP) algorithm for aligning point clouds.
/// 用于点云对齐的迭代最近点（ICP）算法。
///
/// ## Complexity: O(n × m × iter) for ICP
/// ## 复杂度: ICP O(n × m × iter)

///|
/// |
/// Find the closest point in target to a given source point.
/// 在目标点云中查找离给定源点最近的点。
fn closest_point(
  target : Array[(Double, Double, Double)],
  p : (Double, Double, Double),
) -> (Double, Double, Double) {
  let (px, py, pz) = p
  let mut best_d = 1000000000000000000.0
  let mut best = target[0]
  for q in target {
    let (qx, qy, qz) = q
    let d = (px - qx) * (px - qx) +
      (py - qy) * (py - qy) +
      (pz - qz) * (pz - qz)
    if d < best_d {
      best_d = d
      best = q
    }
  }
  best
}

///|
/// |
/// Compute centroid of a 3D point cloud.
/// 计算 3D 点云的质心。
pub fn centroid_3d(
  pts : Array[(Double, Double, Double)],
) -> (Double, Double, Double) {
  let n = pts.length()
  let mut sx = 0.0
  let mut sy = 0.0
  let mut sz = 0.0
  for p in pts {
    let (x, y, z) = p
    sx += x
    sy += y
    sz += z
  }
  (sx / n.to_double(), sy / n.to_double(), sz / n.to_double())
}

///|
/// |
/// Apply translation to a point cloud.
/// 对点云应用平移变换。
///
/// # Arguments / 参数
/// - `pts`: point cloud / 点云
/// - `tx`, `ty`, `tz`: translation / 平移量
pub fn translate_pts(
  pts : Array[(Double, Double, Double)],
  tx : Double,
  ty : Double,
  tz : Double,
) -> Array[(Double, Double, Double)] {
  let result : Array[(Double, Double, Double)] = []
  for p in pts {
    let (x, y, z) = p
    result.push((x + tx, y + ty, z + tz))
  }
  result
}

///|
/// |
/// ICP (Iterative Closest Point) registration.
/// ICP（迭代最近点）配准。
///
/// # Arguments / 参数
/// - `source`: source point cloud / 源点云
/// - `target`: target point cloud / 目标点云
/// - `max_iter`: maximum iterations / 最大迭代数
///
/// Returns (aligned source, total translation (tx, ty, tz)).
/// 返回 (对齐后的源点云, 总平移 (tx, ty, tz))。
pub fn icp(
  source : Array[(Double, Double, Double)],
  target : Array[(Double, Double, Double)],
  max_iter : Int32,
) -> (Array[(Double, Double, Double)], (Double, Double, Double)) {
  let aligned : Array[(Double, Double, Double)] = []
  for p in source {
    aligned.push(p)
  }
  let mut total_tx = 0.0
  let mut total_ty = 0.0
  let mut total_tz = 0.0
  for _ in 0..<max_iter {
    let correspondences : Array[(Double, Double, Double)] = []
    for p in aligned {
      correspondences.push(closest_point(target, p))
    }
    let src_centroid = centroid_3d(aligned)
    let tgt_centroid = centroid_3d(correspondences)
    let (sx, sy, sz) = src_centroid
    let (tx, ty, tz) = tgt_centroid
    let dx = tx - sx
    let dy = ty - sy
    let dz = tz - sz
    if (dx * dx + dy * dy + dz * dz).sqrt() < 0.0000001 {
      break
    }
    for i in 0..<aligned.length() {
      let (x, y, z) = aligned[i]
      aligned[i] = (x + dx, y + dy, z + dz)
    }
    total_tx += dx
    total_ty += dy
    total_tz += dz
  }
  (aligned, (total_tx, total_ty, total_tz))
}

///|
/// |
/// Compute RMS error between two point clouds (point-to-point).
/// 计算两个点云之间的 RMS 误差（点到点）。
pub fn rms_error(
  source : Array[(Double, Double, Double)],
  target : Array[(Double, Double, Double)],
) -> Double {
  let n = source.length()
  let mut sum_sq = 0.0
  for i in 0..<n {
    let (sx, sy, sz) = source[i]
    let (tx, ty, tz) = target[i]
    let dx = sx - tx
    let dy = sy - ty
    let dz = sz - tz
    sum_sq += dx * dx + dy * dy + dz * dz
  }
  (sum_sq / n.to_double()).sqrt()
}
