///|
/// Watershed result: label for each cell (0 = unlabeled). / 分水岭结果：每个像元的标签（0 = 未标记）。
pub struct WatershedResult {
  cols : Int32
  rows : Int32
  labels : Array[Int32]
}

///|
/// Number of columns. / 列数。
pub fn WatershedResult::cols(r : WatershedResult) -> Int32 {
  r.cols
}

///|
/// Number of rows. / 行数。
pub fn WatershedResult::rows(r : WatershedResult) -> Int32 {
  r.rows
}
