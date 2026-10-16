///|
/// # Discrete Gauss-Bonnet Theorem
/// # 离散 Gauss-Bonnet 定理
///
/// Discrete Gauss-Bonnet: sum of angle defects = 2*pi*chi.
/// 离散 Gauss-Bonnet：角亏之和 = 2*pi*chi。

///|
pub fn gauss_bonnet_check(total_curvature : Double, euler_char : Int) -> Bool {
  let expected = 6.283185307179586 * euler_char.to_double()
  (total_curvature - expected).abs() < 0.01
}

///|
pub fn euler_from_curvature(total_curvature : Double) -> Int {
  (total_curvature / 6.283185307179586).round().to_int()
}

///|
pub fn total_gaussian_curvature(angle_defects : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<angle_defects.length() {
    sum += angle_defects[i]
  }
  sum
}

///|
pub fn boundary_correction(boundary_angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<boundary_angles.length() {
    sum += 3.141592653589793 - boundary_angles[i]
  }
  sum
}

///|
pub fn gauss_bonnet_with_boundary(interior_curv : Double, boundary_corr : Double, euler_char : Int) -> Bool {
  let expected = 6.283185307179586 * euler_char.to_double()
  (interior_curv + boundary_corr - expected).abs() < 0.01
}
