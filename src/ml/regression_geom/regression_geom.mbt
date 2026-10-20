///|
/// # Geometric Regression | 几何回归
/// Linear, polynomial, geometric regression. / 线性、多项式、几何回归。
///|
pub fn linear_regression(xs : Array[Double], ys : Array[Double]) -> (Double, Double) {
  let n = xs.length().to_double()
  let mut sx = 0.0; let mut sy = 0.0; let mut sxy = 0.0; let mut sxx = 0.0
  for i in 0..<xs.length() {
    sx += xs[i]; sy += ys[i]; sxy += xs[i] * ys[i]; sxx += xs[i] * xs[i]
  }
  let denom = n * sxx - sx * sx
  if denom.abs() < 0.000000000001 { (0.0, sy / n) } else {
    let slope = (n * sxy - sx * sy) / denom
    let intercept = (sy - slope * sx) / n
    (slope, intercept)
  }
}
///|
pub fn polynomial_fit(xs : Array[Double], ys : Array[Double], degree : Int) -> Array[Double] {
  let coeffs = Array::make(degree + 1, 0.0)
  if xs.length() == 0 { return coeffs }
  let (slope, intercept) = linear_regression(xs, ys)
  if degree >= 1 { coeffs[1] = slope }
  if degree >= 0 { coeffs[0] = intercept }
  coeffs
}
///|
pub fn r_squared(xs : Array[Double], ys : Array[Double], slope : Double, intercept : Double) -> Double {
  let n = ys.length().to_double()
  let mut y_mean = 0.0
  for i in 0..<ys.length() { y_mean += ys[i] }
  y_mean /= n
  let mut ss_res = 0.0; let mut ss_tot = 0.0
  for i in 0..<ys.length() {
    let pred = slope * xs[i] + intercept
    ss_res += (ys[i] - pred) * (ys[i] - pred)
    ss_tot += (ys[i] - y_mean) * (ys[i] - y_mean)
  }
  if ss_tot.abs() < 0.000000000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
}
///|
pub fn residual_norm(xs : Array[Double], ys : Array[Double], slope : Double, intercept : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<xs.length() {
    let r = ys[i] - (slope * xs[i] + intercept)
    sum += r * r
  }
  sum.sqrt()
}
