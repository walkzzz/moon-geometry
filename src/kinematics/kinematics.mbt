///|
/// # Kinematics | 运动学
/// Forward and inverse kinematics. / 正运动学和逆运动学。
///|
pub fn forward_kin_2d(theta1 : Double, theta2 : Double, l1 : Double, l2 : Double) -> (Double, Double) {
  let x = l1 * @math.cos(theta1) + l2 * @math.cos(theta1 + theta2)
  let y = l1 * @math.sin(theta1) + l2 * @math.sin(theta1 + theta2)
  (x, y)
}
///|
pub fn jacobian_2d(theta1 : Double, theta2 : Double, l1 : Double, l2 : Double) -> (Double, Double, Double, Double) {
  let j11 = -l1 * @math.sin(theta1) - l2 * @math.sin(theta1 + theta2)
  let j12 = -l2 * @math.sin(theta1 + theta2)
  let j21 = l1 * @math.cos(theta1) + l2 * @math.cos(theta1 + theta2)
  let j22 = l2 * @math.cos(theta1 + theta2)
  (j11, j12, j21, j22)
}
///|
pub fn inverse_kin_2d(x : Double, y : Double, l1 : Double, l2 : Double) -> (Double, Double) {
  let r2 = x * x + y * y
  let cos2 = (r2 - l1 * l1 - l2 * l2) / (2.0 * l1 * l2)
  let cos2_c = if cos2 > 1.0 { 1.0 } else { if cos2 < -1.0 { -1.0 } else { cos2 } }
  let theta2 = @math.acos(cos2_c)
  let theta1 = @math.atan2(y, x) - @math.atan2(l2 * @math.sin(theta2), l1 + l2 * @math.cos(theta2))
  (theta1, theta2)
}
///|
pub fn manipulability(j11 : Double, j12 : Double, j21 : Double, j22 : Double) -> Double {
  (j11 * j22 - j12 * j21).abs()
}
