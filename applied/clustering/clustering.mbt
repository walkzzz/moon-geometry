/// |
/// # Clustering Algorithms
/// # 聚类算法
///
/// K-means and DBSCAN clustering for 2D points.
/// 二维点的 K-means 和 DBSCAN 聚类。
///
/// ## Complexity: O(n × k × iter) for K-means
/// ## 复杂度: K-means O(n × k × iter)

///|
/// |
/// K-means clustering.
/// K-means 聚类。
///
/// # Arguments / 参数
/// - `pts`: input points (x, y) / 输入点
/// - `k`: number of clusters / 聚类数
/// - `max_iter`: maximum iterations / 最大迭代数
///
/// Returns array of cluster labels (0 to k-1) for each point.
/// 返回每个点的聚类标签数组（0 到 k-1）。
pub fn kmeans(
  pts : Array[(Double, Double)],
  k : Int32,
  max_iter : Int32,
) -> Array[Int32] {
  let n = pts.length()
  if n == 0 || k <= 0 {
    return []
  }
  let centroids : Array[(Double, Double)] = []
  for i in 0..<k {
    let idx = i * n / k
    centroids.push(pts[idx])
  }
  let labels : Array[Int32] = []
  for _ in 0..<n {
    labels.push(0)
  }
  for _ in 0..<max_iter {
    let mut changed = false
    for i in 0..<n {
      let (px, py) = pts[i]
      let mut best_cluster = 0
      let mut best_dist = 1000000000000000000.0
      for j in 0..<k {
        let (cx, cy) = centroids[j]
        let d = (px - cx) * (px - cx) + (py - cy) * (py - cy)
        if d < best_dist {
          best_dist = d
          best_cluster = j
        }
      }
      if labels[i] != best_cluster {
        labels[i] = best_cluster
        changed = true
      }
    }
    for j in 0..<k {
      let mut sx = 0.0
      let mut sy = 0.0
      let mut count = 0
      for i in 0..<n {
        if labels[i] == j {
          let (px, py) = pts[i]
          sx += px
          sy += py
          count += 1
        }
      }
      if count > 0 {
        centroids[j] = (sx / count.to_double(), sy / count.to_double())
      }
    }
    if !changed {
      break
    }
  }
  labels
}

///|
/// |
/// DBSCAN clustering (Density-Based Spatial Clustering).
/// DBSCAN 聚类（基于密度的空间聚类）。
///
/// # Arguments / 参数
/// - `pts`: input points / 输入点
/// - `eps`: neighborhood radius / 邻域半径
/// - `min_pts`: minimum points in neighborhood / 邻域最小点数
///
/// Returns array of cluster labels (-1 = noise, 0+ = cluster).
/// 返回聚类标签数组（-1 = 噪声, 0+ = 聚类）。
pub fn dbscan(
  pts : Array[(Double, Double)],
  eps : Double,
  min_pts : Int32,
) -> Array[Int32] {
  let n = pts.length()
  let labels : Array[Int32] = []
  for _ in 0..<n {
    labels.push(-2)
  }
  let mut cluster_id = 0
  for i in 0..<n {
    if labels[i] != -2 {
      continue
    }
    let neighbors = range_query(pts, i, eps)
    if neighbors.length() < min_pts {
      labels[i] = -1
      continue
    }
    labels[i] = cluster_id
    let mut idx = 0
    while idx < neighbors.length() {
      let nn = neighbors[idx]
      if labels[nn] == -1 {
        labels[nn] = cluster_id
      }
      if labels[nn] != -2 {
        idx += 1
        continue
      }
      labels[nn] = cluster_id
      let nn_neighbors = range_query(pts, nn, eps)
      if nn_neighbors.length() >= min_pts {
        for nn2 in nn_neighbors {
          let mut found = false
          for existing in neighbors {
            if existing == nn2 {
              found = true
              break
            }
          }
          if !found {
            neighbors.push(nn2)
          }
        }
      }
      idx += 1
    }
    cluster_id += 1
  }
  labels
}

///|
/// |
/// Find all points within eps distance of point i.
/// 查找点 i 的 eps 邻域内所有点。
fn range_query(
  pts : Array[(Double, Double)],
  i : Int32,
  eps : Double,
) -> Array[Int32] {
  let result : Array[Int32] = []
  let (px, py) = pts[i]
  for j in 0..<pts.length() {
    let (qx, qy) = pts[j]
    let d = ((px - qx) * (px - qx) + (py - qy) * (py - qy)).sqrt()
    if d <= eps {
      result.push(j)
    }
  }
  result
}

///|
/// |
/// Compute cluster centroids from labels.
/// 从标签计算聚类中心。
///
/// # Arguments / 参数
/// - `pts`: input points / 输入点
/// - `labels`: cluster labels / 聚类标签
/// - `k`: number of clusters / 聚类数
pub fn cluster_centroids(
  pts : Array[(Double, Double)],
  labels : Array[Int32],
  k : Int32,
) -> Array[(Double, Double)] {
  let centroids : Array[(Double, Double)] = []
  for j in 0..<k {
    let mut sx = 0.0
    let mut sy = 0.0
    let mut count = 0
    for i in 0..<pts.length() {
      if labels[i] == j {
        let (px, py) = pts[i]
        sx += px
        sy += py
        count += 1
      }
    }
    if count > 0 {
      centroids.push((sx / count.to_double(), sy / count.to_double()))
    } else {
      centroids.push((0.0, 0.0))
    }
  }
  centroids
}
