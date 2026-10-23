///|
/// Compute visibility polygon from a point (general algorithm for simple polygons). / 计算一点的可见多边形（简单多边形通用算法）。
pub fn visibility_polygon(
  poly : Array[@core.Point2D],
  pt : @core.Point2D,
) -> Array[@core.Point2D] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let visible : Array[@core.Point2D] = []
  for i in 0..<n {
    let curr = poly[i]
    if is_visible(poly, pt, curr) {
      visible.push(curr)
      continue
    }
    let prev = poly[(i - 1 + n) % n]
    let next = poly[(i + 1) % n]
    let dx_prev = prev.x() - curr.x()
    let dy_prev = prev.y() - curr.y()
    let dx_next = next.x() - curr.x()
    let dy_next = next.y() - curr.y()
    let dx_pt = pt.x() - curr.x()
    let dy_pt = pt.y() - curr.y()
    let cross1 = dx_prev * dy_pt - dy_prev * dx_pt
    let cross2 = dx_pt * dy_next - dy_pt * dx_next
    if cross1 * cross2 > 0.0 {
      visible.push(curr)
    }
  }
  visible
}
