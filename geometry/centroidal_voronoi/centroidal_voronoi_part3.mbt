///|
/// Clip polygon by bisector half-plane (keep side closer to s1). / 用平分线半平面裁剪多边形（保留靠近 s1 的一侧）。
fn clip_by_bisector(
  poly : Array[@core.Point2D],
  s1 : @core.Point2D,
  s2 : @core.Point2D,
) -> Array[@core.Point2D] {
  let nx = s2.x() - s1.x()
  let ny = s2.y() - s1.y()
  let c = ((s2.x() * s2.x() + s2.y() * s2.y()) -
    (s1.x() * s1.x() + s1.y() * s1.y())) / 2.0
  let result : Array[@core.Point2D] = []
  let m = poly.length()
  if m == 0 {
    return result
  }
  for i in 0..<m {
    let curr = poly[i]
    let next = poly[(i + 1) % m]
    let dc = curr.x() * nx + curr.y() * ny - c
    let dn = next.x() * nx + next.y() * ny - c
    let curr_inside = dc <= 0.0
    let next_inside = dn <= 0.0
    if curr_inside {
      result.push(curr)
    }
    if curr_inside != next_inside {
      let t = dc / (dc - dn)
      result.push(@core.Point2D::new(
        curr.x() + t * (next.x() - curr.x()),
        curr.y() + t * (next.y() - curr.y()),
      ))
    }
  }
  result
}
