///|
/// Construct A* result. / 构造 A* 结果。
pub fn AStarResult::new(
  path : Array[(Int32, Int32)],
  success : Bool,
  cost : Double,
) -> AStarResult {
  { path, success, cost, }
}

///|
/// Heuristic type for A* search. / A* 搜索启发式类型。
pub(all) enum AStarHeuristic {
  Manhattan
  Euclidean
  Chebyshev
}
