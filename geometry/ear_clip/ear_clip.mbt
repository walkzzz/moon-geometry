///|
/// Check if vertex i is an ear of the polygon (triangle prev-curr-next is inside and contains no other vertex). / 检查顶点 i 是否为多边形的耳（三角形 prev-curr-next 在内部且不含其他顶点）。
pub fn is_ear(
  poly : Array[@core.Point2D],
  indices : Array[Int],
  i : Int,
) -> Bool {
  let n = indices.length()
  if n < 3 {
    return false
  }
  let idx = indices[i]
  let prev_idx = indices[(i - 1 + n) % n]
  let next_idx = indices[(i + 1) % n]
  let prev = poly[prev_idx]
  let curr = poly[idx]
  let next = poly[next_idx]
  let cross = (curr.x() - prev.x()) * (next.y() - curr.y()) -
    (curr.y() - prev.y()) * (next.x() - curr.x())
  if cross <= 0.0 {
    return false
  }
  let eps = 0.000000000001
  for k in 0..<n {
    let vi = indices[k]
    if vi == prev_idx || vi == idx || vi == next_idx {
      continue
    }
    let p = poly[vi]
    let d1 = (curr.x() - prev.x()) * (p.y() - prev.y()) - (curr.y() - prev.y()) * (p.x() - prev.x())
    let d2 = (next.x() - curr.x()) * (p.y() - curr.y()) - (next.y() - curr.y()) * (p.x() - curr.x())
    let d3 = (prev.x() - next.x()) * (p.y() - next.y()) - (prev.y() - next.y()) * (p.x() - next.x())
    if d1 > eps && d2 > eps && d3 > eps {
      return false
    }
  }
  true
}
