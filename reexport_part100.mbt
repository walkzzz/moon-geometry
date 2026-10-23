///|
pub fn cover_tree_count(tree : CoverTree) -> Int {
  @cover_tree.cover_tree_count(tree)
}

// ---------------------------------------------------------------------------
// interval_tree: Interval tree / 区间树
// ---------------------------------------------------------------------------

///|
pub type IntervalEntry = @interval_tree.Interval

///|
pub type IntervalNode = @interval_tree.IntervalNode

///|
pub fn interval_tree_build(intervals : Array[IntervalEntry]) -> IntervalNode? {
  @interval_tree.interval_tree_build(intervals)
}

///|
pub fn interval_tree_query(node : IntervalNode?, x : Double) -> Array[IntervalEntry] {
  @interval_tree.interval_tree_query(node, x)
}

///|
pub fn interval_tree_count(node : IntervalNode?) -> Int {
  @interval_tree.interval_tree_count(node)
}

// ---------------------------------------------------------------------------
// skip_quadtree: Skip quadtree / 跳跃四叉树
// ---------------------------------------------------------------------------

///|
pub type SkipQuadtree = @skip_quadtree.SkipQuadtree