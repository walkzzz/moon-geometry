///|
/// # Lazy Exact Computation
/// # 惰性精确计算
///
/// Lazy evaluation with approximate and exact phases.
/// 惰性求值，含近似和精确两阶段。

///|
pub struct LazyExact {
  approx : Double
  exact_val : Double
}

///|
pub fn LazyExact::new(approx : Double, exact_val : Double) -> LazyExact {
  { approx, exact_val, }
}

///|
pub fn lazy_value(le : LazyExact) -> Double {
  le.exact_val
}

///|
pub fn lazy_approx(le : LazyExact) -> Double {
  le.approx
}

///|
pub fn lazy_error(le : LazyExact) -> Double {
  (le.approx - le.exact_val).abs()
}
