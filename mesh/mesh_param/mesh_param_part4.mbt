///|
/// Compute area distortion of parameterization. / 计算参数化面积畸变。
pub fn area_distortion(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
  uv : Array[UV],
) -> Double {
  let mut total_3d = 0.0
  let mut total_2d = 0.0
  for f in faces {
    let p0 = vertices[f.0]
    let p1 = vertices[f.1]
    let p2 = vertices[f.2]
    let v1 = p1.sub(p0)
    let v2 = p2.sub(p0)
    let cross = v1.cross(v2)
    total_3d += 0.5 *
      (cross.x * cross.x + cross.y * cross.y + cross.z * cross.z).sqrt()
    let du1 = uv[f.1].u - uv[f.0].u
    let dv1 = uv[f.1].v - uv[f.0].v
    let du2 = uv[f.2].u - uv[f.0].u
    let dv2 = uv[f.2].v - uv[f.0].v
    total_2d += 0.5 * (du1 * dv2 - du2 * dv1).abs()
  }
  if total_2d > 0.0000000001 {
    (total_3d - total_2d).abs() / total_3d
  } else {
    0.0
  }
}
