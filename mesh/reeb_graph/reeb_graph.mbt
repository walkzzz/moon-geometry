///|
/// Type of critical point in a Reeb graph. / Reeb 图中临界点类型。
pub(all) enum CriticalType {
  Minimum
  Maximum
  Saddle
  Regular
} derive(Debug, Eq)


///|
pub extend CriticalType with @moonbitlang/core/debug.Debug::{to_repr}


///|
pub extend CriticalType with Eq::{equal, not_equal}


///|
/// A node in the Reeb graph (critical point). / Reeb 图中的节点（临界点）。
pub struct ReebNode {
  vertex_idx : Int
  level : Double
  crit_type : CriticalType
}


///|
/// Construct a Reeb node. / 构造 Reeb 节点。
pub fn ReebNode::new(
  vertex_idx : Int,
  level : Double,
  crit_type : CriticalType,
) -> ReebNode {
  { vertex_idx, level, crit_type }
}


///|
/// An edge in the Reeb graph (arc between critical points). / Reeb 图中的边（临界点之间的弧）。
pub struct ReebEdge {
  from : Int
  to : Int
}


///|
/// Construct a Reeb edge. / 构造 Reeb 边。
pub fn ReebEdge::new(from : Int, to : Int) -> ReebEdge {
  { from, to }
}
