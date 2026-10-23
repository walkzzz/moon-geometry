///|
/// Centroid of a polygon using the weighted-area method.
/// Returns the origin for degenerate polygons.
/// 退化多边形返回原点。
pub fn polygon_centroid(poly : @core.Polygon) -> @core.Point2D {
  let verts = poly.vertices
  let n = verts.length()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  if n == 1 {
    return verts[0]
  }
  if n == 2 {
    return @core.Point2D::new(
      (verts[0].x + verts[1].x) / 2.0,
      (verts[0].y + verts[1].y) / 2.0,
    )
  }
  let mut cx = 0.0
  let mut cy = 0.0
  let mut area2 = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let cross = verts[i].x * verts[j].y - verts[j].x * verts[i].y
    area2 += cross
    cx += (verts[i].x + verts[j].x) * cross
    cy += (verts[i].y + verts[j].y) * cross
  }
  if area2 == 0.0 {
    // Degenerate: fall back to vertex average
    let mut sx = 0.0
    let mut sy = 0.0
    for v in verts {
      sx += v.x
      sy += v.y
    }
    return @core.Point2D::new(sx / n.to_double(), sy / n.to_double())
  }
  @core.Point2D::new(cx / (3.0 * area2), cy / (3.0 * area2))
}
