///| Robust Arithmetic | 鲁棒算术

///| Adaptive precision, error-free transforms, Shewchuk expansion

///| 自适应精度、误差自由变换、Shewchuk 扩展

///|
/// Error-free transform of sum a+b returning (sum, error). / a+b 的误差自由变换，返回（和，误差）。
pub fn two_sum(a : Double, b : Double) -> (Double, Double) {
  let s = a + b
  let bb = s - a
  let err = b - bb
  (s, err)
}

///|
/// Error-free transform of product a*b returning (product, error). / a*b 的误差自由变换，返回（积，误差）。
pub fn two_prod(a : Double, b : Double) -> (Double, Double) {
  let p = a * b
  let err = a * b - p
  (p, err)
}

///|
/// Fast error-free sum assuming |a| >= |b|. / 快速误差自由求和，假设 |a| >= |b|。
pub fn fast_two_sum(a : Double, b : Double) -> (Double, Double) {
  let s = a + b
  let err = a - (s - b)
  (s, err)
}

///|
/// Grow expansion by adding scalar b. / 将标量 b 加入扩展得到新扩展。
pub fn grow_expansion(e : Array[Double], b : Double) -> Array[Double] {
  let result = Array::make(e.length() + 1, 0.0)
  let (s0, err0) = two_sum(e[0], b)
  let mut err = err0
  result[0] = s0
  for i in 1..<e.length() {
    let (si, erri) = two_sum(e[i], err)
    result[i] = si
    err = erri
  }
  result[e.length()] = err
  result
}

///|
/// Sum all components of expansion. / 求扩展所有分量之和。
pub fn expansion_sum(e : Array[Double]) -> Double {
  let mut total = 0.0
  for v in e {
    total += v
  }
  total
}
