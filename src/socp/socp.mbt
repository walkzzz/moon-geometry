///|
/// # Second-Order Cone Programming
/// # 二阶锥规划
///
/// SOCP for convex optimization with second-order cone constraints.
/// 二阶锥规划，用于含二阶锥约束的凸优化。

///|
pub struct SocpConfig {
  max_iter : Int
  tol : Double
}

///|
pub fn SocpConfig::new(max_iter : Int, tol : Double) -> SocpConfig {
  { max_iter, tol }
}

///|
/// Check second-order cone constraint: ||x|| <= t. / 检查二阶锥约束：||x|| <= t。
pub fn soc_constraint(x : Array[Double], t : Double) -> Bool {
  let mut norm_sq = 0.0
  for i in 0..<x.length() {
    norm_sq += x[i] * x[i]
  }
  norm_sq.sqrt() <= t
}

///|
/// Dual cone check: ||y|| <= s. / 对偶锥检查：||y|| <= s。
pub fn soc_dual(y : Array[Double], s : Double) -> Bool {
  soc_constraint(y, s)
}

///|
/// Cone slack: t - ||x||. / 锥间隙：t - ||x||。
pub fn soc_slack(x : Array[Double], t : Double) -> Double {
  let mut norm_sq = 0.0
  for i in 0..<x.length() {
    norm_sq += x[i] * x[i]
  }
  t - norm_sq.sqrt()
}
