///|
/// Buffer a point into a circular polygon (n segments). / 将点缓冲为圆形多边形（n 段）。
pub fn point_buffer(
  center : @core.Point2D,
  radius : Double,
  n : Int32,
) -> @core.Polygon {
  let verts : Array[@core.Point2D] = []
  let segs = if n < 3 { 3 } else { n }
  for i in 0..<segs {
    let angle = 2.0 * @math.PI * i.to_double() / segs.to_double()
    let px = center.x + radius * @math.cos(angle)
    let py = center.y + radius * @math.sin(angle)
    verts.push(@core.Point2D::new(px, py))
  }
  @core.Polygon::new(verts)
}
