///|
/// K-th smallest element. / 第 k 小元素。
pub fn kth_element(arr : Array[Double], k : Int) -> Double? {
  @sort_search.kth_element(arr, k)
}


///|
/// Merge two sorted arrays. / 合并两个有序数组。
pub fn merge_sorted(a : Array[Double], b : Array[Double]) -> Array[Double] {
  @sort_search.merge_sorted(a, b)
}

// ---------------------------------------------------------------------------
// bucket_pr: bucket PR k-d tree / 桶 PR k-d 树
// ---------------------------------------------------------------------------


///|
/// Bucket PR node type. / 桶 PR 节点类型。
pub type BucketPRNode = @bucket_pr.BucketPRNode


///|
/// Build a bucket PR k-d tree. / 构建桶 PR k-d 树。
pub fn build_bucket_pr(points : Array[Point2D], bucket_size : Int) -> Array[BucketPRNode] {
  @bucket_pr.build_bucket_pr(points, bucket_size)
}


///|
/// Nearest neighbor in bucket PR tree. / 桶 PR 树最近邻。
pub fn bucket_pr_nearest(
  nodes : Array[BucketPRNode],
  points : Array[Point2D],
  query : Point2D,
) -> (Int, Double)? {
  @bucket_pr.bucket_pr_nearest(nodes, points, query)
}


///|
/// Count points in bucket PR tree. / 统计桶 PR 树点数。
pub fn bucket_pr_count(nodes : Array[BucketPRNode]) -> Int {
  @bucket_pr.bucket_pr_count(nodes)
}

// ---------------------------------------------------------------------------
// spatial_hash: spatial hash table / 空间哈希表
// ---------------------------------------------------------------------------


///|
/// Spatial hash type. / 空间哈希类型。
pub type SpatialHash = @spatial_hash.SpatialHash
