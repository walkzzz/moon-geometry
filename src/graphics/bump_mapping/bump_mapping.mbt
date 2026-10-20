///|
/// # Bump Mapping | 凹凸贴图
/// Bump and normal mapping. / 凹凸和法线贴图。
///|
pub fn perturb_normal(normal : (Double, Double, Double), bump : Double) -> (Double, Double, Double) {
  (normal.0, normal.1, normal.2 + bump)
}
///|
pub fn normal_from_height(h00 : Double, h10 : Double, h01 : Double, scale : Double) -> (Double, Double, Double) {
  let dx = (h10 - h00) * scale
  let dy = (h01 - h00) * scale
  let len = (dx * dx + dy * dy + 1.0).sqrt()
  (-dx / len, -dy / len, 1.0 / len)
}
///|
pub fn tangent_space_normal(tangent : (Double, Double, Double), bitangent : (Double, Double, Double), normal : (Double, Double, Double), ts_normal : (Double, Double, Double)) -> (Double, Double, Double) {
  (ts_normal.0 * tangent.0 + ts_normal.1 * bitangent.0 + ts_normal.2 * normal.0,
   ts_normal.0 * tangent.1 + ts_normal.1 * bitangent.1 + ts_normal.2 * normal.1,
   ts_normal.0 * tangent.2 + ts_normal.1 * bitangent.2 + ts_normal.2 * normal.2)
}
