///|
/// Build a bucket PR k-d tree. / 构建桶 PR k-d 树。
pub fn build_bucket_pr(
  points : Array[@core.Point2D],
  bucket_size : Int,
) -> Array[BucketPRNode] {
  if points.length() == 0 {
    return []
  }
  let nodes : Array[BucketPRNode] = []
  let indices : Array[Int] = []
  for i in 0..<points.length() {
    indices.push(i)
  }
  ignore(bucket_pr_build_rec(points, indices, 0, bucket_size, nodes))
  nodes
}

fn bucket_pr_nearest_rec(
  nodes : Array[BucketPRNode],
  node_idx : Int,
  points : Array[@core.Point2D],
  query : @core.Point2D,
  best : Array[(Int, Double)],
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
