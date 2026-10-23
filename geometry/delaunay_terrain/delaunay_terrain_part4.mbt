///|
/// Aspect (radians) at a specific point (0=East, CCW). / 指定点处的坡向（弧度，0=东，逆时针）。
pub fn Terrain::aspect_at(t : Terrain, p : @core.Point2D) -> Double? {
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
      let dz_dx = ((b.z - a.z) * (c.y - a.y) - (c.z - a.z) * (b.y - a.y)) /
        (2.0 * area)
      let dz_dy = ((c.z - a.z) * (b.x - a.x) - (b.z - a.z) * (c.x - a.x)) /
        (2.0 * area)
      return Some(@math.atan2(dz_dy, dz_dx))
    }
  }
  None
}
