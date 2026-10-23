///|
/// Compute the alpha shape (boundary edges of the alpha complex). / 计算 Alpha 形（Alpha 复形的边界边）。
pub fn alpha_shape(
  points : Array[@core.Point2D],
  alpha : Double,
) -> Array[(Int, Int)] {
  let ac = alpha_complex(points, alpha)
  let edge_count : Array[(Int, Int, Int)] = []
  for s in ac.simplices {
    if s.dimension == 1 && s.vertices.length() == 2 {
      let a = s.vertices[0]
      let b = s.vertices[1]
      let (lo, hi) = if a < b {
        (a, b)
      } else {
        (b, a)
      }
      add_e(edge_count, lo, hi)
    }
    if s.dimension == 2 && s.vertices.length() == 3 {
      let v = s.vertices
      add_e(edge_count, v[0], v[1])
      add_e(edge_count, v[1], v[2])
      add_e(edge_count, v[2], v[0])
    }
  }
  let boundary : Array[(Int, Int)] = []
  for e in edge_count {
    if e.2 == 1 {
      boundary.push((e.0, e.1))
    }
  }
  boundary
}
