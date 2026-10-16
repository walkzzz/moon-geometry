///|
/// # Shading Model | 着色模型
/// Phong, Gouraud shading. / Phong、Gouraud 着色。
///|
pub fn lambertian(normal : (Double, Double, Double), light_dir : (Double, Double, Double)) -> Double {
  let d = normal.0 * light_dir.0 + normal.1 * light_dir.1 + normal.2 * light_dir.2
  if d > 0.0 { d } else { 0.0 }
}
///|
pub fn phong(normal : (Double, Double, Double), light_dir : (Double, Double, Double), view_dir : (Double, Double, Double), shininess : Double) -> Double {
  let diffuse = lambertian(normal, light_dir)
  let rx = 2.0 * (normal.0 * light_dir.0 + normal.1 * light_dir.1 + normal.2 * light_dir.2) * normal.0 - light_dir.0
  let ry = 2.0 * (normal.0 * light_dir.0 + normal.1 * light_dir.1 + normal.2 * light_dir.2) * normal.1 - light_dir.1
  let rz = 2.0 * (normal.0 * light_dir.0 + normal.1 * light_dir.1 + normal.2 * light_dir.2) * normal.2 - light_dir.2
  let spec_dot = rx * view_dir.0 + ry * view_dir.1 + rz * view_dir.2
  let specular = if spec_dot > 0.0 { @math.pow(spec_dot, shininess) } else { 0.0 }
  diffuse + specular
}
///|
pub fn blinn_phong(normal : (Double, Double, Double), light_dir : (Double, Double, Double), view_dir : (Double, Double, Double), shininess : Double) -> Double {
  let diffuse = lambertian(normal, light_dir)
  let hx = light_dir.0 + view_dir.0; let hy = light_dir.1 + view_dir.1; let hz = light_dir.2 + view_dir.2
  let hlen = (hx * hx + hy * hy + hz * hz).sqrt()
  let mut spec = 0.0
  if hlen > 0.000000000001 {
    let ndoth = (normal.0 * hx + normal.1 * hy + normal.2 * hz) / hlen
    if ndoth > 0.0 { spec = @math.pow(ndoth, shininess) }
  }
  diffuse + spec
}
///|
pub fn cook_torrance(ndotl : Double, ndotv : Double, ndoth : Double, vdoth : Double, roughness : Double, f0 : Double) -> Double {
  let fresnel = f0 + (1.0 - f0) * @math.pow(1.0 - vdoth, 5.0)
  let a2 = roughness * roughness
  let d = a2 / (@math.PI * @math.pow(ndoth * ndoth * (a2 - 1.0) + 1.0, 2.0))
  let k = roughness / 2.0
  let g = ndotl / (ndotl * (1.0 - k) + k) * ndotv / (ndotv * (1.0 - k) + k)
  if ndotv.abs() < 0.000000000001 { 0.0 } else { fresnel * d * g / (4.0 * ndotl * ndotv) }
}
