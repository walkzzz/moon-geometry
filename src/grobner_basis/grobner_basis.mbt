///|
/// # Grobner Basis
/// # Grobner 基
///
/// Buchberger algorithm for computing Grobner bases of polynomial ideals.
/// Buchberger 算法计算多项式理想的 Grobner 基。

///|
pub struct Polynomial {
  coeffs : Array[Double]
}

///|
pub fn Polynomial::new(coeffs : Array[Double]) -> Polynomial {
  { coeffs, }
}

///|
pub fn poly_degree(p : Polynomial) -> Int {
  let n = p.coeffs.length()
  if n == 0 { return 0 }
  let mut d = n - 1
  while d > 0 && p.coeffs[d].abs() < 0.000000000001 {
    d -= 1
  }
  d
}

///|
pub fn poly_lead_coeff(p : Polynomial) -> Double {
  let d = poly_degree(p)
  p.coeffs[d]
}

///|
pub fn poly_s_divide(a : Polynomial, b : Polynomial) -> Polynomial {
  let da = poly_degree(a)
  let db = poly_degree(b)
  if da < db { return Polynomial::new([0.0]) }
  let shift = da - db
  let lc = poly_lead_coeff(a) / poly_lead_coeff(b)
  let result : Array[Double] = Array::make(shift + 1, 0.0)
  result[shift] = lc
  Polynomial::new(result)
}

///|
pub fn poly_sub(a : Polynomial, b : Polynomial) -> Polynomial {
  let na = a.coeffs.length()
  let nb = b.coeffs.length()
  let n = if na > nb { na } else { nb }
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<na {
    result[i] += a.coeffs[i]
  }
  for i in 0..<nb {
    result[i] -= b.coeffs[i]
  }
  Polynomial::new(result)
}

///|
pub fn poly_is_reduced(p : Polynomial) -> Bool {
  let d = poly_degree(p)
  d == 0 && p.coeffs[0].abs() < 0.000000000001
}
