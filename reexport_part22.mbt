///|
/// Check if angle c is between a and b (CCW). / 检查角度 c 是否在 a 和 b 之间（逆时针）。
pub fn angle_is_between(a : Double, c : Double, b : Double) -> Bool {
  @angle.is_between(a, c, b)
}

// ---------------------------------------------------------------------------
// constants: geometric constants / 几何常数
// ---------------------------------------------------------------------------


///|
/// Pi. / 圆周率。
pub let pi : Double = @constants.pi


///|
/// 2 * Pi. / 2倍圆周率。
pub let two_pi : Double = @constants.two_pi


///|
/// Pi / 2. / 半圆周率。
pub let half_pi : Double = @constants.half_pi


///|
/// Pi / 4. / 四分之一圆周率。
pub let quarter_pi : Double = @constants.quarter_pi


///|
/// Euler's number. / 自然常数。
pub let euler_e : Double = @constants.e
