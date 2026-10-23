///|
/// Check if a polygon is y-monotone (single chain from top to bottom). / 检查多边形是否 y-单调（从顶到底的单链）。
pub fn is_y_monotone(poly : Array[@core.Point2D]) -> Bool {
  let n = poly.length()
  if n < 3 {
    return false
  }
  let mut top_idx = 0
  let mut bottom_idx = 0
  for i in 1..<n {
    if poly[i].y() > poly[top_idx].y() {
      top_idx = i
    }
    if poly[i].y() < poly[bottom_idx].y() {
      bottom_idx = i
    }
  }
  let left_chain : Array[Int32] = []
  let right_chain : Array[Int32] = []
  let mut i = top_idx
  while i != bottom_idx {
    left_chain.push(i)
    i = (i + 1) % n
  }
  left_chain.push(bottom_idx)
  i = top_idx
  while i != bottom_idx {
    right_chain.push(i)
    i = (i - 1 + n) % n
  }
  right_chain.push(bottom_idx)
  for k in 1..<left_chain.length() {
    if poly[left_chain[k]].y() > poly[left_chain[k - 1]].y() {
      return false
    }
  }
  for k in 1..<right_chain.length() {
    if poly[right_chain[k]].y() > poly[right_chain[k - 1]].y() {
      return false
    }
  }
  true
}
