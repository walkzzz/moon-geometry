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
