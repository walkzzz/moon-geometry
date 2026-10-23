///|
/// Medial axis from point triples (circumcenters with empty balls).
/// 由点三元组生成的中轴（空球外心）。
pub fn medial_axis_from_triples(
  points : Array[@core.Point3D],
) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  let n = points.length()
  let eps = 0.0000001
  for i in 0..<n {
    for j in (i + 1)..<n {
      for k in (j + 1)..<n {
        match circumcircle(points[i], points[j], points[k]) {
          Some(ball) =>
            if is_empty_ball(ball, points, eps) {
              result.push(ball)
            }
          None => continue
        }
      }
    }
  }
  result
}
