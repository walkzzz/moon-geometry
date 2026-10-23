///|
/// Midpoint of the interval. / 区间中点。
pub fn interval_midpoint(i : Interval) -> Double {
  @interval.Interval::midpoint(i)
}


///|
/// Check if two intervals overlap. / 检查两区间是否重叠。
pub fn interval_overlaps(a : Interval, b : Interval) -> Bool {
  @interval.Interval::overlaps(a, b)
}


///|
/// Check if interval a contains interval b. / 检查区间 a 是否包含区间 b。
pub fn interval_contains_interval(a : Interval, b : Interval) -> Bool {
  @interval.Interval::contains_interval(a, b)
}
// ---------------------------------------------------------------------------
// aabb_tree: AABB tree / AABB 树
// ---------------------------------------------------------------------------


///|
/// AABB tree node type. / AABB 树节点类型。
pub type AABBNode = @aabb_tree.AABBNode


///|
/// Build an AABB tree from rectangles. / 由矩形数组构建 AABB 树。
pub fn build_aabb_tree(rects : Array[Rectangle]) -> Array[AABBNode] {
  @aabb_tree.build_aabb_tree(rects)
}
