///|
/// # Ray Trace Operations | 光线追踪操作
/// Ray tracing helper functions. / 光线追踪辅助函数。
///|
pub fn reflect(incident : (Double, Double, Double), normal : (Double, Double, Double)) -> (Double, Double, Double) {
  let dot = incident.0 * normal.0 + incident.1 * normal.1 + incident.2 * normal.2
  (incident.0 - 2.0 * dot * normal.0, incident.1 - 2.0 * dot * normal.1, incident.2 - 2.0 * dot * normal.2)
}
///|
pub fn refract(incident : (Double, Double, Double), normal : (Double, Double, Double), eta : Double) -> (Double, Double, Double) {
  let dot = incident.0 * normal.0 + incident.1 * normal.1 + incident.2 * normal.2
  let k = 1.0 - eta * eta * (1.0 - dot * dot)
  if k < 0.0 { (0.0, 0.0, 0.0) } else {
    (eta * incident.0 - (eta * dot + k.sqrt()) * normal.0,
     eta * incident.1 - (eta * dot + k.sqrt()) * normal.1,
     eta * incident.2 - (eta * dot + k.sqrt()) * normal.2)
  }
}
///|
pub fn fresnel_schlick(cos_theta : Double, f0 : Double) -> Double {
  f0 + (1.0 - f0) * @math.pow(1.0 - cos_theta, 5.0)
}
///|
pub fn ray_plane_t(origin : (Double, Double, Double), dir : (Double, Double, Double), point : (Double, Double, Double), normal : (Double, Double, Double)) -> Double {
  let denom = dir.0 * normal.0 + dir.1 * normal.1 + dir.2 * normal.2
  if denom.abs() < 0.000000000001 { -1.0 } else {
    let dx = point.0 - origin.0; let dy = point.1 - origin.1; let dz = point.2 - origin.2
    let t = (dx * normal.0 + dy * normal.1 + dz * normal.2) / denom
    if t < 0.0 { -1.0 } else { t }
  }
}
