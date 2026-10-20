///|
/// # Branch and Bound
/// # 分支定界
///
/// Branch and bound for global optimization.
/// 分支定界法用于全局优化。

///|
pub struct BranchBoundConfig {
  tol : Double
  max_iter : Int
}

///|
pub fn BranchBoundConfig::new(tol : Double, max_iter : Int) -> BranchBoundConfig {
  { tol, max_iter }
}

///|
/// Compute lower bound for interval. / 计算区间下界。
pub fn lower_bound(f : (Double) -> Double, lo : Double, hi : Double) -> Double {
  let n = 10
  let mut min_val = f(lo)
  for i in 1..<(n + 1) {
    let x = lo + (hi - lo) * i.to_double() / n.to_double()
    let v = f(x)
    if v < min_val { min_val = v }
  }
  min_val
}

///|
/// Branch interval into two sub-intervals. / 将区间分支为两个子区间。
pub fn branch_interval(lo : Double, hi : Double) -> ((Double, Double), (Double, Double)) {
  let mid = (lo + hi) / 2.0
  ((lo, mid), (mid, hi))
}

///|
pub fn bb_converged(lo : Double, hi : Double, tol : Double) -> Bool {
  (hi - lo).abs() < tol
}
