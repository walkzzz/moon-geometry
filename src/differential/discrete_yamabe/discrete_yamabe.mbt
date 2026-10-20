///|
/// # Discrete Yamabe Problem
/// # 离散 Yamabe 问题
///
/// Discrete Yamabe problem: find conformal factor for constant curvature.
/// 离散 Yamabe 问题：寻找共形因子使曲率常数化。

///|
pub fn yamabe_energy(curvatures : Array[Double], target : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<curvatures.length() {
    let diff = curvatures[i] - target
    sum += diff * diff
  }
  sum
}

///|
pub fn yamabe_gradient(curvatures : Array[Double], target : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<curvatures.length() {
    result.push(2.0 * (curvatures[i] - target))
  }
  result
}

///|
pub fn constant_curvature_target(total_curv : Double, n : Int) -> Double {
  if n == 0 { 0.0 } else { total_curv / n.to_double() }
}

///|
pub fn yamabe_flow_step(conformal_factors : Array[Double], gradient : Array[Double], dt : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<conformal_factors.length() {
    result.push(conformal_factors[i] - dt * gradient[i])
  }
  result
}

///|
pub fn yamabe_converged(energy : Double, tol : Double) -> Bool {
  energy < tol
}
