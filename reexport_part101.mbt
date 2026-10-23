///|
pub fn skip_quadtree_new(cx : Double, cy : Double, size : Double, max_level : Int) -> SkipQuadtree {
  @skip_quadtree.skip_quadtree_new(cx, cy, size, max_level)
}

///|
pub fn skip_quadtree_insert(tree : SkipQuadtree, p : Point2D) -> Unit {
  @skip_quadtree.skip_quadtree_insert(tree, p)
}

///|
pub fn skip_quadtree_query(tree : SkipQuadtree, min_x : Double, min_y : Double, max_x : Double, max_y : Double) -> Array[Point2D] {
  @skip_quadtree.skip_quadtree_query(tree, min_x, min_y, max_x, max_y)
}

///|
pub fn skip_quadtree_count(tree : SkipQuadtree) -> Int {
  @skip_quadtree.skip_quadtree_count(tree)
}

// ---------------------------------------------------------------------------
// loose_octree: Loose octree / 松散八叉树
// ---------------------------------------------------------------------------

///|
pub type LooseOctNode = @loose_octree.LooseOctNode

///|
pub fn loose_octree_new(cx : Double, cy : Double, cz : Double, size : Double, loose_factor : Double, max_depth : Int) -> LooseOctNode {
  @loose_octree.loose_octree_new(cx, cy, cz, size, loose_factor, max_depth)
}

///|
pub fn loose_octree_insert(node : LooseOctNode, p : Point3D) -> Unit {
  @loose_octree.loose_octree_insert(node, p)
}