///|
/// # Discrete Ricci Flow
/// # 离散 Ricci 流
///
/// Discrete Ricci flow for conformal deformation of surfaces.
/// 曲面共形变形的离散 Ricci 流。

///|
pub fn ricci_flow_step(curvatures : Array[Double], target_curvatures : Array[Double], dt : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<curvatures.length() {
    result.push(curvatures[i] + dt * (target_curvatures[i] - curvatures[i]))
  }
  result
}

///|
pub fn ricci_energy(curvatures : Array[Double], target : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<curvatures.length() {
    let diff = curvatures[i] - target[i]
    sum += diff * diff
  }
  sum / 2.0
}

///|
pub fn target_curvature_uniform(n : Int, total_curv : Double) -> Array[Double] {
  let per_vertex = total_curv / n.to_double()
  Array::make(n, per_vertex)
}

///|
pub fn target_curvature_gaussian(n : Int, euler_char : Int) -> Array[Double] {
  let total = 6.283185307179586 * euler_char.to_double()
  target_curvature_uniform(n, total)
}

///|
pub fn ricci_converged(energy : Double, tol : Double) -> Bool {
  energy < tol
}
