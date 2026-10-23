///|
/// Betti numbers result: b0 (components), b1 (loops), b2 (voids). / Betti 数结果：b0（连通分量）、b1（环）、b2（空洞）。
pub struct BettiResult {
  b0 : Int
  b1 : Int
  b2 : Int
}


///|
/// Construct a Betti result. / 构造 Betti 结果。
pub fn BettiResult::new(b0 : Int, b1 : Int, b2 : Int) -> BettiResult {
  { b0, b1, b2 }
}
