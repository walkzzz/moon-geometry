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
  if den.abs() < 0.000000000001 { 0.0 } else { num / den }
}
