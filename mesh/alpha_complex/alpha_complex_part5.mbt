///|
/// Compute the alpha complex of a 2D point set. / 计算二维点集的 Alpha 复形。
pub fn alpha_complex(
  points : Array[@core.Point2D],
  alpha : Double,
) -> AlphaComplex {
  let n = points.length()
  if n == 0 {
    return { simplices: [], alpha }
  }
  let simplices : Array[AlphaSimplex] = []
  for i in 0..<n {
    simplices.push({ vertices: [i], dimension: 0, circumradius: 0.0 })
  }
  for i in 0..<n {
    for j in (i + 1)..<n {
      let mid = @core.Point2D::new(
        (points[i].x() + points[j].x()) / 2.0,
        (points[i].y() + points[j].y()) / 2.0,
      )
      let radius = mid.dist(points[i])
      if radius <= alpha + 0.0000000001 {
        simplices.push({ vertices: [i, j], dimension: 1, circumradius: radius })
      }
    }
  }
  let tris = delaunay_2d(points)
  for t in tris {
    let center = circumcenter(points[t.0], points[t.1], points[t.2])
    let radius = center.dist(points[t.0])
    if radius <= alpha + 0.0000000001 {
      simplices.push({
        vertices: [t.0, t.1, t.2],
        dimension: 2,
        circumradius: radius,
      })
    }
  }
  { simplices, alpha }
}
