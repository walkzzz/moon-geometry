///|
/// Normalize plane normal. / 归一化平面法向量。
pub fn plane_normalize(plane : Plane) -> Plane {
  @plane.Plane::normalize(plane)
}


///|
/// Project point onto plane. / 将点投影到平面。
pub fn plane_project(plane : Plane, p : Point3D) -> Point3D {
  @plane.Plane::project(plane, p)
}
// ---------------------------------------------------------------------------
// kdtree: k-d tree / K-d 树
// ---------------------------------------------------------------------------


///|
/// K-d tree node type. / K-d 树节点类型。
pub type KDNode = @kdtree.KDNode


///|
/// Build a k-d tree. / 构建 k-d 树。
pub fn build_kdtree(points : Array[Point2D]) -> Array[KDNode] {
  @kdtree.build_kdtree(points)
}


///|
/// Nearest neighbor search. / 最近邻搜索。
pub fn kdtree_nearest(nodes : Array[KDNode], query : Point2D) -> (Int, Double)? {
  @kdtree.kdtree_nearest(nodes, query)
}


///|
/// Range query in k-d tree. / K-d 树范围查询。
pub fn kdtree_range_query(nodes : Array[KDNode], rect : Rectangle) -> Array[Int] {
  @kdtree.kdtree_range_query(nodes, rect)
}

// ---------------------------------------------------------------------------
// quadtree: quadtree / 四叉树
// ---------------------------------------------------------------------------


///|
/// Quadtree node type. / 四叉树节点类型。
pub type QuadNode = @quadtree.QuadNode
