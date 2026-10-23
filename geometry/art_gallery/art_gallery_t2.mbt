///|
/// Place guards at every 3rd vertex (heuristic). / 每隔 3 个顶点放置一个守卫（启发式）。
pub fn art_gallery_place_guards(
  poly : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let guards : Array[@core.Point2D] = []
  let step = 3
  for i in 0..<n {
    if i % step == 0 {
      guards.push(poly[i])
    }
  }
  guards
}
