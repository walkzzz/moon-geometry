///|
pub type MetricNode = @metric_tree.MetricNode

///|
pub fn build_metric_tree(pts : Array[Point2D]) -> MetricNode? {
  @metric_tree.build_metric_tree(pts)
}

///|
pub fn metric_tree_query(node : MetricNode?, q : Point2D, r : Double) -> Array[Point2D] {
  @metric_tree.metric_tree_query(node, q, r)
}

///|
pub fn metric_tree_count(node : MetricNode?) -> Int {
  @metric_tree.metric_tree_count(node)
}

///|
pub fn metric_tree_nearest(node : MetricNode?, q : Point2D) -> Point2D? {
  @metric_tree.metric_tree_nearest(node, q)
}

// ---------------------------------------------------------------------------
// dcel: doubly connected edge list / 双向连接边表
// ---------------------------------------------------------------------------

///|
pub type HalfEdge = @dcel.HalfEdge

///|
pub type DcelFace = @dcel.Face