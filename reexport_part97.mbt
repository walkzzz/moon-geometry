///|
pub fn rtree_new(max_entries : Int) -> RTree {
  @rtree.rtree_new(max_entries)
}

///|
pub fn rtree_insert(tree : RTree, p : Point2D) -> Unit {
  @rtree.rtree_insert(tree, p)
}

///|
pub fn rtree_range_query(tree : RTree, min_x : Double, min_y : Double, max_x : Double, max_y : Double) -> Array[Point2D] {
  @rtree.rtree_range_query(tree, min_x, min_y, max_x, max_y)
}

///|
pub fn rtree_size(tree : RTree) -> Int {
  @rtree.rtree_size(tree)
}

///|
pub fn rtree_get_all(tree : RTree) -> Array[Point2D] {
  @rtree.rtree_get_all(tree)
}

// ---------------------------------------------------------------------------
// octree: Octree / 八叉树
// ---------------------------------------------------------------------------

///|
pub type OctreeNode = @octree.OctreeNode

///|
pub fn octree_new(cx : Double, cy : Double, cz : Double, size : Double, capacity : Int, max_depth : Int) -> OctreeNode {
  @octree.octree_new(cx, cy, cz, size, capacity, max_depth)
}