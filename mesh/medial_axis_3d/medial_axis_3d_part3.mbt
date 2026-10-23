///|
/// Medial axis from point pairs (midpoints of pairs with empty balls).
/// 由点对生成的中轴（空球对的中点）。
pub fn medial_axis_from_pairs(
  points : Array[@core.Point3D],
) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  let n = points.length()
  let eps = 0.0000001
  for i in 0..<n {
    for j in (i + 1)..<n {
      let mid = points[i].add(points[j]).mul(0.5)
      let r = points[i].dist(points[j]) / 2.0
      let ball = MedialBall3D::new(mid, r)
      if is_empty_ball(ball, points, eps) {
        result.push(ball)
      }
    }
  }
  result
}
