///|
/// A* result. / A* 结果。
pub type AStarResult = @a_star.AStarResult


///|
/// A* heuristic type. / A* 启发式类型。
pub type AStarHeuristic = @a_star.AStarHeuristic


///|
/// A* graph node. / A* 图节点。
pub type AStarGraphNode = @a_star.AStarGraphNode


///|
/// Construct an A* grid. / 构造 A* 网格。
pub fn astar_grid_new(width : Int, height : Int) -> AStarGrid {
  @a_star.AStarGrid::new(width, height)
}


///|
/// Mark a cell as blocked. / 标记格子为障碍。
pub fn astar_grid_set_blocked(grid : AStarGrid, x : Int, y : Int) -> Unit {
  @a_star.AStarGrid::set_blocked(grid, x, y)
}


///|
/// Check if a cell is blocked. / 检查格子是否为障碍。
pub fn astar_grid_is_blocked(grid : AStarGrid, x : Int, y : Int) -> Bool {
  @a_star.AStarGrid::is_blocked(grid, x, y)
}
