///|
/// Full 3D medial axis: combine pair and triple medial balls.
/// 完整三维中轴：合并点对和点三元组中轴球。
pub fn medial_axis_3d(
  points : Array[@core.Point3D],
) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  for ball in medial_axis_from_pairs(points) {
    result.push(ball)
  }
  for ball in medial_axis_from_triples(points) {
    result.push(ball)
  }
  result
}


///|
/// Filter medial balls by radius range. / 按半径范围过滤中轴球。
pub fn medial_axis_filter(
  balls : Array[MedialBall3D],
  r_min : Double,
  r_max : Double,
) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  for ball in balls {
    if ball.radius >= r_min && ball.radius <= r_max {
      result.push(ball)
    }
  }
  result
}
