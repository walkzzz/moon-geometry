///|
/// Normalize angle to [0, 2π). / 归一化角度到 [0, 2π)。
pub fn normalize_angle(angle : Double) -> Double {
  let two_pi = 6.283185307179586
  let mut a = angle % two_pi
  if a < 0.0 {
    a += two_pi
  }
  a
}
