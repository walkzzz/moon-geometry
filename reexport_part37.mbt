///|
/// Query overlapping rectangles. / 查询重叠矩形。
pub fn bvh_query(nodes : Array[BVHNode], rect : Rectangle) -> Array[Int] {
  @bvh.bvh_query(nodes, rect)
}


///|
/// Query rectangles containing a point. / 查询包含点的矩形。
pub fn bvh_query_point(nodes : Array[BVHNode], p : Point2D) -> Array[Int] {
  @bvh.bvh_query_point(nodes, p)
}


///|
/// Count leaf nodes. / 统计叶子节点数。
pub fn bvh_count_leaves(nodes : Array[BVHNode]) -> Int {
  @bvh.bvh_count_leaves(nodes)
}
// ---------------------------------------------------------------------------
// half_plane: half-plane intersection / 半平面交
// ---------------------------------------------------------------------------


///|
/// Half-plane type. / 半平面类型。
pub type HalfPlane = @half_plane.HalfPlane


///|
/// Construct a half-plane. / 构造半平面。
pub fn half_plane_new(a : Double, b : Double, c : Double) -> HalfPlane {
  @half_plane.HalfPlane::new(a, b, c)
}


///|
/// Check if point is in half-plane. / 检查点是否在半平面内。
pub fn half_plane_contains(hp : HalfPlane, p : Point2D) -> Bool {
  @half_plane.HalfPlane::contains(hp, p)
}
