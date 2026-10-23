///|
/// Traverse the boundary of a face starting from a half-edge. / 从半边开始遍历面的边界。
pub fn DCEL::trace_face(dcel : DCEL, start_he : Int32) -> Array[Int32] {
  let result : Array[Int32] = []
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
