///|
/// # Augmented Lagrangian Method
/// # 增广Lagrange法
///
/// Augmented Lagrangian for constrained optimization.
/// 增广Lagrange法用于约束优化。

///|
pub struct AugLagConfig {
  rho : Double
  rho_factor : Double
  max_iter : Int
  tol : Double
}

///|
pub fn AugLagConfig::new(rho : Double, rho_factor : Double, max_iter : Int, tol : Double) -> AugLagConfig {
  { rho, rho_factor, max_iter, tol }
}

///|
/// Augmented Lagrangian value. / 增广Lagrange值。
pub fn aug_lagrangian(f : Double, lambda : Array[Double], constraints : Array[Double], rho : Double) -> Double {
  let mut result = f
  for i in 0..<constraints.length() {
    let l = if i < lambda.length() { lambda[i] } else { 0.0 }
    result += l * constraints[i] + rho * constraints[i] * constraints[i] / 2.0
  }
  result
}

///|
/// Update penalty parameter rho. / 更新罚参数rho。
pub fn update_rho(rho : Double, rho_factor : Double, constraint_violation : Double, prev_violation : Double) -> Double {
  if constraint_violation > 0.25 * prev_violation {
    rho * rho_factor
  } else {
    rho
  }
}

///|
pub fn constraint_violation(constraints : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<constraints.length() {
    sum += constraints[i] * constraints[i]
  }
  sum.sqrt()
}
