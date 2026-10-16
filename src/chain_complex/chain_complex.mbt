///|
/// # Chain Complex
/// # 链复形
///
/// Chain complex for homology computation.
/// 用于同调计算的链复形。

///|
pub struct ChainComplex {
  ranks : Array[Int]
}

///|
pub fn ChainComplex::new(ranks : Array[Int]) -> ChainComplex {
  { ranks, }
}

///|
pub fn chain_rank(cc : ChainComplex, dim : Int) -> Int {
  if dim < 0 || dim >= cc.ranks.length() { return 0 }
  cc.ranks[dim]
}

///|
pub fn chain_length(cc : ChainComplex) -> Int {
  cc.ranks.length()
}

///|
pub fn chain_total_rank(cc : ChainComplex) -> Int {
  let mut total = 0
  for i in 0..<cc.ranks.length() {
    total += cc.ranks[i]
  }
  total
}
