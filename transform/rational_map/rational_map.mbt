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
pub fn RationalMap::new(
  num : Array[Double],
  den : Array[Double],
) -> RationalMap {
  { num_coeffs: num, den_coeffs: den, }
}

///|
pub fn rational_eval(m : RationalMap, x : Double) -> Double {
  let mut num = 0.0
  for i in 0..<m.num_coeffs.length() {
    num += m.num_coeffs[i] * pow(x, i)
  }
  let mut den = 0.0
  for i in 0..<m.den_coeffs.length() {
    den += m.den_coeffs[i] * pow(x, i)
  }
  if den.abs() < 0.000000000001 {
    0.0
  } else {
    num / den
  }
}

///|
pub fn rational_degree(m : RationalMap) -> Int32 {
  let nd = m.num_coeffs.length() - 1
  let dd = m.den_coeffs.length() - 1
  if nd > dd {
    nd - dd
  } else {
    0
  }
}

///|
pub fn rational_is_defined(m : RationalMap, x : Double) -> Bool {
  let mut den = 0.0
  for i in 0..<m.den_coeffs.length() {
    den += m.den_coeffs[i] * pow(x, i)
  }
  den.abs() > 0.000000000001
}

///|
fn pow(base : Double, exp : Int32) -> Double {
  let mut result = 1.0
  for _ in 0..<exp {
    result *= base
  }
  result
}
