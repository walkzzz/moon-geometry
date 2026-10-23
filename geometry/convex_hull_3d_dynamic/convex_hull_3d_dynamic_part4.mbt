///|
/// Compute hull volume. / 计算凸包体积。
pub fn DynamicHull3D::volume(h : DynamicHull3D) -> Double {
  let mut vol = 0.0
  for f in h.hull_faces {
    let v0 = h.points[f.0]
    let v1 = h.points[f.1]
    let v2 = h.points[f.2]
    vol += v0.dot(v1.cross(v2))
  }
  vol / 6.0
}

///|
/// Compute hull surface area. / 计算凸包表面积。
pub fn DynamicHull3D::surface_area(h : DynamicHull3D) -> Double {
  let mut area = 0.0
  for f in h.hull_faces {
    let v0 = h.points[f.0]
    let v1 = h.points[f.1]
    let v2 = h.points[f.2]
    let cross = v1.sub(v0).cross(v2.sub(v0))
    area += 0.5 *
      (cross.x * cross.x + cross.y * cross.y + cross.z * cross.z).sqrt()
  }
  area
}
