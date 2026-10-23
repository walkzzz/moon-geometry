///|
/// Degrees to radians. / 角度转弧度。
pub fn deg_to_rad(deg : Double) -> Double {
  deg * 3.141592653589793 / 180.0
}

///|
/// Radians to degrees. / 弧度转角度。
pub fn rad_to_deg(rad : Double) -> Double {
  rad * 180.0 / 3.141592653589793
}

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

///|
/// Angular difference (b - a) normalized to [-π, π]. / 角差归一化到 [-π, π]。
pub fn angle_diff(a : Double, b : Double) -> Double {
  normalize_angle_signed(b - a)
}

///|
/// Bisector angle of two angles. / 两角平分线角度。
pub fn bisector(a : Double, b : Double) -> Double {
  let d = angle_diff(a, b)
  normalize_angle(a + d / 2.0)
}

///|
/// Check if angle c is between a and b (CCW). / 检查角度 c 是否在 a 和 b 之间（逆时针）。
pub fn is_between(a : Double, c : Double, b : Double) -> Bool {
  let ac = angle_diff(a, c)
  let ab = angle_diff(a, b)
  ac >= 0.0 && ac <= ab
}
