///|
/// # Hilbert Function
/// # Hilbert 函数
///
/// Hilbert function and Hilbert series of graded modules.
/// 分次模的 Hilbert 函数与 Hilbert 级数。

///|
pub fn hilbert_function_pn(degree : Int, n : Int) -> Int {
  if degree < 0 { return 0 }
  let mut result = 1
  for i in 1..<(n + 1) {
    result *= (degree + i)
  }
  let mut denom = 1
  for i in 1..<(n + 1) {
    denom *= i
  }
  result / denom
}

///|
pub fn hilbert_series_coeff(degree : Int, n : Int) -> Int {
  hilbert_function_pn(degree, n)
}

///|
pub fn hilbert_polynomial_eval(t : Int, degree : Int, n : Int) -> Int {
  hilbert_function_pn(t, n) - hilbert_function_pn(t - degree, n)
}

///|
pub fn hilbert_regularity(n : Int) -> Int {
  n
}

///|
pub fn hilbert_multiplicity(degree : Int, n : Int) -> Int {
  let mut result = 1
  for _ in 0..<n {
    result *= degree
  }
  result
}
