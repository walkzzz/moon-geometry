///|
/// Construct a Reeds-Shepp path. / 构造 Reeds-Shepp 路径。
pub fn RSPath::new(
  segments : Array[RSSegment],
  total_length : Double,
  radius : Double,
) -> RSPath {
  { segments, total_length, radius }
}


///|
/// Pose for Reeds-Shepp car. / Reeds-Shepp 小车位姿。
pub struct RSPose {
  x : Double
  y : Double
  theta : Double
}


///|
/// Construct a Reeds-Shepp pose. / 构造 Reeds-Shepp 位姿。
pub fn RSPose::new(x : Double, y : Double, theta : Double) -> RSPose {
  { x, y, theta }
}

fn mod2pi(a : Double) -> Double {
  let two_pi = 6.283185307179586
  let mut result = a % two_pi
  if result < 0.0 {
    result += two_pi
  }
  result
}

