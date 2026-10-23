///|
/// Query by x-range only. / 仅按 x 范围查询。
pub fn range_query_x(
  tree : RangeTree,
  x_lo : Double,
  x_hi : Double,
) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<tree.sorted_x.length() {
    let idx = tree.sorted_x[i]
    let px = tree.points[idx].x()
    if px > x_hi {
      return result
    }
    if px >= x_lo {
      result.push(idx)
    }
  }
  result
}
