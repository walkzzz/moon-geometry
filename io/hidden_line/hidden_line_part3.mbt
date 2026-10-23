///|
/// Interpolate z on a triangle at (x, y) using barycentric coordinates.
/// 用重心坐标在三角形上插值 (x, y) 处的 z。
pub fn triangle_z_at(
  tri : (@core.Point3D, @core.Point3D, @core.Point3D),
  x : Double,
  y : Double,
) -> Double? {
  let eps = 0.0000001
  let (a, b, c) = tri
  let det = (b.y - a.y) * (c.x - a.x) - (b.x - a.x) * (c.y - a.y)
  if det > -eps && det < eps {
    return None
  }
  let l1 = ((b.y - a.y) * (x - a.x) - (b.x - a.x) * (y - a.y)) / det
  let l2 = ((a.y - c.y) * (x - a.x) - (a.x - c.x) * (y - a.y)) / det
  let l3 = 1.0 - l1 - l2
  if l1 < -eps || l2 < -eps || l3 < -eps {
    return None
  }
  Some(l1 * a.z + l2 * b.z + l3 * c.z)
}
