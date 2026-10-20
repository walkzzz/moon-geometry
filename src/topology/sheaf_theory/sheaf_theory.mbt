///|
/// # Cellular Sheaf Theory
/// # 胞腔层理论
///
/// Cellular sheaves and sheaf cohomology on simplicial complexes.
/// 单纯复形上的胞腔层与层上同调。

///|
pub fn sheaf_rank(stalk_ranks : Array[Int]) -> Int {
  let mut sum = 0
  for i in 0..<stalk_ranks.length() {
    sum += stalk_ranks[i]
  }
  sum
}

///|
pub fn sheaf_cohomology_dim(c0_dim : Int, c1_dim : Int, c2_dim : Int) -> (Int, Int) {
  let h0 = c0_dim - c1_dim
  let h1 = c1_dim - c2_dim
  (if h0 < 0 { 0 } else { h0 }, if h1 < 0 { 0 } else { h1 })
}

///|
pub fn euler_characteristic_sheaf(h0 : Int, h1 : Int, h2 : Int) -> Int {
  h0 - h1 + h2
}

///|
pub fn is_locally_constant(restriction_ranks : Array[Int]) -> Bool {
  if restriction_ranks.length() == 0 { return true }
  let r0 = restriction_ranks[0]
  for i in 1..<restriction_ranks.length() {
    if restriction_ranks[i] != r0 { return false }
  }
  true
}

///|
pub fn sheaf_pushforward_rank(original_rank : Int, map_degree : Int) -> Int {
  original_rank * map_degree
}
