///|
/// Check if the triangulation satisfies the Delaunay property. / 检查三角剖分是否满足 Delaunay 性质。
pub fn is_delaunay(d : Delaunay3D) -> Bool {
  for t in d.tetrahedra {
    let a = d.vertices[t.v0]
    let b = d.vertices[t.v1]
    let c = d.vertices[t.v2]
    let e = d.vertices[t.v3]
    let center = circumsphere_center(a, b, c, e)
    let radius_sq = center.dist_sq(a)
    for i in 0..<d.vertices.length() {
      if i == t.v0 || i == t.v1 || i == t.v2 || i == t.v3 {
        continue
      }
      if center.dist_sq(d.vertices[i]) < radius_sq - 0.0000001 {
        return false
      }
    }
  }
  true
}
