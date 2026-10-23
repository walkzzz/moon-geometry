///| Euclidean norm of expansion components. / 扩展分量的欧几里得范数。
pub fn expansion_norm(e : Array[Double]) -> Double {
  let mut sum = 0.0
  for v in e {
    sum += v * v
  }
  sum.sqrt()
}


///| Negate all components of expansion. / 对扩展所有分量取负。
pub fn expansion_negate(e : Array[Double]) -> Array[Double] {
  let result = Array::make(e.length(), 0.0)
  for i in 0..<e.length() {
    result[i] = -e[i]
  }
  result
}
