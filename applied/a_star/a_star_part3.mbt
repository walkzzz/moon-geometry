///|
/// Check if a cell is blocked. / 检查格子是否为障碍。
pub fn AStarGrid::is_blocked(self : AStarGrid, x : Int, y : Int) -> Bool {
  if x < 0 || x >= self.width || y < 0 || y >= self.height {
    return true
  }
  self.blocked[y * self.width + x]
}


///|
/// A* path planning result. / A* 路径规划结果。
pub struct AStarResult {
  path : Array[(Int, Int)]
  success : Bool
  cost : Double
}
