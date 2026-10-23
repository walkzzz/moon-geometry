///|
/// Get label at (col, row). / 获取 (col, row) 处的标签。
pub fn WatershedResult::get(r : WatershedResult, col : Int, row : Int) -> Int {
  if col < 0 || col >= r.cols || row < 0 || row >= r.rows {
    return 0
  }
  r.labels[row * r.cols + col]
}
