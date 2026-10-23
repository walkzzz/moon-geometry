///|
/// Check if a polygon is x-monotone. / 检查多边形是否 x-单调。
pub fn is_x_monotone(
  poly : Array[@core.Point2D],
) -> Bool {
  let n = poly.length()
  if n < 3 {
    return false
  }
  let mut left_idx = 0
  let mut right_idx = 0
  for i in 1..<n {
    if poly[i].x() < poly[left_idx].x() {
      left_idx = i
    }
    if poly[i].x() > poly[right_idx].x() {
      right_idx = i
    }
  }
  let upper : Array[Int] = []
  let lower : Array[Int] = []
  let mut i = left_idx
  while i != right_idx {
    upper.push(i)
    i = (i + 1) % n
  }
  upper.push(right_idx)
  i = left_idx
  while i != right_idx {
    lower.push(i)
    i = (i - 1 + n) % n
  }
  lower.push(right_idx)
  for k in 1..<upper.length() {
    if poly[upper[k]].x() < poly[upper[k - 1]].x() {
      return false
    }
  }
  for k in 1..<lower.length() {
    if poly[lower[k]].x() < poly[lower[k - 1]].x() {
      return false
    }
  }
  true
}
