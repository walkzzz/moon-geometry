///|
/// Simple linear congruential generator for reproducible random numbers. / 简单线性同余生成器，用于可复现随机数。
pub struct Rng {
  mut state : UInt
}


///|
/// Create a new RNG with a seed. / 用种子创建新 RNG。
pub fn Rng::new(seed : UInt) -> Rng {
  { state: seed }
}
