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
  { aspect_ratio, area_ratio, min_angle, max_angle, edge_ratio, }
}
