///|
/// Check if point is inside polyhedron (ray casting). / 检查点是否在多面体内（射线法）。
fn point_in_polyhedron(
  p : @core.Point3D,
  vertices : Array[@core.Point3D],
  faces : Array[Array[Int]],
) -> Bool {
  let ray_dir = @core.Point3D::new(0.5773502691896258, 0.5773502691896258, 0.5773502691896258)
  let mut count = 0
  for face in faces {
    let n = face.length()
    if n < 3 {
      continue
    }
    let v0 = vertices[face[0]]
    for i in 1..<(n - 1) {
      let v1 = vertices[face[i]]
      let v2 = vertices[face[i + 1]]
      if ray_tri(p, ray_dir, v0, v1, v2) {
        count += 1
      }
    }
  }
  count % 2 == 1
}

fn ray_tri(
  origin : @core.Point3D,
  dir : @core.Point3D,
  v0 : @core.Point3D,
  v1 : @core.Point3D,
  v2 : @core.Point3D,
) -> Bool {
  let eps = 0.0000000001
  let edge1 = v1.sub(v0)
  let edge2 = v2.sub(v0)
  let h = dir.cross(edge2)
  let a = edge1.dot(h)
  if a.abs() < eps {
    return false
  }
  let f = 1.0 / a
  let s = origin.sub(v0)
  let u = f * s.dot(h)
  if u < 0.0 || u > 1.0 {
    return false
  }
  let q = s.cross(edge1)
  let v = f * dir.dot(q)
  if v < 0.0 || u + v > 1.0 {
    return false
  }
  let t = f * edge2.dot(q)
  t > eps
}
