///|
/// Traverse the boundary of a face starting from a half-edge. / 从半边开始遍历面的边界。
pub fn DCEL::trace_face(dcel : DCEL, start_he : Int) -> Array[Int] {
  let result : Array[Int] = []
  let mut current = start_he
  let mut first = true
  while first || current != start_he {
    result.push(current)
    first = false
    if dcel.half_edges[current].next == -1 {
      break
    }
    current = dcel.half_edges[current].next
  }
  result
}
