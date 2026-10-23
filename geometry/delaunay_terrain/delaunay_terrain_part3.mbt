///|
/// Slope (radians) over the entire terrain (average). / 整个地形的平均坡度（弧度）。
pub fn Terrain::average_slope(t : Terrain) -> Double {
  let n = t.triangles.length()
  if n == 0 {
    return 0.0
  }
  let mut total = 0.0
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    if area.abs() < 0.0000000001 {
      continue
    }
    let dz_dx = ((b.z - a.z) * (c.y - a.y) - (c.z - a.z) * (b.y - a.y)) / (2.0 * area)
    let dz_dy = ((c.z - a.z) * (b.x - a.x) - (b.z - a.z) * (c.x - a.x)) / (2.0 * area)
    let grad = (dz_dx * dz_dx + dz_dy * dz_dy).sqrt()
    total += @math.atan(grad)
  }
  total / n.to_double()
}
