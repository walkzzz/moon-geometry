/// |
/// # Parametric Surfaces
/// # 参数曲面
///
/// Evaluate parametric surfaces, compute tangents, normals, and fundamental forms.
/// 求值参数曲面，计算切线、法线和基本形式。
///
/// ## Surface: S(u,v) -> (x, y, z)
/// ## 曲面: S(u,v) -> (x, y, z)

/// |
/// Evaluate a parametric surface given S(u,v) callback.
/// 求值由 S(u,v) 回调给定的参数曲面。
///
/// Returns the surface point (x, y, z).
/// 返回曲面上的点 (x, y, z)。
pub fn eval_surface(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
) -> (Double, Double, Double) {
  s(u, v)
}

/// |
/// Compute partial derivative dS/du using central difference.
/// 使用中心差分计算偏导数 dS/du。
pub fn surface_du(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  let (xp, yp, zp) = s(u + h, v)
  let (xm, ym, zm) = s(u - h, v)
  ((xp - xm) / (2.0 * h), (yp - ym) / (2.0 * h), (zp - zm) / (2.0 * h))
}

/// |
/// Compute partial derivative dS/dv using central difference.
/// 使用中心差分计算偏导数 dS/dv。
pub fn surface_dv(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  let (xp, yp, zp) = s(u, v + h)
  let (xm, ym, zm) = s(u, v - h)
  ((xp - xm) / (2.0 * h), (yp - ym) / (2.0 * h), (zp - zm) / (2.0 * h))
}

/// |
/// Compute surface normal N = dS/du × dS/dv (normalized).
/// 计算曲面法线 N = dS/du × dS/dv（归一化）。
pub fn surface_normal(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  let (ux, uy, uz) = surface_du(s, u, v, h)
  let (vx, vy, vz) = surface_dv(s, u, v, h)
  let nx = uy * vz - uz * vy
  let ny = uz * vx - ux * vz
  let nz = ux * vy - uy * vx
  let len = (nx * nx + ny * ny + nz * nz).sqrt()
  if len.abs() < 0.0000000001 {
    return (0.0, 0.0, 0.0)
  }
  (nx / len, ny / len, nz / len)
}

/// |
/// Compute first fundamental form coefficients (E, F, G).
/// 计算第一基本形式系数 (E, F, G)。
///
/// E = S_u · S_u, F = S_u · S_v, G = S_v · S_v
pub fn first_fundamental_form(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  let (ux, uy, uz) = surface_du(s, u, v, h)
  let (vx, vy, vz) = surface_dv(s, u, v, h)
  let e = ux * ux + uy * uy + uz * uz
  let f = ux * vx + uy * vy + uz * vz
  let g = vx * vx + vy * vy + vz * vz
  (e, f, g)
}

/// |
/// Compute second fundamental form coefficients (L, M, N).
/// 计算第二基本形式系数 (L, M, N)。
///
/// L = S_uu · n, M = S_uv · n, N = S_vv · n
pub fn second_fundamental_form(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  let (nx, ny, nz) = surface_normal(s, u, v, h)
  let (uup, uyp, uzp) = s(u + h, v)
  let (uum, uym, uzm) = s(u - h, v)
  let (u0, u1, u2) = s(u, v)
  let suu_x = (uup - 2.0 * u0 + uum) / (h * h)
  let suu_y = (uyp - 2.0 * u1 + uym) / (h * h)
  let suu_z = (uzp - 2.0 * u2 + uzm) / (h * h)
  let (vvp, vyp, vzp) = s(u, v + h)
  let (vvm, vym, vzm) = s(u, v - h)
  let svv_x = (vvp - 2.0 * u0 + vvm) / (h * h)
  let svv_y = (vyp - 2.0 * u1 + vym) / (h * h)
  let svv_z = (vzp - 2.0 * u2 + vzm) / (h * h)
  let (uvpp, uvyp, uvzp) = s(u + h, v + h)
  let (uvpm, uvym, uvzm) = s(u + h, v - h)
  let (uvmp, uvmy, uvmz) = s(u - h, v + h)
  let (uvmm, uvyy, uvzz) = s(u - h, v - h)
  let suv_x = (uvpp - uvpm - uvmp + uvmm) / (4.0 * h * h)
  let suv_y = (uvyp - uvym - uvmy + uvyy) / (4.0 * h * h)
  let suv_z = (uvzp - uvzm - uvmz + uvzz) / (4.0 * h * h)
  let l = suu_x * nx + suu_y * ny + suu_z * nz
  let m = suv_x * nx + suv_y * ny + suv_z * nz
  let nn = svv_x * nx + svv_y * ny + svv_z * nz
  (l, m, nn)
}

/// |
/// Compute Gaussian curvature K = (LN - M²) / (EG - F²).
/// 计算高斯曲率 K = (LN - M²) / (EG - F²)。
pub fn gaussian_curvature(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> Double {
  let (e, f, g) = first_fundamental_form(s, u, v, h)
  let (l, m, nn) = second_fundamental_form(s, u, v, h)
  let denom = e * g - f * f
  if denom.abs() < 0.0000000001 {
    return 0.0
  }
  (l * nn - m * m) / denom
}

/// |
/// Compute mean curvature H = (EN - 2FM + GL) / (2(EG - F²)).
/// 计算平均曲率 H = (EN - 2FM + GL) / (2(EG - F²))。
pub fn mean_curvature(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> Double {
  let (e, f, g) = first_fundamental_form(s, u, v, h)
  let (l, m, nn) = second_fundamental_form(s, u, v, h)
  let denom = 2.0 * (e * g - f * f)
  if denom.abs() < 0.0000000001 {
    return 0.0
  }
  (e * nn - 2.0 * f * m + g * l) / denom
}