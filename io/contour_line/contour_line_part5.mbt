///|
/// Label a cell with its case index (0-15) for a given level. / 用给定等值层的情形索引（0-15）标记单元。
pub fn label_cell(
  g : ContourGrid,
  col : Int32,
  row : Int32,
  level : Double,
) -> Int32 {
  if col < 0 || col >= g.cols - 1 || row < 0 || row >= g.rows - 1 {
    return -1
  }
  let v00 = grid_get(g, col, row)
  let v10 = grid_get(g, col + 1, row)
  let v11 = grid_get(g, col + 1, row + 1)
  let v01 = grid_get(g, col, row + 1)
  let mut code = 0
  if v00 > level {
    code += 1
  }
  if v10 > level {
    code += 2
  }
  if v11 > level {
    code += 4
  }
  if v01 > level {
    code += 8
  }
  code
}
