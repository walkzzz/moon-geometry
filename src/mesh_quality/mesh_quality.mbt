///|
/// Mesh quality metrics for a single triangle. / 单个三角形的网格质量度量。
pub struct MeshQualityMetrics {
  aspect_ratio : Double
  area_ratio : Double
  min_angle : Double
  max_angle : Double
  edge_ratio : Double
}

///|
/// Construct quality metrics. / 构造质量度量。
pub fn MeshQualityMetrics::new(
  aspect_ratio : Double,
  area_ratio : Double,
  min_angle : Double,
  max_angle : Double,
  edge_ratio : Double,
) -> MeshQualityMetrics {
  { aspect_ratio, area_ratio, min_angle, max_angle, edge_ratio }
}

///|
/// Compute quality metrics for a triangle. / 计算三角形的质量度量。
pub fn triangle_quality(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
) -> MeshQualityMetrics {
  let e0 = p1.dist(p2)
  let e1 = p2.dist(p0)
  let e2 = p0.dist(p1)
  let s = (e0 + e1 + e2) / 2.0
  let area = (s * (s - e0) * (s - e1) * (s - e2)).sqrt()
  let min_edge = if e0 < e1 { (if e0 < e2 { e0 } else { e2 }) } else { (if e1 < e2 { e1 } else { e2 }) }
  let max_edge = if e0 > e1 { (if e0 > e2 { e0 } else { e2 }) } else { (if e1 > e2 { e1 } else { e2 }) }
  let edge_ratio = if min_edge > 0.0000000001 { max_edge / min_edge } else { 1.7976931348623157e+308 }
  let circumradius = if area > 0.0000000001 { e0 * e1 * e2 / (4.0 * area) } else { 1.7976931348623157e+308 }
  let inradius = if s > 0.0000000001 { area / s } else { 0.0 }
  let aspect_ratio = if inradius > 0.0000000001 { circumradius / inradius } else { 1.7976931348623157e+308 }
  let a0 = angle_between(e1, e2, e0)
  let a1 = angle_between(e0, e2, e1)
  let a2 = angle_between(e0, e1, e2)
  let min_angle = if a0 < a1 { (if a0 < a2 { a0 } else { a2 }) } else { (if a1 < a2 { a1 } else { a2 }) }
  let max_angle = if a0 > a1 { (if a0 > a2 { a0 } else { a2 }) } else { (if a1 > a2 { a1 } else { a2 }) }
  let eq_area = 0.4330127018922193 * max_edge * max_edge
  let area_ratio = if eq_area > 0.0000000001 { area / eq_area } else { 0.0 }
  { aspect_ratio, area_ratio, min_angle, max_angle, edge_ratio }
}

fn angle_between(a : Double, b : Double, c : Double) -> Double {
  let denom = 2.0 * a * b
  if denom < 0.0000000001 {
    return 0.0
  }
  let cos_c = (a * a + b * b - c * c) / denom
  if cos_c > 1.0 {
    0.0
  } else if cos_c < -1.0 {
    3.14159265358979323846
  } else {
    @math.acos(cos_c)
  }
}

///|
/// Compute average quality of a mesh. / 计算网格的平均质量。
pub fn mesh_average_quality(
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
) -> MeshQualityMetrics {
  let n = faces.length()
  if n == 0 {
    return { aspect_ratio: 0.0, area_ratio: 0.0, min_angle: 0.0, max_angle: 0.0, edge_ratio: 0.0 }
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
  faces : Array[(Int, Int, Int)],
  eps : Double,
) -> Int {
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