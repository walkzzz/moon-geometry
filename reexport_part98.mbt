///|
pub fn octree_insert(node : OctreeNode, p : Point3D) -> Unit {
  @octree.octree_insert(node, p)
}

///|
pub fn octree_range_query(node : OctreeNode, min_x : Double, min_y : Double, min_z : Double, max_x : Double, max_y : Double, max_z : Double) -> Array[Point3D] {
  @octree.octree_range_query(node, min_x, min_y, min_z, max_x, max_y, max_z)
}

///|
pub fn octree_size(node : OctreeNode) -> Int {
  @octree.octree_size(node)
}

// ---------------------------------------------------------------------------
// ball_tree: Ball tree / 球树
// ---------------------------------------------------------------------------

///|
pub type BallNode = @ball_tree.BallNode

///|
pub fn ball_tree_build(points : Array[Point2D]) -> BallNode? {
  @ball_tree.ball_tree_build(points)
}

///|
pub fn ball_tree_knn(root : BallNode?, query : Point2D, k : Int) -> Array[Point2D] {
  @ball_tree.ball_tree_knn(root, query, k)
}

///|
pub fn ball_tree_count(root : BallNode?) -> Int {
  @ball_tree.ball_tree_count(root)
}

// ---------------------------------------------------------------------------
// vp_tree: Vantage point tree / 基点树
// ---------------------------------------------------------------------------