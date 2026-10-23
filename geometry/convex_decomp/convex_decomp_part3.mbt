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
