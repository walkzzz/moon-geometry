///|
/// Query by y-range only. / 仅按 y 范围查询。
pub fn range_query_y(
  tree : RangeTree,
  y_lo : Double,
  y_hi : Double,
) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<tree.sorted_y.length() {
    let idx = tree.sorted_y[i]
    let py = tree.points[idx].y()
    if py > y_hi {
      return result
    }
    if py >= y_lo {
      result.push(idx)
    }
  }
  result
}


///|
/// Number of points in the tree. / 范围树中的点数。
pub fn range_tree_size(tree : RangeTree) -> Int {
  tree.points.length()
}