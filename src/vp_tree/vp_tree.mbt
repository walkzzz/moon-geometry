/// |
/// # Vantage Point Tree (VP-Tree)
/// # 基点树
///
/// VP-tree for metric space nearest neighbor search using vantage points.
/// 使用基点的度量空间最近邻搜索树。
///
/// ## Complexity: O(n log n) build, O(log n) query
/// ## 复杂度: 构建 O(n log n)，查询 O(log n)

/// |
/// VP-tree node.
/// 基点树节点。
pub struct VPNode {
  vp : @core.Point2D
  threshold : Double
  left : VPNode?
  right : VPNode?
}

/// |
/// Build a VP-tree from points.
/// 从点集构建基点树。
pub fn vp_tree_build(points : Array[@core.Point2D]) -> VPNode? {
  if points.is_empty() {
    return None
  }
  if points.length() == 1 {
    return Some({ vp: points[0], threshold: 0.0, left: None, right: None })
  }
  let vp = points[0]
  let dists : Array[(Int, Double)] = []
  for i in 1..<points.length() {
    let d = dist(vp, points[i])
    dists.push((i, d))
  }
  dists.sort_by(fn(a, b) {
    if a.1 < b.1 {
      -1
    } else if a.1 > b.1 {
      1
    } else {
      0
    }
  })
  let mid = dists.length() / 2
  let threshold = if dists.length() > 0 { dists[mid].1 } else { 0.0 }
  let inner : Array[@core.Point2D] = []
  let outer : Array[@core.Point2D] = []
  for i in 0..<dists.length() {
    if i < mid {
      inner.push(points[dists[i].0])
    } else {
      outer.push(points[dists[i].0])
    }
  }
  Some({
    vp,
    threshold,
    left: vp_tree_build(inner),
    right: vp_tree_build(outer),
  })
}

/// |
/// Find k nearest neighbors in VP-tree.
/// 在基点树中查找 k 个最近邻。
pub fn vp_tree_knn(
  root : VPNode?,
  query : @core.Point2D,
  k : Int,
) -> Array[@core.Point2D] {
  let result : Array[(@core.Point2D, Double)] = []
  vp_knn_impl(root, query, k, result)
  let final : Array[@core.Point2D] = []
  for i in 0..<result.length() {
    final.push(result[i].0)
  }
  final
}

/// |
/// Count nodes in VP-tree.
/// 计算基点树中的节点数。
pub fn vp_tree_count(root : VPNode?) -> Int {
  match root {
    Some(node) => 1 + vp_tree_count(node.left) + vp_tree_count(node.right)
    None => 0
  }
}

fn vp_knn_impl(
  node : VPNode?,
  query : @core.Point2D,
  k : Int,
  result : Array[(@core.Point2D, Double)],
) -> Unit {
  match node {
    Some(n) => {
      let d = dist(query, n.vp)
      if result.length() < k {
        result.push((n.vp, d))
        result.sort_by(fn(a, b) {
          if a.1 < b.1 {
            -1
          } else if a.1 > b.1 {
            1
          } else {
            0
          }
        })
      } else if d < result[result.length() - 1].1 {
        result[result.length() - 1] = (n.vp, d)
        result.sort_by(fn(a, b) {
          if a.1 < b.1 {
            -1
          } else if a.1 > b.1 {
            1
          } else {
            0
          }
        })
      }
      let tau = if result.length() >= k {
        result[result.length() - 1].1
      } else {
        1000000.0
      }
      if d < n.threshold + tau {
        vp_knn_impl(n.left, query, k, result)
      }
      if d >= n.threshold - tau {
        vp_knn_impl(n.right, query, k, result)
      }
    }
    None => ()
  }
}

fn dist(a : @core.Point2D, b : @core.Point2D) -> Double {
  ((a.x() - b.x()) * (a.x() - b.x()) + (a.y() - b.y()) * (a.y() - b.y())).sqrt()
}