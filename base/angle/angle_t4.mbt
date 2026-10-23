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
