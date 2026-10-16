///|
/// # Minimal Surface
/// # 极小曲面
///
/// Minimal surface computation (mean curvature = 0).
/// 极小曲面计算（平均曲率 = 0）。

///|
pub fn is_minimal(mean_curvature : Double, tol : Double) -> Bool {
  mean_curvature.abs() < tol
}

///|
pub fn minimal_surface_energy(area : Double) -> Double {
  area
}

///|
pub fn area_gradient(mean_curvatures : Array[Double], areas : Array[Double]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<mean_curvatures.length() {
    result.push(2.0 * mean_curvatures[i] * areas[i])
  }
  result
}

///|
pub fn mean_curvature_flow_step(positions : Array[Double], laplacian : Array[Double], dt : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<positions.length() {
    result.push(positions[i] + dt * laplacian[i])
  }
  result
}

///|
pub fn plateau_energy(boundary_length : Double, area : Double) -> Double {
  area + 0.001 * boundary_length
}
