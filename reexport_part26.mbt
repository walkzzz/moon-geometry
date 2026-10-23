///|
/// Query overlapping rectangle indices. / 查询重叠矩形索引。
pub fn query_aabb(nodes : Array[AABBNode], query : Rectangle) -> Array[Int] {
  @aabb_tree.query_aabb(nodes, query)
}


///|
/// Query rectangle indices containing a point. / 查询包含点的矩形索引。
pub fn query_point_aabb(nodes : Array[AABBNode], p : Point2D) -> Array[Int] {
  @aabb_tree.query_point_aabb(nodes, p)
}


///|
/// Count leaf nodes. / 统计叶子节点数。
pub fn count_leaves(nodes : Array[AABBNode]) -> Int {
  @aabb_tree.count_leaves(nodes)
}

// ---------------------------------------------------------------------------
// hash: geometric hashing / 几何哈希
// ---------------------------------------------------------------------------


///|
/// Grid cell index of a 2D point. / 二维点网格单元索引。
pub fn cell_index(p : Point2D, cell_size : Double) -> (Int, Int) {
  @hash.cell_index(p, cell_size)
}


///|
/// Grid cell index of a 3D point. / 三维点网格单元索引。
pub fn cell_index_3d(p : Point3D, cell_size : Double) -> (Int, Int, Int) {
  @hash.cell_index_3d(p, cell_size)
}


///|
/// Hash a 2D point to table index. / 二维点哈希到表索引。
pub fn cell_hash(p : Point2D, cell_size : Double, table_size : Int) -> Int {
  @hash.cell_hash(p, cell_size, table_size)
}


///|
/// Hash a 3D point to table index. / 三维点哈希到表索引。
pub fn cell_hash_3d(p : Point3D, cell_size : Double, table_size : Int) -> Int {
  @hash.cell_hash_3d(p, cell_size, table_size)
}
