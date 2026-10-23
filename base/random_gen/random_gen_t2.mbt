///|
/// Generate next random UInt. / 生成下一个随机 UInt。
pub fn Rng::next_uint(r : Rng) -> UInt {
  r.state = r.state * 1103515245U + 12345U
  r.state
}


///|
/// Generate a random Double in [0, 1). / 生成 [0, 1) 中的随机 Double。
pub fn Rng::next_double(r : Rng) -> Double {
  let v = r.next_uint()
  (v % 1000000U).to_double() / 1000000.0
}


///|
/// Generate a random Double in [lo, hi). / 生成 [lo, hi) 中的随机 Double。
pub fn Rng::range_double(r : Rng, lo : Double, hi : Double) -> Double {
  lo + r.next_double() * (hi - lo)
}
