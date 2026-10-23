///|
/// Build a spatial hash. / 构建空间哈希。
pub fn build_spatial_hash(points : Array[Point2D], cell_size : Double) -> SpatialHash {
  @spatial_hash.build_spatial_hash(points, cell_size)
}


///|
/// Query points within radius. / 查询半径内的点。
pub fn spatial_hash_query_radius(
  hash : SpatialHash,
  center : Point2D,
  radius : Double,
) -> Array[Int] {
  @spatial_hash.spatial_hash_query_radius(hash, center, radius)
}


///|
/// Query points within rectangle. / 查询矩形内的点。
pub fn spatial_hash_query_rect(hash : SpatialHash, rect : Rectangle) -> Array[Int] {
  @spatial_hash.spatial_hash_query_rect(hash, rect)
}


///|
/// Query nearby points. / 查询邻近点。
pub fn spatial_hash_nearby(hash : SpatialHash, p : Point2D) -> Array[Int] {
  @spatial_hash.spatial_hash_nearby(hash, p)
}


///|
/// Number of points. / 点数。
pub fn spatial_hash_size(hash : SpatialHash) -> Int {
  @spatial_hash.spatial_hash_size(hash)
}

// ---------------------------------------------------------------------------
// bvh: bounding volume hierarchy / 层次包围体
// ---------------------------------------------------------------------------


///|
/// BVH node type. / BVH 节点类型。
pub type BVHNode = @bvh.BVHNode


///|
/// Build a BVH. / 构建 BVH。
pub fn build_bvh(rects : Array[Rectangle]) -> Array[BVHNode] {
  @bvh.build_bvh(rects)
}
