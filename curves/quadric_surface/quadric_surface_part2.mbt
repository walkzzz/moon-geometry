///|
/// Gradient (normal direction) at a point. / 一点处的梯度（法向）。
pub fn Quadric::gradient(q : Quadric, p : @core.Point3D) -> @core.Point3D {
  let x = p.x
  let y = p.y
  let z = p.z
  let gx = 2.0 * q.a * x + q.d * y + q.e * z + q.g
  let gy = q.d * x + 2.0 * q.b * y + q.f * z + q.h
  let gz = q.e * x + q.f * y + 2.0 * q.c * z + q.i
  @core.Point3D::new(gx, gy, gz)
}

///|
/// Unit normal at a point on the surface. / 曲面上一点处的单位法向量。
pub fn Quadric::normal(q : Quadric, p : @core.Point3D) -> @core.Point3D {
  let g = Quadric::gradient(q, p)
  let norm = (g.x * g.x + g.y * g.y + g.z * g.z).sqrt()
  if norm < 0.0000000001 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  @core.Point3D::new(g.x / norm, g.y / norm, g.z / norm)
}

///|
/// Center of the quadric (solve gradient = 0). Returns None for paraboloids.
/// 二次曲面中心（解梯度=0），抛物面返回 None。
pub fn Quadric::center(q : Quadric) -> @core.Point3D? {
  let eps = 0.0000000001
  let m : Array[Array[Double]] = [
    [2.0 * q.a, q.d, q.e],
    [q.d, 2.0 * q.b, q.f],
    [q.e, q.f, 2.0 * q.c],
  ]
  let rhs = [-q.g, -q.h, -q.i]
  let det = m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
    m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
    m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])
  if det.abs() < eps {
    return None
  }
  let cx = (
      rhs[0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
      m[0][1] * (rhs[1] * m[2][2] - m[1][2] * rhs[2]) +
      m[0][2] * (rhs[1] * m[2][1] - m[1][1] * rhs[2])
    ) /
    det
  let cy = (
      m[0][0] * (rhs[1] * m[2][2] - m[1][2] * rhs[2]) -
      rhs[0] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
      m[0][2] * (m[1][0] * rhs[2] - rhs[1] * m[2][0])
    ) /
    det
  let cz = (
      m[0][0] * (m[1][1] * rhs[2] - rhs[1] * m[2][1]) -
      m[0][1] * (m[1][0] * rhs[2] - rhs[1] * m[2][0]) +
      rhs[0] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])
    ) /
    det
  Some(@core.Point3D::new(cx, cy, cz))
}

///|
/// Trace of the quadratic form (A + B + C). / 二次型的迹（A + B + C）。
pub fn Quadric::trace(q : Quadric) -> Double {
  q.a + q.b + q.c
}
