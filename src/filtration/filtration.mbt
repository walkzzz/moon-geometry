///|
/// # Filtration
/// # 过滤复形
///
/// Filtration of simplicial complexes for persistent homology.
/// 单纯复形的过滤，用于持久同调。

///|
pub struct Filtration {
  simplices : Array[Array[Int]]
  values : Array[Double]
}

///|
pub fn Filtration::new(simplices : Array[Array[Int]], values : Array[Double]) -> Filtration {
  { simplices, values }
}

///|
pub fn sublevel_set(f : Filtration, threshold : Double) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<f.simplices.length() {
    if i < f.values.length() && f.values[i] <= threshold {
      result.push(f.simplices[i])
    }
  }
  result
}

///|
pub fn filtration_length(f : Filtration) -> Int {
  f.simplices.length()
}

///|
pub fn critical_values(f : Filtration) -> Array[Double] {
  let vals : Array[Double] = []
  for i in 0..<f.values.length() {
    vals.push(f.values[i])
  }
  vals.sort()
  vals
}
