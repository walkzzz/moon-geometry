///|
pub fn rational_is_defined(m : RationalMap, x : Double) -> Bool {
  let mut den = 0.0
  for i in 0..<m.den_coeffs.length() {
    den += m.den_coeffs[i] * pow(x, i)
  }
  den.abs() > 0.000000000001
}

fn pow(base : Double, exp : Int) -> Double {
  let mut result = 1.0
  for _ in 0..<exp {
    result *= base
  }
  result
}
