///|
/// Check collision between two circles using SAT. / 使用 SAT 检测两圆碰撞。
pub fn sat_collide_circles(
  c1 : @core.Point2D,
  r1 : Double,
  c2 : @core.Point2D,
  r2 : Double,
) -> SATResult {
  let dx = c2.x() - c1.x()
  let dy = c2.y() - c1.y()
  let dist = (dx * dx + dy * dy).sqrt()
  let r_sum = r1 + r2
  if dist > r_sum {
    let ax = if dist > 0.000000000001 { dx / dist } else { 1.0 }
    let ay = if dist > 0.000000000001 { dy / dist } else { 0.0 }
    return SATResult::new(false, 0.0, ax, ay)
  }
  let ax = if dist > 0.000000000001 { dx / dist } else { 1.0 }
  let ay = if dist > 0.000000000001 { dy / dist } else { 0.0 }
  SATResult::new(true, r_sum - dist, ax, ay)
}
