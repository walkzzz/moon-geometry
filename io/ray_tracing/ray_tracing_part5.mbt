///|
/// Check if a point is in shadow relative to a light source.
/// 检查点相对于光源是否在阴影中。
pub fn point_in_shadow(
  point : @core.Point3D,
  light : @core.Point3D,
  triangles : Array[(@core.Point3D, @core.Point3D, @core.Point3D)],
) -> Bool {
  let eps = 0.0001
  let to_light = light.sub(point)
  let dist = to_light.x * to_light.x + to_light.y * to_light.y + to_light.z * to_light.z
  let dist_sqrt = dist.sqrt()
  if dist_sqrt < eps {
    return false
  }
  let dir = @core.Point3D::new(
    to_light.x / dist_sqrt,
    to_light.y / dist_sqrt,
    to_light.z / dist_sqrt,
  )
  let ray = Ray3::new(point, dir)
  for tri in triangles {
    match ray_triangle_intersect(ray, tri.0, tri.1, tri.2) {
      Some(t) =>
        if t > eps && t < dist_sqrt - eps {
          return true
        }
      None => ()
    }
  }
  false
}
