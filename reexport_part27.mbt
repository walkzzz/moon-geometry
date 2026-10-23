///|
/// Combine two hash values. / 合并两个哈希值。
pub fn hash_combine(a : Int, b : Int) -> Int {
  @hash.hash_combine(a, b)
}


///|
/// Cell indices of segment endpoints. / 线段端点单元索引。
pub fn segment_cells(seg : Segment, cell_size : Double) -> ((Int, Int), (Int, Int)) {
  @hash.segment_cells(seg, cell_size)
}


///|
/// Hash a segment to table index. / 线段哈希到表索引。
pub fn segment_hash(seg : Segment, cell_size : Double, table_size : Int) -> Int {
  @hash.segment_hash(seg, cell_size, table_size)
}

// ---------------------------------------------------------------------------
// compare: comparison predicates / 比较谓词
// ---------------------------------------------------------------------------


///|
/// Robust orientation test. / 鲁棒方向判定。
pub fn robust_orientation(a : Point2D, b : Point2D, c : Point2D) -> Int {
  @compare.robust_orientation(a, b, c)
}


///|
/// Robust left turn test. / 鲁棒左转判定。
pub fn robust_left_turn(a : Point2D, b : Point2D, c : Point2D) -> Bool {
  @compare.robust_left_turn(a, b, c)
}


///|
/// Robust right turn test. / 鲁棒右转判定。
pub fn robust_right_turn(a : Point2D, b : Point2D, c : Point2D) -> Bool {
  @compare.robust_right_turn(a, b, c)
}


///|
/// Robust collinearity test. / 鲁棒共线判定。
pub fn robust_collinear(a : Point2D, b : Point2D, c : Point2D, eps : Double) -> Bool {
  @compare.robust_collinear(a, b, c, eps)
}
