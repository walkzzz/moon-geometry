///|
/// Check if two polylines intersect. / 检查两条折线是否相交。
pub fn curves_intersect(
  c1 : Array[@core.Point2D],
  c2 : Array[@core.Point2D],
) -> Bool {
  let n1 = c1.length()
  let n2 = c2.length()
  if n1 < 2 || n2 < 2 {
    return false
  }
  for i in 0..<(n1 - 1) {
    for j in 0..<(n2 - 1) {
      if segments_cross(c1[i], c1[i + 1], c2[j], c2[j + 1]) {
        return true
      }
    }
  }
  false
}