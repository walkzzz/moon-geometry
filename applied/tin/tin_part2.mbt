///|
/// Barycentric interpolation of elevation at a 2D point. / 二维点处的高程重心插值。
/// Returns None if the point is outside all triangles. / 点在所有三角形外时返回 None。
pub fn TIN::interpolate(t : TIN, p : @core.Point2D) -> Double? {
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    if area.abs() < 0.0000000001 {
      continue
    }
    let w0 = ((b.x - p.x) * (c.y - p.y) - (c.x - p.x) * (b.y - p.y)) /
      (2.0 * area)
    let w1 = ((c.x - p.x) * (a.y - p.y) - (a.x - p.x) * (c.y - p.y)) /
      (2.0 * area)
    let w2 = 1.0 - w0 - w1
    if w0 >= -0.0000000001 && w1 >= -0.0000000001 && w2 >= -0.0000000001 {
      let z = w0 * a.z + w1 * b.z + w2 * c.z
      return Some(z)
    }
  }
  None
}
