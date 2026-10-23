///|
/// Project a point onto the surface via Newton iteration along the gradient.
/// 沿梯度牛顿迭代将点投影到曲面上。
pub fn project_to_surface(
  f : (Double, Double, Double) -> Double,
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  p : @core.Point3D,
  max_iter : Int,
) -> @core.Point3D {
  let mut x = p.x
  let mut y = p.y
  let mut z = p.z
  for _ in 0..<max_iter {
    let val = f(x, y, z)
    if val.abs() < 0.0000000001 {
      return @core.Point3D::new(x, y, z)
    }
    let gx = fx(x, y, z)
    let gy = fy(x, y, z)
    let gz = fz(x, y, z)
    let g2 = gx * gx + gy * gy + gz * gz
    if g2 < 0.0000000001 {
      return @core.Point3D::new(x, y, z)
    }
    let lambda = val / g2
    x -= lambda * gx
    y -= lambda * gy
    z -= lambda * gz
  }
  @core.Point3D::new(x, y, z)
}


///|
/// Tangent plane coefficients (a, b, c, d) for a*x + b*y + c*z + d = 0 at point p.
/// 一点处的切平面系数 (a, b, c, d)，满足 a*x + b*y + c*z + d = 0。
pub fn tangent_plane(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  p : @core.Point3D,
) -> (Double, Double, Double, Double) {
  let a = fx(p.x, p.y, p.z)
  let b = fy(p.x, p.y, p.z)
  let c = fz(p.x, p.y, p.z)
  let d = -(a * p.x + b * p.y + c * p.z)
  (a, b, c, d)
}
