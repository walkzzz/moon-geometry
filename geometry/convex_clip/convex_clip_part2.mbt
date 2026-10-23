///|
/// Clip a convex polygon by a half-plane a*x + b*y + c <= 0. / 用半平面裁剪凸多边形。
pub fn clip_convex_by_half_plane(
  poly : @core.Polygon,
  a : Double,
  b : Double,
  c : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = poly.vertices.length()
  if n == 0 {
    return result
  }
  for i in 0..<n {
    let cur = poly.vertices[i]
    let nxt = poly.vertices[(i + 1) % n]
    let cur_val = a * cur.x() + b * cur.y() + c
    let nxt_val = a * nxt.x() + b * nxt.y() + c
    let cur_in = cur_val <= 0.0
    let nxt_in = nxt_val <= 0.0
    if cur_in {
      result.push(cur)
    }
    if cur_in != nxt_in {
      let t = cur_val / (cur_val - nxt_val)
      result.push(
        @core.Point2D::new(
          cur.x() + (nxt.x() - cur.x()) * t,
          cur.y() + (nxt.y() - cur.y()) * t,
        ),
      )
    }
  }
  result
}
