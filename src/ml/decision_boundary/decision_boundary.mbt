///|
/// # Decision Boundary | 决策边界
/// Decision boundary geometry for classifiers. / 分类器决策边界几何。
///|
pub fn linear_boundary(w : Array[Double], b : Double, x : Array[Double]) -> Double {
  let n = if w.length() < x.length() { w.length() } else { x.length() }
  let mut s = b
  for i in 0..<n { s += w[i] * x[i] }
  s
}
///|
pub fn boundary_distance(w : Array[Double], b : Double, x : Array[Double]) -> Double {
  let mut norm = 0.0
  for i in 0..<w.length() { norm += w[i] * w[i] }
  norm = norm.sqrt()
  if norm < 0.000000000001 { 0.0 } else { linear_boundary(w, b, x).abs() / norm }
}
///|
pub fn boundary_classify(w : Array[Double], b : Double, x : Array[Double]) -> Int {
  let v = linear_boundary(w, b, x)
  if v >= 0.0 { 1 } else { -1 }
}
///|
pub fn quadratic_boundary(a : Double, b : Double, c : Double, x : Double) -> Double {
  a * x * x + b * x + c
}
