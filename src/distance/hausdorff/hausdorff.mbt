///|
/// Directed Hausdorff distance from set A to set B. / 从集合 A 到集合 B 的有向 Hausdorff 距离。
pub fn hausdorff_directed(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  if a.length() == 0 {
    return 0.0
  }
  if b.length() == 0 {
    return 1.0 / 0.000000000001
  }
  let mut max_min = 0.0
  for pa in a {
    let mut min_dist = pa.dist(b[0])
    for pb in b {
      let d = pa.dist(pb)
      if d < min_dist {
        min_dist = d
      }
    }
    if min_dist > max_min {
      max_min = min_dist
    }
  }
  max_min
}

///|
/// Hausdorff distance between two point sets. / 两个点集的 Hausdorff 距离。
pub fn hausdorff_distance(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  let d1 = hausdorff_directed(a, b)
  let d2 = hausdorff_directed(b, a)
  if d1 > d2 {
    d1
  } else {
    d2
  }
}

///|
/// Hausdorff distance with early termination (epsilon check). / 带提前终止的 Hausdorff 距离。
pub fn hausdorff_within(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  eps : Double,
) -> Bool {
  hausdorff_distance(a, b) <= eps
}

///|
/// Partial Hausdorff distance (k-th largest directed distance). / 部分 Hausdorff 距离（第 k 大有向距离）。
pub fn partial_hausdorff(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  k : Int,
) -> Double {
  if a.length() == 0 || b.length() == 0 {
    return 0.0
  }
  let dists : Array[Double] = []
  for pa in a {
    let mut min_dist = pa.dist(b[0])
    for pb in b {
      let d = pa.dist(pb)
      if d < min_dist {
        min_dist = d
      }
    }
    dists.push(min_dist)
  }
  dists.sort()
  let idx = if k < dists.length() { k } else { dists.length() - 1 }
  dists[idx]
}