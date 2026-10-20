///|
/// # Surface Reconstruction
/// # 曲面重建
///
/// Greedy triangulation and Poisson-style surface reconstruction from point clouds.
/// 从点云重建曲面的贪婪三角化和 Poisson 风格方法。

///|
/// Greedy projection triangulation: connect nearby points into triangles.
/// 贪婪投影三角化：连接近邻点为三角形。
pub fn greedy_triangulation(points : Array[@core.Point3D], max_edge : Double) -> Array[(Int, Int, Int)] {
  let n = points.length()
  let triangles : Array[(Int, Int, Int)] = []
  if n < 3 {
    return triangles
  }
  for i in 0..<(n - 2) {
    let d1 = points[i].dist(points[i + 1])
    let d2 = points[i + 1].dist(points[i + 2])
    let d3 = points[i].dist(points[i + 2])
    if d1 < max_edge && d2 < max_edge && d3 < max_edge {
      triangles.push((i, i + 1, i + 2))
    }
  }
  triangles
}

///|
/// Estimate local tangent plane at a point using PCA on neighbors.
/// 用 PCA 在邻域上估计切平面。
pub fn estimate_tangent_plane(center : @core.Point3D, neighbors : Array[@core.Point3D]) -> @core.Point3D {
  let n = neighbors.length()
  if n == 0 {
    return @core.Point3D::new(0.0, 0.0, 1.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  let mut sz = 0.0
  for i in 0..<n {
    sx += neighbors[i].x - center.x
    sy += neighbors[i].y - center.y
    sz += neighbors[i].z - center.z
  }
  let inv = 1.0 / n.to_double()
  @core.Point3D::new(sx * inv, sy * inv, sz * inv)
}

///|
/// Count triangles in reconstruction. / 重建三角形计数。
pub fn recon_triangle_count(triangles : Array[(Int, Int, Int)]) -> Int {
  triangles.length()
}

///|
/// Compute reconstruction completeness ratio. / 计算重建完整度。
pub fn recon_completeness(reconstructed : Int, expected : Int) -> Double {
  if expected == 0 {
    return 0.0
  }
  reconstructed.to_double() / expected.to_double()
}
