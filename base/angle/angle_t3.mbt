///|
/// Normalize angle to [-π, π). / 归一化角度到 [-π, π)。
pub fn normalize_angle_signed(angle : Double) -> Double {
  let pi = 3.141592653589793
  let two_pi = 6.283185307179586
  let mut a = angle % two_pi
  if a > pi {
    a -= two_pi
  }
  if a < -pi {
    a += two_pi
  }
  a
}
