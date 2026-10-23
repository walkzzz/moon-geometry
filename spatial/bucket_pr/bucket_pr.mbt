///|
/// Bucket PR k-d tree node. / 桶 PR k-d 树节点。
pub struct BucketPRNode {
  is_leaf : Bool
  bucket : Array[Int32]
  axis : Int32
  split_val : Double
  left : Int32
  right : Int32
} derive(Debug)

///|
pub extend BucketPRNode with @moonbitlang/core/debug.Debug::{to_repr}

///|
fn bucket_pr_build_rec(
  points : Array[@core.Point2D],
  indices : Array[Int32],
  axis : Int32,
  bucket_size : Int32,
  nodes : Array[BucketPRNode],
) -> Int32 {
  if indices.length() <= bucket_size {
    nodes.push({
      is_leaf: true,
      bucket: indices,
      axis,
      split_val: 0.0,
      left: -1,
      right: -1,
    })
    return nodes.length() - 1
  }
  let sorted : Array[Int32] = []
  for i in 0..<indices.length() {
    sorted.push(indices[i])
  }
  sorted.sort_by(fn(a, b) {
    let va = if axis == 0 { points[a].x() } else { points[a].y() }
    let vb = if axis == 0 { points[b].x() } else { points[b].y() }
    if va < vb {
      -1
    } else if va > vb {
      1
    } else {
      0
    }
  })
  let mid = sorted.length() / 2
  let split_val = if axis == 0 {
    points[sorted[mid]].x()
  } else {
    points[sorted[mid]].y()
  }
  let left_indices : Array[Int32] = []
  let right_indices : Array[Int32] = []
  for i in 0..<mid {
    left_indices.push(sorted[i])
  }
  for i in mid..<sorted.length() {
    right_indices.push(sorted[i])
  }
  let left_idx = bucket_pr_build_rec(
    points,
    left_indices,
    1 - axis,
    bucket_size,
    nodes,
  )
  let right_idx = bucket_pr_build_rec(
    points,
    right_indices,
    1 - axis,
    bucket_size,
    nodes,
  )
  nodes.push({
    is_leaf: false,
    bucket: [],
    axis,
    split_val,
    left: left_idx,
    right: right_idx,
  })
  nodes.length() - 1
}

///|
/// Build a bucket PR k-d tree. / 构建桶 PR k-d 树。
pub fn build_bucket_pr(
  points : Array[@core.Point2D],
  bucket_size : Int32,
) -> Array[BucketPRNode] {
  if points.length() == 0 {
    return []
  }
  let nodes : Array[BucketPRNode] = []
  let indices : Array[Int32] = []
  for i in 0..<points.length() {
    indices.push(i)
  }
  ignore(bucket_pr_build_rec(points, indices, 0, bucket_size, nodes))
  nodes
}

///|
fn bucket_pr_nearest_rec(
  nodes : Array[BucketPRNode],
  node_idx : Int32,
  points : Array[@core.Point2D],
  query : @core.Point2D,
  best : Array[(Int32, Double)],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  if node.is_leaf {
    for i in 0..<node.bucket.length() {
      let idx = node.bucket[i]
      let dx = points[idx].x() - query.x()
      let dy = points[idx].y() - query.y()
      let dist = (dx * dx + dy * dy).sqrt()
      let (_, cur_dist) = best[0]
      if dist < cur_dist {
        best[0] = (idx, dist)
      }
    }
    return
  }
  let diff = if node.axis == 0 {
    query.x() - node.split_val
  } else {
    query.y() - node.split_val
  }
  let (near, far) = if diff < 0.0 {
    (node.left, node.right)
  } else {
    (node.right, node.left)
  }
  bucket_pr_nearest_rec(nodes, near, points, query, best)
  let (_, cur_dist2) = best[0]
  if diff.abs() < cur_dist2 {
    bucket_pr_nearest_rec(nodes, far, points, query, best)
  }
}

///|
/// Find nearest neighbor in bucket PR k-d tree. / 桶 PR k-d 树最近邻。
pub fn bucket_pr_nearest(
  nodes : Array[BucketPRNode],
  points : Array[@core.Point2D],
  query : @core.Point2D,
) -> (Int32, Double)? {
  if nodes.length() == 0 {
    return None
  }
  let best : Array[(Int32, Double)] = [(-1, 999999999.0)]
  bucket_pr_nearest_rec(nodes, nodes.length() - 1, points, query, best)
  let (best_idx, _) = best[0]
  if best_idx >= 0 {
    Some(best[0])
  } else {
    None
  }
}

///|
/// Count total points in the tree. / 统计树中总点数。
pub fn bucket_pr_count(nodes : Array[BucketPRNode]) -> Int32 {
  let mut count = 0
  for i in 0..<nodes.length() {
    if nodes[i].is_leaf {
      count += nodes[i].bucket.length()
    }
  }
  count
}
