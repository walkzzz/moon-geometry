///|
/// # Chow Ring
/// # Chow 环
///
/// Chow ring of projective spaces for intersection theory.
/// 射影空间的 Chow 环，用于相交理论。

///|
pub fn chow_ring_dim(n : Int) -> Int {
  n
}

///|
pub fn chow_product(a_deg : Int, b_deg : Int, n : Int) -> Int {
  let sum = a_deg + b_deg
  if sum > n { 0 } else { sum }
}

///|
pub fn chow_class_degree(k : Int, n : Int) -> Int {
  if k < 0 || k > n { 0 } else { 1 }
}

///|
pub fn chow_top_class(n : Int) -> Int {
  n
}

///|
pub fn chow_integral(degree : Int, n : Int) -> Int {
  if degree == n { 1 } else { 0 }
}
