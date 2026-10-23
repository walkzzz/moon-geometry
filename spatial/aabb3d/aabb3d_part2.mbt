///|
/// Construct from a set of points. / 从点集构造。
pub fn AABB3D::from_points(points : Array[@core.Point3D]) -> AABB3D {
  if points.length() == 0 {
    return {
      min_x: 0.0,
      min_y: 0.0,
      min_z: 0.0,
      max_x: 0.0,
      max_y: 0.0,
      max_z: 0.0,
    }
  }
  let mut min_x = points[0].x
  let mut min_y = points[0].y
  let mut min_z = points[0].z
  let mut max_x = points[0].x
  let mut max_y = points[0].y
  let mut max_z = points[0].z
  for p in points {
    if p.x < min_x {
      min_x = p.x
    }
    if p.y < min_y {
      min_y = p.y
    }
    if p.z < min_z {
      min_z = p.z
    }
    if p.x > max_x {
      max_x = p.x
    }
    if p.y > max_y {
      max_y = p.y
    }
    if p.z > max_z {
      max_z = p.z
    }
  }
  { min_x, min_y, min_z, max_x, max_y, max_z, }
}
