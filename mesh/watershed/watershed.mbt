///|
/// Watershed result: label for each cell (0 = unlabeled). / 分水岭结果：每个像元的标签（0 = 未标记）。
pub struct WatershedResult {
  cols : Int
  rows : Int
  labels : Array[Int]
}


///|
/// Number of columns. / 列数。
pub fn WatershedResult::cols(r : WatershedResult) -> Int {
  r.cols
}


///|
/// Number of rows. / 行数。
pub fn WatershedResult::rows(r : WatershedResult) -> Int {
  r.rows
}
