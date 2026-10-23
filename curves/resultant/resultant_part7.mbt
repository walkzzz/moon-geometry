///|
/// Subtract two polynomials (ascending). / 两个多项式相减（升序）。
pub fn poly_sub(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() > b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    let av = if i < a.length() { a[i] } else { 0.0 }
    let bv = if i < b.length() { b[i] } else { 0.0 }
    result.push(av - bv)
  }
  result
}
