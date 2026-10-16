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

///|
/// Mean curvature of the implicit surface at a point.
/// H = (|grad|^2 * trace(H) - grad^T * H * grad) / (2 * |grad|^3)
/// 隐式曲面在一点处的平均曲率。
pub fn mean_curvature(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  fxx : (Double, Double, Double) -> Double,
  fyy : (Double, Double, Double) -> Double,
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
  let bb = fyy(x, y, z)
  let cc = fzz(x, y, z)
  let g2 = a * a + b * b + c * c
  if g2 < 0.0000000001 {
    return 0.0
  }
  let g3 = g2 * g2.sqrt()
  let trace_h = aa + bb + cc
  let quad = a * a * aa + b * b * bb + c * c * cc
  (g2 * trace_h - quad) / (2.0 * g3)
}

///|
/// Principal curvatures (k1, k2) from Gaussian and mean curvature.
/// 由高斯曲率和平均曲率求主曲率 (k1, k2)。
pub fn principal_curvatures(k_gauss : Double, k_mean : Double) -> (Double, Double) {
  let disc = k_mean * k_mean - k_gauss
  if disc < 0.0 {
    return (k_mean, k_mean)
  }
  let sq = disc.sqrt()
  (k_mean + sq, k_mean - sq)
}

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

///|
/// Sample points on the surface within a box by rejection + Newton projection.
/// 在包围盒内通过拒绝采样加牛顿投影采样曲面上的点。
pub fn sample_surface(
  f : (Double, Double, Double) -> Double,
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  z_lo : Double,
  z_hi : Double,
  n_samples : Int,
) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  let n_side = if n_samples > 1 { n_samples } else { 2 }
  let dx = (x_hi - x_lo) / n_side.to_double()
  let dy = (y_hi - y_lo) / n_side.to_double()
  let dz = (z_hi - z_lo) / n_side.to_double()
  let mut x = x_lo
  while x < x_hi {
    let mut y = y_lo
    while y < y_hi {
      let mut z = z_lo
      while z < z_hi {
        let v = f(x, y, z)
        if v.abs() < 0.1 {
          let proj = project_to_surface(f, fx, fy, fz, @core.Point3D::new(x, y, z), 10)
          result.push(proj)
        }
        z += dz
      }
      y += dy
    }
    x += dx
  }
  result
}