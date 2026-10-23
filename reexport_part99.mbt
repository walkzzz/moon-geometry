///|
pub type VPNode = @vp_tree.VPNode

///|
pub fn vp_tree_build(points : Array[Point2D]) -> VPNode? {
  @vp_tree.vp_tree_build(points)
}

///|
pub fn vp_tree_knn(root : VPNode?, query : Point2D, k : Int) -> Array[Point2D] {
  @vp_tree.vp_tree_knn(root, query, k)
}

///|
pub fn vp_tree_count(root : VPNode?) -> Int {
  @vp_tree.vp_tree_count(root)
}

// ---------------------------------------------------------------------------
// cover_tree: Cover tree / 覆盖树
// ---------------------------------------------------------------------------

///|
pub type CoverTree = @cover_tree.CoverTree

///|
pub fn cover_tree_build(points : Array[Point2D]) -> CoverTree {
  @cover_tree.cover_tree_build(points)
}

///|
pub fn cover_tree_radius_search(tree : CoverTree, query : Point2D, radius : Double) -> Array[Point2D] {
  @cover_tree.cover_tree_radius_search(tree, query, radius)
}