///|
/// Count visible vertices from a point. / 计算从一点可见的顶点数。
pub fn visible_vertex_count(
  poly : Array[@core.Point2D],
  pt : @core.Point2D,
) -> Int {
  let mut count = 0
  for v in poly {
    if is_visible(poly, pt, v) {
      count += 1
    }
  }
  count
}