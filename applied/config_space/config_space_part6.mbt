///|
/// Check if a configuration space segment is valid (collision-free). / 检查配置空间线段是否有效（无碰撞）。
pub fn cspace_segment_valid(
  q1 : @core.Point2D,
  q2 : @core.Point2D,
  cspace_obstacles : Array[CSpaceObstacle],
) -> Bool {
  for i in 0..<cspace_obstacles.length() {
    let obs = cspace_obstacles[i].vertices
    let n = obs.length()
    if point_in_polygon(q1, obs) || point_in_polygon(q2, obs) {
      return false
    }
    for e in 0..<n {
      if seg_cross(q1, q2, obs[e], obs[(e + 1) % n]) {
        return false
      }
    }
  }
  true
}

///|
fn point_in_polygon(p : @core.Point2D, poly : Array[@core.Point2D]) -> Bool {
  let n = poly.length()
  if n == 0 {
    return false
  }
  let mut inside = false
  let mut j = n - 1
  for i in 0..<n {
    let yi = poly[i].y()
    let yj = poly[j].y()
    let xi = poly[i].x()
    let xj = poly[j].x()
    if (yi > p.y()) != (yj > p.y()) {
      let x_intersect = xi + (p.y() - yi) / (yj - yi) * (xj - xi)
      if p.x() < x_intersect {
        inside = !inside
      }
    }
    j = i
  }
  inside
}

///|
fn seg_cross(
  a1 : @core.Point2D,
  a2 : @core.Point2D,
  b1 : @core.Point2D,
  b2 : @core.Point2D,
) -> Bool {
  let d1 = @core.turn(b1, b2, a1)
  let d2 = @core.turn(b1, b2, a2)
  let d3 = @core.turn(a1, a2, b1)
  let d4 = @core.turn(a1, a2, b2)
  ((d1 > 0.0 && d2 < 0.0) || (d1 < 0.0 && d2 > 0.0)) &&
  ((d3 > 0.0 && d4 < 0.0) || (d3 < 0.0 && d4 > 0.0))
}
