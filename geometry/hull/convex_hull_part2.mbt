///|
/// Remove consecutive duplicate points from a sorted array.
/// 从已排序数组中移除连续重复点。
fn dedup_sorted(pts : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<pts.length() {
    let last = result.length() - 1
    if last < 0 || !result[last].equals(pts[i]) {
      result.push(pts[i])
    }
  }
  result
}
