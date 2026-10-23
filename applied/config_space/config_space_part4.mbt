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
      result.push(
        @core.Point2D::new(
          obstacle[i].x() + neg_robot[j].x(),
          obstacle[i].y() + neg_robot[j].y(),
        ),
      )
    }
  }
  CSpaceObstacle::new(convex_hull(result))
}

///|
fn convex_hull(points : Array[@core.Point2D]) -> Array[@core.Point2D] {
  if points.length() <= 2 {
    return points
  }
  let sorted = sort_by_x(points)
  let lower : Array[@core.Point2D] = []
  for i in 0..<sorted.length() {
    while lower.length() >= 2 &&
          @core.turn(
            lower[lower.length() - 2],
            lower[lower.length() - 1],
            sorted[i],
          ) <=
          0.0 {
      lower.remove(lower.length() - 1) |> ignore
    }
    lower.push(sorted[i])
  }
  let upper : Array[@core.Point2D] = []
  let mut i = sorted.length() - 1
  while i >= 0 {
    while upper.length() >= 2 &&
          @core.turn(
            upper[upper.length() - 2],
            upper[upper.length() - 1],
            sorted[i],
          ) <=
          0.0 {
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

///|
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
