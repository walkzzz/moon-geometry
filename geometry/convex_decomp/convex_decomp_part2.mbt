///|
/// Decompose a simple polygon into convex pieces (reflex vertex splitting). / 将简单多边形分解为凸块（反射顶点分割）。
pub fn convex_decomposition(
  poly : Array[@core.Point2D],
) -> Array[Array[@core.Point2D]] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  if is_convex_polygon(poly) {
    return [poly]
  }
  let result : Array[Array[@core.Point2D]] = []
  let pieces : Array[Array[@core.Point2D]] = []
  pieces.push(poly)
  while pieces.length() > 0 {
    let piece = pieces.remove(pieces.length() - 1)
    ignore(pieces.length())
    if is_convex_polygon(piece) {
      result.push(piece)
    } else {
      let pn = piece.length()
      let mut reflex_idx = -1
      for i in 0..<pn {
        let prev = piece[(i - 1 + pn) % pn]
        let curr = piece[i]
        let next = piece[(i + 1) % pn]
        let cross = (curr.x() - prev.x()) * (next.y() - curr.y()) -
          (curr.y() - prev.y()) * (next.x() - curr.x())
        if cross < 0.0 {
          reflex_idx = i
          break
        }
      }
      if reflex_idx < 0 {
        result.push(piece)
      } else {
        let ri = reflex_idx
        let part1 : Array[@core.Point2D] = []
        let part2 : Array[@core.Point2D] = []
        for i in 0..<pn {
          if i <= ri {
            part1.push(piece[i])
          }
          if i >= ri {
            part2.push(piece[i])
          }
        }
        if part1.length() >= 3 {
          pieces.push(part1)
        }
        if part2.length() >= 3 {
          pieces.push(part2)
        }
        if part1.length() < 3 && part2.length() < 3 {
          result.push(piece)
        }
      }
    }
  }
  result
}
