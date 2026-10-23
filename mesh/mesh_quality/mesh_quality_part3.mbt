///|
/// Compute average quality of a mesh. / 计算网格的平均质量。
pub fn mesh_average_quality(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
) -> MeshQualityMetrics {
  let n = faces.length()
  if n == 0 {
    return {
      aspect_ratio: 0.0,
      area_ratio: 0.0,
      min_angle: 0.0,
      max_angle: 0.0,
      edge_ratio: 0.0,
    }
  }
  let mut sum_ar = 0.0
  let mut sum_area_r = 0.0
  let mut sum_min_a = 0.0
  let mut sum_max_a = 0.0
  let mut sum_er = 0.0
  for f in faces {
    let q = triangle_quality(vertices[f.0], vertices[f.1], vertices[f.2])
    sum_ar += q.aspect_ratio
    sum_area_r += q.area_ratio
    sum_min_a += q.min_angle
    sum_max_a += q.max_angle
    sum_er += q.edge_ratio
  }
  {
    aspect_ratio: sum_ar / n.to_double(),
    area_ratio: sum_area_r / n.to_double(),
    min_angle: sum_min_a / n.to_double(),
    max_angle: sum_max_a / n.to_double(),
    edge_ratio: sum_er / n.to_double(),
  }
}

///|
/// Count degenerate triangles (zero area). / 统计退化三角形（零面积）数量。
pub fn count_degenerate(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
  eps : Double,
) -> Int32 {
  let mut count = 0
  for f in faces {
    let p0 = vertices[f.0]
    let p1 = vertices[f.1]
    let p2 = vertices[f.2]
    let v1 = p1.sub(p0)
    let v2 = p2.sub(p0)
    let cross = v1.cross(v2)
    let area = 0.5 * cross.dist_sq(@core.Point3D::new(0.0, 0.0, 0.0)).sqrt()
    if area < eps {
      count += 1
    }
  }
  count
}
