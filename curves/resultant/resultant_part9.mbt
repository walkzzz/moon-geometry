///|
/// Check if two polynomials share a common root (resultant is zero).
/// 检查两个多项式是否有公共根（结式为零）。
pub fn have_common_root(
  p : Array[Double],
  q : Array[Double],
  eps : Double,
) -> Bool {
  resultant(p, q).abs() < eps
}
