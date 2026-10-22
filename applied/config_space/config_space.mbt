///|
/// # Configuration Space
/// # 配置空间
///
/// Configuration space obstacle expansion for motion planning.
/// 运动规划的配置空间障碍物膨胀。
///
/// ## Complexity: O(n) for circle expansion, O(n*m) for polygon expansion
/// ## 复杂度: 圆膨胀 O(n)，多边形膨胀 O(n*m)

///|
/// C-space obstacle (expanded obstacle in configuration space). / 配置空间障碍物。
pub struct CSpaceObstacle {
  vertices : Array[@core.Point2D]
}

///|
/// Construct a C-space obstacle. / 构造配置空间障碍物。
pub fn CSpaceObstacle::new(vertices : Array[@core.Point2D]) -> CSpaceObstacle {
  { vertices, }
}

///|
/// Number of vertices in the C-space obstacle. / 配置空间障碍物顶点数。
pub fn CSpaceObstacle::size(self : CSpaceObstacle) -> Int {
  self.vertices.length()
}

///|
/// Get the i-th vertex. / 获取第 i 个顶点。
pub fn CSpaceObstacle::get(self : CSpaceObstacle, i : Int) -> @core.Point2D {
  self.vertices[i]
}

///|
/// Expand a polygonal obstacle by a circular robot radius (Minkowski sum with disk).
/// 用圆形机器人半径膨胀多边形障碍物（与圆盘的闵可夫斯基和）。
///
/// # Arguments / 参数
/// - `obstacle`: polygonal obstacle vertices / 多边形障碍物顶点
/// - `radius`: robot radius / 机器人半径
/// - `num_arc_samples`: number of samples for the circular arc / 圆弧采样数
pub fn cspace_expand_circle(
  obstacle : Array[@core.Point2D],
  radius : Double,
  num_arc_samples : Int,
) -> CSpaceObstacle {
  let n = obstacle.length()
  if n == 0 {
    return CSpaceObstacle::new([])
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let cur = obstacle[i]
    let nxt = obstacle[(i + 1) % n]
    let dx = nxt.x() - cur.x()
    let dy = nxt.y() - cur.y()
    let len = (dx * dx + dy * dy).sqrt()
    if len < 0.000000000001 {
      continue
    }
    let nx = dy / len
    let ny = -dx / len
    result.push(@core.Point2D::new(cur.x() + nx * radius, cur.y() + ny * radius))
    result.push(@core.Point2D::new(nxt.x() + nx * radius, nxt.y() + ny * radius))
  }
  if num_arc_samples > 2 {
    for i in 0..<n {
      let vertex = obstacle[i]
      let prev = obstacle[(i - 1 + n) % n]
      let next = obstacle[(i + 1) % n]
      let dx1 = vertex.x() - prev.x()
      let dy1 = vertex.y() - prev.y()
      let len1 = (dx1 * dx1 + dy1 * dy1).sqrt()
      let dx2 = next.x() - vertex.x()
      let dy2 = next.y() - vertex.y()
      let len2 = (dx2 * dx2 + dy2 * dy2).sqrt()
      if len1 < 0.000000000001 || len2 < 0.000000000001 {
        continue
      }
      let n1x = dy1 / len1
      let n1y = -dx1 / len1
      let n2x = dy2 / len2
      let n2y = -dx2 / len2
      let angle1 = atan2_impl(n1y, n1x)
      let mut angle2 = atan2_impl(n2y, n2x)
      if angle2 < angle1 {
        angle2 += 6.283185307179586
      }
      for s in 1..<(num_arc_samples - 1) {
        let t = s.to_double() / (num_arc_samples - 1).to_double()
        let angle = angle1 + t * (angle2 - angle1)
        result.push(@core.Point2D::new(vertex.x() + radius * cos_impl(angle), vertex.y() + radius * sin_impl(angle)))
      }
    }
  }
  CSpaceObstacle::new(result)
}

fn atan2_impl(y : Double, x : Double) -> Double {
  if x > 0.0 {
    2.0 * atan_approx(y / ((x * x + y * y).sqrt() + x))
  } else if y >= 0.0 && x < 0.0 {
    2.0 * atan_approx((y * y + x * x).sqrt() - x) / y + 3.141592653589793 - 3.141592653589793
  } else if y < 0.0 && x < 0.0 {
    -2.0 * atan_approx((y * y + x * x).sqrt() - x) / (-y)
  } else if y > 0.0 && x == 0.0 {
    1.5707963267948966
  } else if y < 0.0 && x == 0.0 {
    -1.5707963267948966
  } else {
    0.0
  }
}

fn atan_approx(x : Double) -> Double {
  x - x * x * x / 3.0 + x * x * x * x * x / 5.0
}

fn cos_impl(x : Double) -> Double {
  let mut result = 0.0
  let mut term = 1.0
  let x2 = x * x
  for i in 0..<10 {
    result += term
    term = term * (-x2) / ((2 * i + 1).to_double() * (2 * i + 2).to_double())
  }
  result
}

fn sin_impl(x : Double) -> Double {
  let mut result = 0.0
  let mut term = x
  let x2 = x * x
  for i in 0..<10 {
    result += term
    term = term * (-x2) / ((2 * i + 2).to_double() * (2 * i + 3).to_double())
  }
  result
}

///|
/// Expand a polygonal obstacle by a polygonal robot (Minkowski sum).
/// 用多边形机器人膨胀多边形障碍物（闵可夫斯基和）。
///
/// # Arguments / 参数
/// - `obstacle`: polygonal obstacle / 多边形障碍物
/// - `robot`: polygonal robot shape / 多边形机器人形状
pub fn cspace_expand_polygon(
  obstacle : Array[@core.Point2D],
  robot : Array[@core.Point2D],
) -> CSpaceObstacle {
  let neg_robot : Array[@core.Point2D] = []
  for i in 0..<robot.length() {
    neg_robot.push(@core.Point2D::new(-robot[i].x(), -robot[i].y()))
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<obstacle.length() {
    for j in 0..<neg_robot.length() {
      result.push(@core.Point2D::new(obstacle[i].x() + neg_robot[j].x(), obstacle[i].y() + neg_robot[j].y()))
    }
  }
  CSpaceObstacle::new(convex_hull(result))
}

fn convex_hull(points : Array[@core.Point2D]) -> Array[@core.Point2D] {
  if points.length() <= 2 {
    return points
  }
  let sorted = sort_by_x(points)
  let lower : Array[@core.Point2D] = []
  for i in 0..<sorted.length() {
    while lower.length() >= 2 && @core.turn(lower[lower.length() - 2], lower[lower.length() - 1], sorted[i]) <= 0.0 {
      lower.remove(lower.length() - 1) |> ignore
    }
    lower.push(sorted[i])
  }
  let upper : Array[@core.Point2D] = []
  let mut i = sorted.length() - 1
  while i >= 0 {
    while upper.length() >= 2 && @core.turn(upper[upper.length() - 2], upper[upper.length() - 1], sorted[i]) <= 0.0 {
      upper.remove(upper.length() - 1) |> ignore
    }
    upper.push(sorted[i])
    i -= 1
  }
  lower.remove(lower.length() - 1) |> ignore
  upper.remove(upper.length() - 1) |> ignore
  for j in 0..<upper.length() {
    lower.push(upper[j])
  }
  lower
}

fn sort_by_x(points : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<points.length() {
    result.push(points[i])
  }
  result.sort_by(fn(a, b) {
    if a.x() < b.x() {
      -1
    } else if a.x() > b.x() {
      1
    } else if a.y() < b.y() {
      -1
    } else if a.y() > b.y() {
      1
    } else {
      0
    }
  })
  result
}

///|
/// Check if a configuration point is valid (not inside any C-space obstacle). / 检查配置点是否有效（不在任何配置空间障碍物内）。
pub fn cspace_point_valid(
  q : @core.Point2D,
  cspace_obstacles : Array[CSpaceObstacle],
) -> Bool {
  for i in 0..<cspace_obstacles.length() {
    if point_in_polygon(q, cspace_obstacles[i].vertices) {
      return false
    }
  }
  true
}

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

///|
/// Build C-space obstacles from multiple polygonal obstacles and a circular robot. / 从多个多边形障碍物和圆形机器人构建配置空间障碍物。
pub fn cspace_build(
  obstacles : Array[Array[@core.Point2D]],
  robot_radius : Double,
  num_arc_samples : Int,
) -> Array[CSpaceObstacle] {
  let result : Array[CSpaceObstacle] = []
  for i in 0..<obstacles.length() {
    result.push(cspace_expand_circle(obstacles[i], robot_radius, num_arc_samples))
  }
  result
}