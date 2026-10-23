///|
/// Orthogonal range query: find indices in [x_lo, x_hi] × [y_lo, y_hi]. / 正交范围查询。
pub fn range_query(
  tree : RangeTree,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<tree.points.length() {
    let px = tree.points[i].x()
    let py = tree.points[i].y()
    if px >= x_lo && px <= x_hi && py >= y_lo && py <= y_hi {
      result.push(i)
    }
  }
  result
}
