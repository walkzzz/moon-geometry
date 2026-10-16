///|
/// # Conformal Map
/// # 共形映射
///
/// Conformal parameterization of surfaces (angle-preserving maps).
/// 曲面的共形参数化（保角映射）。

///|
pub fn conformal_factor(scale_x : Double, scale_y : Double) -> Double {
  if scale_x.abs() < 0.000000000001 { return 0.0 }
  scale_y / scale_x
}

///|
pub fn is_conformal(j11 : Double, j12 : Double, j21 : Double, j22 : Double, tol : Double) -> Bool {
  let a = j11 - j22
  let b = j12 + j21
  (a * a + b * b).sqrt() < tol
}

///|
pub fn conformal_energy(stretch_u : Double, stretch_v : Double) -> Double {
  let diff = stretch_u - stretch_v
  diff * diff
}

///|
pub fn angle_distortion(theta_before : Double, theta_after : Double) -> Double {
  (theta_before - theta_after).abs()
}

///|
pub fn area_distortion(area_before : Double, area_after : Double) -> Double {
  if area_before.abs() < 0.000000000001 { 0.0 } else { @math.ln(area_after / area_before).abs() }
}
