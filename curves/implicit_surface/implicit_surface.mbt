///|
/// # Implicit Surface
/// # 隐式曲面
///
/// Implicit surface f(x, y, z) = 0: normal and curvature computation.
/// 隐式曲面 f(x, y, z) = 0：法向与曲率计算。

///|
/// Unit normal at a point on the implicit surface (normalized gradient).
/// 隐式曲面上一点处的单位法向量（归一化梯度）。
pub fn surface_normal(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  p : @core.Point3D,
) -> @core.Point3D {
  let gx = fx(p.x, p.y, p.z)
  let gy = fy(p.x, p.y, p.z)
  let gz = fz(p.x, p.y, p.z)
  let norm = (gx * gx + gy * gy + gz * gz).sqrt()
  if norm < 0.0000000001 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  @core.Point3D::new(gx / norm, gy / norm, gz / norm)
}

///|
/// Gradient (unnormalized normal) at a point. / 一点处的梯度（未归一化法向）。
pub fn surface_gradient(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  p : @core.Point3D,
) -> @core.Point3D {
  @core.Point3D::new(fx(p.x, p.y, p.z), fy(p.x, p.y, p.z), fz(p.x, p.y, p.z))
}

///|
/// Gaussian curvature of the implicit surface at a point.
/// K = (n^T * adj(S) * n) / |grad|^2, where S is the shape operator.
/// 隐式曲面在一点处的高斯曲率。
pub fn gaussian_curvature(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  fxx : (Double, Double, Double) -> Double,
  fxy : (Double, Double, Double) -> Double,
  fxz : (Double, Double, Double) -> Double,
  fyy : (Double, Double, Double) -> Double,
  fyz : (Double, Double, Double) -> Double,
  fzz : (Double, Double, Double) -> Double,
  p : @core.Point3D,
) -> Double {
  let x = p.x
  let y = p.y
  let z = p.z
  let a = fx(x, y, z)
  let b = fy(x, y, z)
  let c = fz(x, y, z)
  let aa = fxx(x, y, z)
  let ab = fxy(x, y, z)
  let ac = fxz(x, y, z)
  let bb = fyy(x, y, z)
  let bc = fyz(x, y, z)
  let cc = fzz(x, y, z)
  let g2 = a * a + b * b + c * c
  if g2 < 0.0000000001 {
    return 0.0
  }
  let g4 = g2 * g2
  let term1 = a * a * (bb * cc - bc * bc)
  let term2 = b * b * (aa * cc - ac * ac)
  let term3 = c * c * (aa * bb - ab * ab)
  let term4 = 2.0 * a * b * (ac * bc - ab * cc)
  let term5 = 2.0 * a * c * (ab * bc - ac * bb)
  let term6 = 2.0 * b * c * (ab * ac - aa * bc)
  (term1 + term2 + term3 + term4 + term5 + term6) / g4
}
