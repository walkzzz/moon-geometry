///|
/// # A* Path Planning
/// # A* 路径规划
///
/// A* algorithm for grid-based and graph-based path planning with heuristics.
/// 基于网格和图的 A* 启发式路径规划算法。
///
/// ## Complexity: O(b^d) worst case, much better with good heuristic
/// ## 复杂度: 最坏 O(b^d)，好的启发式下显著更优

///|
/// A* grid for path planning. / A* 路径规划网格。
pub struct AStarGrid {
  width : Int32
  height : Int32
  blocked : Array[Bool]
}

///|
/// Construct an A* grid. / 构造 A* 网格。
pub fn AStarGrid::new(width : Int32, height : Int32) -> AStarGrid {
  { width, height, blocked: Array::make(width * height, false), }
}
