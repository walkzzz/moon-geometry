///|
/// Check if two point sets are equal (same points, any order). / 检查两个点集是否相等。
pub fn point_set_equal(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  eps : Double,
) -> Bool {
  if a.length() != b.length() {
    return false
  }
  let used : Array[Bool] = []
  for _ in 0..<b.length() {
    used.push(false)
  }
  for i in 0..<a.length() {
    let mut found = false
    for j in 0..<b.length() {
      if !used[j] {
        if @core.approx_eq(a[i].x(), b[j].x(), eps) && @core.approx_eq(
          a[i].y(),
          b[j].y(),
          eps,
        ) {
          used[j] = true
          found = true
          break
        }
      }
    }
    if !found {
      return false
    }
  }
  true
}