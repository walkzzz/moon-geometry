///|
/// Test if point p lies on segment a-b. / 测试点 p 是否在线段 a-b 上。
pub fn robust_point_on_segment(
  px : Double,
  py : Double,
  ax : Double,
  ay : Double,
  bx : Double,
  by : Double,
) -> Bool {
  let cross = (bx - ax) * (py - ay) - (by - ay) * (px - ax)
  if cross.abs() > 1.0e-10 {
    false
  } else {
    let dot = (px - ax) * (bx - ax) + (py - ay) * (by - ay)
    let len_sq = (bx - ax) * (bx - ax) + (by - ay) * (by - ay)
    dot >= -1.0e-10 && dot <= len_sq + 1.0e-10
  }
}
