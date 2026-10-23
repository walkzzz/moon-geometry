///|
/// Sign of val with tolerance tol. / 带容差 tol 的符号判定。
pub fn robust_sign(val : Double, tol : Double) -> Int32 {
  if val > tol {
    1
  } else if val < -tol {
    -1
  } else {
    0
  }
}

///|
/// Compare a and b with tolerance tol. / 带容差 tol 比较 a 与 b。
pub fn robust_compare(a : Double, b : Double, tol : Double) -> Int32 {
  robust_sign(a - b, tol)
}
