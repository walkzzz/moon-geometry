///|
/// Query all point indices within a grid cell. / 查询网格单元内的点索引。
pub fn grid_query_cell(grid : GridIndex, p : @core.Point2D) -> Array[Int32] {
  let key = grid_key(p, grid.cell_size)
  let result : Array[Int32] = []
  for i in 0..<grid.points.length() {
    if grid.cell_keys[i] == key {
      result.push(i)
    }
  }
  result
}

///|
/// Number of points in the grid. / 网格中的点数。
pub fn grid_size(grid : GridIndex) -> Int32 {
  grid.points.length()
}
