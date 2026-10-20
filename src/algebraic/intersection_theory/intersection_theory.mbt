///|
/// # Intersection Theory
/// # 相交理论
///
/// Intersection numbers and products in algebraic geometry.
/// 代数几何中的相交数与相交积。

///|
pub fn intersection_number(degrees : Array[Int]) -> Int {
  let mut product = 1
  for i in 0..<degrees.length() {
    product *= degrees[i]
  }
  product
}

///|
pub fn self_intersection(degree : Int, n : Int) -> Int {
  let mut result = 1
  for _ in 0..<n {
    result *= degree
  }
  result
}

///|
pub fn bezout_bound(d1 : Int, d2 : Int) -> Int {
  d1 * d2
}

///|
pub fn excess_intersection(expected : Int, actual : Int) -> Int {
  actual - expected
}

///|
pub fn is_transverse(codim_sum : Int, ambient_dim : Int) -> Bool {
  codim_sum == ambient_dim
}
