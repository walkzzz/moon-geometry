///|
/// Check if a polygon is convex. / 检查多边形是否为凸多边形。
pub fn is_convex_polygon(poly : Array[@core.Point2D]) -> Bool {
  @polygon.is_convex(@core.Polygon::new(poly))
}

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

///|
/// Count the number of convex pieces in a decomposition. / 计算凸分解的块数。
pub fn convex_decomp_count(poly : Array[@core.Point2D]) -> Int32 {
  convex_decomposition(poly).length()
}

///|
/// Lower bound on convex decomposition pieces (reflex vertices + 1). / 凸分解块数下界（反射顶点数 + 1）。
pub fn convex_decomp_lower_bound(poly : Array[@core.Point2D]) -> Int32 {
  let n = poly.length()
  if n < 3 {
    return 0
  }
  let mut reflex_count = 0
  for i in 0..<n {
    let prev = poly[(i - 1 + n) % n]
    let curr = poly[i]
    let next = poly[(i + 1) % n]
    let cross = (curr.x() - prev.x()) * (next.y() - curr.y()) -
      (curr.y() - prev.y()) * (next.x() - curr.x())
    if cross < 0.0 {
      reflex_count += 1
    }
  }
  reflex_count + 1
}

///|
/// Total area of all convex pieces. / 所有凸块的总面积。
pub fn convex_decomp_area(poly : Array[@core.Point2D]) -> Double {
  let pieces = convex_decomposition(poly)
  let mut total = 0.0
  for piece in pieces {
    let pn = piece.length()
    let mut area = 0.0
    for i in 0..<pn {
      let j = (i + 1) % pn
      area += piece[i].x() * piece[j].y() - piece[j].x() * piece[i].y()
    }
    total += area.abs() / 2.0
  }
  total
}
