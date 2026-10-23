///|
/// Compute 3D convex hull (incremental). Returns triangle faces. / 三维凸包。
pub fn convex_hull_3d(points : Array[@core.Point3D]) -> Array[HullFace] {
  let n = points.length()
  if n < 4 {
    return []
  }
  let faces : Array[HullFace] = []
  let visible : Array[Bool] = []
  for i in 0..<n {
    ignore(i)
    visible.push(false)
  }
  for i in 0..<n {
    for j in (i + 1)..<n {
      for k in (j + 1)..<n {
        let normal = face_normal(points[i], points[j], points[k])
        let mut all_below = true
        let mut all_above = true
        for l in 0..<n {
          if l != i && l != j && l != k {
            let d = normal.x * (points[l].x - points[i].x) +
              normal.y * (points[l].y - points[i].y) +
              normal.z * (points[l].z - points[i].z)
            if d > 0.000000000001 {
              all_below = false
            }
            if d < -0.000000000001 {
              all_above = false
            }
          }
        }
        if all_below || all_above {
          faces.push({ v0: i, v1: j, v2: k, })
        }
      }
    }
  }
  faces
}

///|
fn face_normal(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
) -> @core.Point3D {
  let ux = b.x - a.x
  let uy = b.y - a.y
  let uz = b.z - a.z
  let vx = c.x - a.x
  let vy = c.y - a.y
  let vz = c.z - a.z
  @core.Point3D::new(uy * vz - uz * vy, uz * vx - ux * vz, ux * vy - uy * vx)
}
