///|
/// # Quadric Surfaces
/// # 二次曲面
///
/// General quadric Ax^2 + By^2 + Cz^2 + Dxy + Exz + Fyz + Gx + Hy + Iz + J = 0.
/// Classification into ellipsoid / hyperboloid / paraboloid / cone / cylinder.
/// 一般二次曲面，分类为椭球面 / 双曲面 / 抛物面 / 锥面 / 柱面。


///|
/// Quadric surface type. / 二次曲面类型。
pub(all) enum QuadricType {
  Ellipsoid
  HyperboloidOneSheet
  HyperboloidTwoSheets
  EllipticParaboloid
  HyperbolicParaboloid
  EllipticCone
  EllipticCylinder
  Degenerate
}


///|
/// Quadric surface coefficients.
/// Ax^2 + By^2 + Cz^2 + Dxy + Exz + Fyz + Gx + Hy + Iz + J = 0.
/// 二次曲面系数。
pub struct Quadric {
  a : Double
  b : Double
  c : Double
  d : Double
  e : Double
  f : Double
  g : Double
  h : Double
  i : Double
  j : Double
}


///|
/// Construct a quadric from 10 coefficients. / 由 10 个系数构造二次曲面。
pub fn Quadric::new(
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double,
  g : Double,
  h : Double,
  i : Double,
  j : Double,
) -> Quadric {
  { a, b, c, d, e, f, g, h, i, j }
}


///|
/// Evaluate the quadric at a point. / 在一点求值二次曲面。
pub fn Quadric::eval(q : Quadric, p : @core.Point3D) -> Double {
  let x = p.x
  let y = p.y
  let z = p.z
  q.a * x * x +
  q.b * y * y +
  q.c * z * z +
  q.d * x * y +
  q.e * x * z +
  q.f * y * z +
  q.g * x +
  q.h * y +
  q.i * z +
  q.j
}


///|
/// Check if a point lies on the quadric. / 检查点是否在二次曲面上。
pub fn Quadric::on_surface(q : Quadric, p : @core.Point3D, eps : Double) -> Bool {
  Quadric::eval(q, p).abs() <= eps
}
