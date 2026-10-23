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
