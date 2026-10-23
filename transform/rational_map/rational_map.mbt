///|
/// # Rational Map
/// # 有理映射
///
/// Rational maps between algebraic varieties.
/// 代数簇之间的有理映射。


///|
pub struct RationalMap {
  num_coeffs : Array[Double]
  den_coeffs : Array[Double]
}


///|
pub fn RationalMap::new(num : Array[Double], den : Array[Double]) -> RationalMap {
  { num_coeffs: num, den_coeffs: den, }
}
