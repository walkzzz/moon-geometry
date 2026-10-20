///|
/// # Sequential Quadratic Programming
/// # 序列二次规划
///
/// SQP for constrained nonlinear optimization.
/// SQP用于约束非线性优化。

///|
pub struct SqpConfig {
  max_iter : Int
  tol : Double
}

///|
pub fn SqpConfig::new(max_iter : Int, tol : Double) -> SqpConfig {
  { max_iter, tol }
}

///|
/// Lagrangian evaluation. / Lagrange函数求值。
pub fn lagrangian(f : Double, lambda : Array[Double], constraints : Array[Double]) -> Double {
  let mut result = f
  for i in 0..<lambda.length() {
    if i < constraints.length() {
      result += lambda[i] * constraints[i]
    }
  }
  result
}

///|
/// KKT residual for convergence check. / KKT残差用于收敛检查。
pub fn kkt_residual(grad_f : Array[Double], jacobian : Array[Array[Double]], lambda : Array[Double]) -> Double {
  let n = grad_f.length()
  let residual : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    residual[i] = grad_f[i]
    for j in 0..<lambda.length() {
      if j < jacobian.length() && i < jacobian[j].length() {
        residual[i] += lambda[j] * jacobian[j][i]
      }
    }
  }
  let mut norm = 0.0
  for i in 0..<n {
    norm += residual[i] * residual[i]
  }
  norm.sqrt()
}

///|
pub fn sqp_converged(residual : Double, tol : Double) -> Bool {
  residual < tol
}
