///|
/// # Harmonic Map
/// # 调和映射
///
/// Harmonic maps between surfaces (energy minimization).
/// 曲面间的调和映射（能量最小化）。

///|
pub fn dirichlet_energy(values : Array[Double], neighbors : Array[Array[Double]]) -> Double {
  let mut energy = 0.0
  for i in 0..<values.length() {
    for j in 0..<neighbors[i].length() {
      let diff = values[i] - neighbors[i][j]
      energy += diff * diff
    }
  }
  energy / 2.0
}

///|
pub fn harmonic_residual(laplacian_values : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<laplacian_values.length() {
    sum += laplacian_values[i] * laplacian_values[i]
  }
  sum
}

///|
pub fn is_harmonic_map(residual : Double, tol : Double) -> Bool {
  residual < tol
}

///|
pub fn map_energy(dirichlet : Double, area : Double) -> Double {
  if area < 0.000000000001 { 0.0 } else { dirichlet / area }
}

///|
pub fn laplacian_smooth(values : Array[Double], laplacian : Array[Double], lambda : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<values.length() {
    result.push(values[i] + lambda * laplacian[i])
  }
  result
}
