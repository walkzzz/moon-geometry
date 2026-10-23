///|
/// Mark a cell as blocked. / 标记格子为障碍。
pub fn AStarGrid::set_blocked(self : AStarGrid, x : Int32, y : Int32) -> Unit {
  if x >= 0 && x < self.width && y >= 0 && y < self.height {
    self.blocked[y * self.width + x] = true
  }
}
