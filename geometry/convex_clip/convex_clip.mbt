///|
/// Clip a convex polygon by a line, keeping the left side. / 用直线裁剪凸多边形，保留左侧。
pub fn clip_convex_by_line(
  poly : @core.Polygon,
  line : @core.Line,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = poly.vertices.length()
  if n == 0 {
    return result
  }
  for i in 0..<n {
    let cur = poly.vertices[i]
    let nxt = poly.vertices[(i + 1) % n]
    let cur_val = line.a * cur.x() + line.b * cur.y() + line.c
    let nxt_val = line.a * nxt.x() + line.b * nxt.y() + line.c
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
