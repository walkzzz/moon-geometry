/// |
/// # Ball Tree
/// # 球树
///
/// Ball tree for metric space nearest neighbor search.
/// 用于度量空间最近邻搜索的球树。
///
/// ## Complexity: O(n log n) build, O(log n) query
/// ## 复杂度: 构建 O(n log n)，查询 O(log n)

/// |
/// Ball tree node.
/// 球树节点。
pub struct BallNode {
  center : @core.Point2D
  radius : Double
  points : Array[@core.Point2D]
  left : BallNode?
  right : BallNode?
}

/// |
/// Build a ball tree from points.
/// 从点集构建球树。
pub fn ball_tree_build(points : Array[@core.Point2D]) -> BallNode? {
  if points.is_empty() {
    return None
  }
  if points.length() <= 10 {
    let (center, radius) = compute_bounding_ball(points)
    return Some({ center, radius, points: points.copy(), left: None, right: None })
  }
  let (center, radius) = compute_bounding_ball(points)
  let spread_x = variance_x(points)
  let spread_y = variance_y(points)
  let sorted = points.copy()
  if spread_x >= spread_y {
    sorted.sort_by(fn(a, b) {
      if a.x() < b.x() {
        -1
      } else if a.x() > b.x() {
        1
      } else {
        0
      }
    })
  } else {
    sorted.sort_by(fn(a, b) {
      if a.y() < b.y() {
        -1
      } else if a.y() > b.y() {
        1
      } else {
        0
      }
    })
  }
  let mid = sorted.length() / 2
  let left_pts : Array[@core.Point2D] = []
  let right_pts : Array[@core.Point2D] = []
  for i in 0..<mid {
    left_pts.push(sorted[i])
  }
  for i in mid..<sorted.length() {
    right_pts.push(sorted[i])
  }
  Some({
    center,
    radius,
    points: [],
    left: ball_tree_build(left_pts),
    right: ball_tree_build(right_pts),
  })
}

/// |
/// Find k nearest neighbors.
/// 查找 k 个最近邻。
pub fn ball_tree_knn(
  root : BallNode?,
  query : @core.Point2D,
  k : Int,
) -> Array[@core.Point2D] {
  let result : Array[(@core.Point2D, Double)] = []
  ball_knn_impl(root, query, k, result)
  let final : Array[@core.Point2D] = []
  for i in 0..<result.length() {
    final.push(result[i].0)
  }
  final
}

/// |
/// Count nodes in the ball tree.
/// 计算球树中的节点数。
pub fn ball_tree_count(root : BallNode?) -> Int {
  match root {
    Some(node) => {
      let mut count = node.points.length()
      count += ball_tree_count(node.left)
      count += ball_tree_count(node.right)
      count
    }
    None => 0
  }
}

fn ball_knn_impl(
  node : BallNode?,
  query : @core.Point2D,
  k : Int,
  result : Array[(@core.Point2D, Double)],
) -> Unit {
  match node {
    Some(n) => {
      let dist_to_center = ((query.x() - n.center.x()) * (query.x() - n.center.x()) +
        (query.y() - n.center.y()) * (query.y() - n.center.y()))
        .sqrt()
      if result.length() >= k {
        let (_, worst) = result[result.length() - 1]
        if dist_to_center - n.radius > worst {
          return
        }
      }
      if n.points.length() > 0 {
        for i in 0..<n.points.length() {
          let p = n.points[i]
          let d = ((query.x() - p.x()) * (query.x() - p.x()) +
            (query.y() - p.y()) * (query.y() - p.y()))
            .sqrt()
          if result.length() < k {
            result.push((p, d))
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
            result[result.length() - 1] = (p, d)
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
        }
      }
      ball_knn_impl(n.left, query, k, result)
      ball_knn_impl(n.right, query, k, result)
    }
    None => ()
  }
}

fn compute_bounding_ball(points : Array[@core.Point2D]) -> (@core.Point2D, Double) {
  let n = points.length()
  let mut cx = 0.0
  let mut cy = 0.0
  for i in 0..<n {
    cx += points[i].x()
    cy += points[i].y()
  }
  cx /= n.to_double()
  cy /= n.to_double()
  let center = @core.Point2D::new(cx, cy)
  let mut max_r = 0.0
  for i in 0..<n {
    let d = ((points[i].x() - cx) * (points[i].x() - cx) +
      (points[i].y() - cy) * (points[i].y() - cy))
      .sqrt()
    if d > max_r {
      max_r = d
    }
  }
  (center, max_r)
}

fn variance_x(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  let mut sum = 0.0
  let mut sum_sq = 0.0
  for i in 0..<n {
    let x = points[i].x()
    sum += x
    sum_sq += x * x
  }
  let mean = sum / n.to_double()
  sum_sq / n.to_double() - mean * mean
}

fn variance_y(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  let mut sum = 0.0
  let mut sum_sq = 0.0
  for i in 0..<n {
    let y = points[i].y()
    sum += y
    sum_sq += y * y
  }
  let mean = sum / n.to_double()
  sum_sq / n.to_double() - mean * mean
}