///|
/// # Bezout Theorem
/// # Bezout 定理
///
/// Bezout theorem: number of intersection points of two plane curves.
/// Bezout 定理：两条平面曲线的交点数。

///|
pub fn bezout_count(d1 : Int, d2 : Int) -> Int {
  d1 * d2
}

///|
pub fn bezout_with_multiplicities(degrees : Array[Int]) -> Int {
  let mut product = 1
  for i in 0..<degrees.length() {
    product *= degrees[i]
  }
  product
}

///|
pub fn bezout_excess(expected : Int, found : Int) -> Int {
  expected - found
}

///|
pub fn bezout_in_pn(degrees : Array[Int], n : Int) -> Int {
  if degrees.length() < n { return 0 }
  let mut product = 1
  for i in 0..<degrees.length() {
    product *= degrees[i]
  }
  product
}

///|
pub fn is_bezout_satisfied(expected : Int, actual : Int) -> Bool {
  expected == actual
}
