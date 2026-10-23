///|
/// Linear congruential generator | 线性同余生成器
pub struct FakeRNG {
  mut seed : Int32
}

///|
/// Create a new fake RNG with given seed. / 用给定种子创建新伪随机数生成器。
pub fn FakeRNG::new(seed : Int32) -> FakeRNG {
  { seed, }
}

///|
/// Return the next pseudo-random integer. / 返回下一个伪随机整数。
pub fn FakeRNG::next(self : FakeRNG) -> Int32 {
  let val = (self.seed * 1103515245 + 12345) % 2147483647
  self.seed = if val < 0 { -val } else { val }
  self.seed
}

///|
/// Return the next pseudo-random double in [min, max). / 返回 [min, max) 内的下一个伪随机浮点数。
pub fn FakeRNG::next_double(
  self : FakeRNG,
  min : Double,
  max : Double,
) -> Double {
  let r = self.next().to_double() / 2147483647.0
  min + r * (max - min)
}

///|
/// Return the next random 2D point in the given range. / 返回给定范围内的下一个随机二维点。
pub fn FakeRNG::next_point(
  self : FakeRNG,
  min_val : Double,
  max_val : Double,
) -> @core.Point2D {
  @core.Point2D::new(
    self.next_double(min_val, max_val),
    self.next_double(min_val, max_val),
  )
}
