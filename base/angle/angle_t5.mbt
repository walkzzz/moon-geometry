///|
/// Check if angle c is between a and b (CCW). / 检查角度 c 是否在 a 和 b 之间（逆时针）。
pub fn is_between(a : Double, c : Double, b : Double) -> Bool {
  let ac = angle_diff(a, c)
  let ab = angle_diff(a, b)
  ac >= 0.0 && ac <= ab
}
