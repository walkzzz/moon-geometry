///|
/// # Multi-dimensional Persistence
/// # 多维持久性
///
/// Multi-parameter persistence modules and their invariants.
/// 多参数持久性模及其不变量。

///|
pub fn multidim_barcode(births : Array[(Double, Double)], deaths : Array[(Double, Double)]) -> Array[((Double, Double), (Double, Double))] {
  let result : Array[((Double, Double), (Double, Double))] = []
  let n = if births.length() < deaths.length() { births.length() } else { deaths.length() }
  for i in 0..<n {
    result.push((births[i], deaths[i]))
  }
  result
}

///|
pub fn multidim_persistence(barcode : Array[((Double, Double), (Double, Double))]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<barcode.length() {
    let ((b1, b2), (d1, d2)) = barcode[i]
    let p1 = d1 - b1
    let p2 = d2 - b2
    let p = if p1 < p2 { p1 } else { p2 }
    result.push(p)
  }
  result
}

///|
pub fn hilbert_function_md(grades : Array[(Int, Int)]) -> Int {
  grades.length()
}

///|
pub fn rank_invariant(birth : (Int, Int), death : (Int, Int)) -> Int {
  let (b1, b2) = birth
  let (d1, d2) = death
  if d1 >= b1 && d2 >= b2 { 1 } else { 0 }
}
