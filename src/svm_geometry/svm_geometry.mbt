///|
/// # SVM Geometry | 支持向量机几何
/// Geometric SVM with kernel methods. / 核方法支持向量机几何。
///|
pub fn linear_kernel(x1 : Array[Double], x2 : Array[Double]) -> Double {
  let n = if x1.length() < x2.length() { x1.length() } else { x2.length() }
  let mut s = 0.0
  for i in 0..<n { s += x1[i] * x2[i] }
  s
}
///|
pub fn poly_kernel(x1 : Array[Double], x2 : Array[Double], degree : Int, c : Double) -> Double {
  let dot = linear_kernel(x1, x2)
  let mut result = 1.0
  for _ in 0..<degree { result *= (dot + c) }
  result
}
///|
pub fn rbf_kernel(x1 : Array[Double], x2 : Array[Double], gamma : Double) -> Double {
  let n = if x1.length() < x2.length() { x1.length() } else { x2.length() }
  let mut s = 0.0
  for i in 0..<n {
    let d = x1[i] - x2[i]
    s += d * d
  }
  @math.exp(-gamma * s)
}
///|
pub fn margin_distance(w : Array[Double], b : Double, x : Array[Double], y : Double) -> Double {
  let dot = linear_kernel(w, x)
  y * (dot + b)
}
