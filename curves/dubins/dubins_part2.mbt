///|
/// Construct a Dubins path. / 构造 Dubins 路径。
pub fn DubinsPath::new(
  segments : Array[DubinsSegment],
  total_length : Double,
  radius : Double,
) -> DubinsPath {
  { segments, total_length, radius, }
}

///|
/// Pose (position + heading) for Dubins car. / Dubins 小车的位姿（位置 + 朝向）。
pub struct DubinsPose {
  x : Double
  y : Double
  theta : Double
}

///|
/// Construct a Dubins pose. / 构造 Dubins 位姿。
pub fn DubinsPose::new(x : Double, y : Double, theta : Double) -> DubinsPose {
  { x, y, theta, }
}

///|
fn normalize_angle(a : Double) -> Double {
  let two_pi = 6.283185307179586
  let mut result = a % two_pi
  if result < 0.0 {
    result += two_pi
  }
  result
}

///|
fn mod2pi(a : Double) -> Double {
  normalize_angle(a)
}
