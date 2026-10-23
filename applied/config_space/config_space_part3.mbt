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
  num_arc_samples : Int32,
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
    result.push(
      @core.Point2D::new(cur.x() + nx * radius, cur.y() + ny * radius),
    )
    result.push(
      @core.Point2D::new(nxt.x() + nx * radius, nxt.y() + ny * radius),
    )
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
        result.push(
          @core.Point2D::new(
            vertex.x() + radius * cos_impl(angle),
            vertex.y() + radius * sin_impl(angle),
          ),
        )
      }
    }
  }
  CSpaceObstacle::new(result)
}

///|
fn atan2_impl(y : Double, x : Double) -> Double {
  if x > 0.0 {
    2.0 * atan_approx(y / ((x * x + y * y).sqrt() + x))
  } else if y >= 0.0 && x < 0.0 {
    2.0 * atan_approx((y * y + x * x).sqrt() - x) / y +
    3.141592653589793 -
    3.141592653589793
  } else if y < 0.0 && x < 0.0 {
    -2.0 * atan_approx((y * y + x * x).sqrt() - x) / -y
  } else if y > 0.0 && x == 0.0 {
    1.5707963267948966
  } else if y < 0.0 && x == 0.0 {
    -1.5707963267948966
  } else {
    0.0
  }
}

///|
fn atan_approx(x : Double) -> Double {
  x - x * x * x / 3.0 + x * x * x * x * x / 5.0
}

///|
fn cos_impl(x : Double) -> Double {
  let mut result = 0.0
  let mut term = 1.0
  let x2 = x * x
  for i in 0..<10 {
    result += term
    term = term * -x2 / ((2 * i + 1).to_double() * (2 * i + 2).to_double())
  }
  result
}

///|
fn sin_impl(x : Double) -> Double {
  let mut result = 0.0
  let mut term = x
  let x2 = x * x
  for i in 0..<10 {
    result += term
    term = term * -x2 / ((2 * i + 2).to_double() * (2 * i + 3).to_double())
  }
  result
}
