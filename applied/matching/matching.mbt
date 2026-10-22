/// |
/// # Point Set Matching
/// # 点集匹配
///
/// Match corresponding points between two point sets using nearest neighbor and Hausdorff distance.
/// 使用最近邻和 Hausdorff 距离匹配两个点集之间的对应点。
///
/// ## Complexity: O(n × m) for nearest neighbor matching
/// ## 复杂度: 最近邻匹配 O(n × m)

/// |
/// Match points from source to target using nearest neighbor.
/// 使用最近邻将源点匹配到目标点。
///
/// # Arguments / 参数
/// - `source`: source points / 源点集
/// - `target`: target points / 目标点集
///
/// Returns array of target indices for each source point.
/// 返回每个源点对应的目标点索引。
pub fn nearest_neighbor_match(
  source : Array[(Double, Double)],
  target : Array[(Double, Double)],
) -> Array[Int] {
  let result : Array[Int] = []
  for sp in source {
    let (sx, sy) = sp
    let mut best_idx = 0
    let mut best_d = 1000000000000000000.0
    for j in 0..<target.length() {
      let (tx, ty) = target[j]
      let d = (sx - tx) * (sx - tx) + (sy - ty) * (sy - ty)
      if d < best_d {
        best_d = d
        best_idx = j
      }
    }
    result.push(best_idx)
  }
  result
}

/// |
/// Compute Hausdorff distance between two point sets.
/// 计算两个点集之间的 Hausdorff 距离。
///
/// H(A, B) = max(h(A, B), h(B, A)) where h(A, B) = max_{a in A} min_{b in B} d(a, b)
pub fn hausdorff_distance(
  a : Array[(Double, Double)],
  b : Array[(Double, Double)],
) -> Double {
  let mut max_ab = 0.0
  for pa in a {
    let (ax, ay) = pa
    let mut min_d = 1000000000000000000.0
    for pb in b {
      let (bx, by) = pb
      let d = ((ax - bx) * (ax - bx) + (ay - by) * (ay - by)).sqrt()
      if d < min_d {
        min_d = d
      }
    }
    if min_d > max_ab {
      max_ab = min_d
    }
  }
  let mut max_ba = 0.0
  for pb in b {
    let (bx, by) = pb
    let mut min_d = 1000000000000000000.0
    for pa in a {
      let (ax, ay) = pa
      let d = ((ax - bx) * (ax - bx) + (ay - by) * (ay - by)).sqrt()
      if d < min_d {
        min_d = d
      }
    }
    if min_d > max_ba {
      max_ba = min_d
    }
  }
  if max_ab > max_ba {
    max_ab
  } else {
    max_ba
  }
}

/// |
/// Compute Chamfer distance between two point sets.
/// 计算两个点集之间的 Chamfer 距离。
///
/// C(A, B) = sum_{a in A} min_{b in B} d(a,b) + sum_{b in B} min_{a in A} d(a,b)
pub fn chamfer_distance(
  a : Array[(Double, Double)],
  b : Array[(Double, Double)],
) -> Double {
  let mut sum_ab = 0.0
  for pa in a {
    let (ax, ay) = pa
    let mut min_d = 1000000000000000000.0
    for pb in b {
      let (bx, by) = pb
      let d = ((ax - bx) * (ax - bx) + (ay - by) * (ay - by)).sqrt()
      if d < min_d {
        min_d = d
      }
    }
    sum_ab += min_d
  }
  let mut sum_ba = 0.0
  for pb in b {
    let (bx, by) = pb
    let mut min_d = 1000000000000000000.0
    for pa in a {
      let (ax, ay) = pa
      let d = ((ax - bx) * (ax - bx) + (ay - by) * (ay - by)).sqrt()
      if d < min_d {
        min_d = d
      }
    }
    sum_ba += min_d
  }
  sum_ab + sum_ba
}

/// |
/// Find best matching by brute force (for small point sets).
/// 使用暴力查找最佳匹配（适用于小点集）。
///
/// # Arguments / 参数
/// - `source`: source points / 源点集
/// - `target`: target points / 目标点集
/// - `threshold`: maximum matching distance / 最大匹配距离
///
/// Returns array of (source_idx, target_idx) pairs.
/// 返回 (源索引, 目标索引) 配对数组。
pub fn match_points(
  source : Array[(Double, Double)],
  target : Array[(Double, Double)],
  threshold : Double,
) -> Array[(Int, Int)] {
  let matches : Array[(Int, Int)] = []
  let used : Array[Bool] = []
  for _ in 0..<target.length() {
    used.push(false)
  }
  for i in 0..<source.length() {
    let (sx, sy) = source[i]
    let mut best_idx = -1
    let mut best_d = threshold * threshold
    for j in 0..<target.length() {
      if used[j] {
        continue
      }
      let (tx, ty) = target[j]
      let d = (sx - tx) * (sx - tx) + (sy - ty) * (sy - ty)
      if d < best_d {
        best_d = d
        best_idx = j
      }
    }
    if best_idx >= 0 {
      matches.push((i, best_idx))
      used[best_idx] = true
    }
  }
  matches
}