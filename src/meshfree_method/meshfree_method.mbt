///|
/// # Meshfree Method
/// # 无网格方法
///
/// Meshfree methods: SPH, RBF-FD for PDEs without mesh generation.
/// 无网格方法：SPH、RBF-FD 用于无网格 PDE 求解。

///|
pub fn sph_kernel(r : Double, h : Double) -> Double {
  let q = r / h
  if q >= 2.0 { return 0.0 }
  let sigma = 15.0 / (16.0 * 3.141592653589793 * h * h * h)
  if q < 1.0 {
    sigma * (1.0 - 1.5 * q * q + 0.75 * q * q * q)
  } else {
    sigma * 0.25 * (2.0 - q) * (2.0 - q) * (2.0 - q)
  }
}

///|
pub fn sph_kernel_gradient(r : Double, h : Double) -> Double {
  let q = r / h
  if q >= 2.0 || q < 0.000000000001 { return 0.0 }
  let sigma = 15.0 / (16.0 * 3.141592653589793 * h * h * h)
  if q < 1.0 {
    sigma * (-3.0 * q + 2.25 * q * q) / h
  } else {
    -sigma * 0.75 * (2.0 - q) * (2.0 - q) / h
  }
}

///|
pub fn rbf_gaussian(r : Double, eps : Double) -> Double {
  @math.exp(-eps * eps * r * r)
}

///|
pub fn rbf_multiquadric(r : Double, eps : Double) -> Double {
  (1.0 + eps * eps * r * r).sqrt()
}

///|
pub fn rbf_thin_plate_spline(r : Double) -> Double {
  if r < 0.000000000001 { 0.0 } else { r * r * @math.ln(r) }
}
