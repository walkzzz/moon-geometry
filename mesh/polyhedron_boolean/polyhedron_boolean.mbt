///|
/// Polyhedron boolean operation result. / 多面体布尔运算结果。
pub struct PolyBoolResult {
  vertices : Array[@core.Point3D]
  faces : Array[Array[Int32]]
  success : Bool
}

///|
/// Construct poly bool result. / 构造多面体布尔结果。
pub fn PolyBoolResult::new(
  vertices : Array[@core.Point3D],
  faces : Array[Array[Int32]],
  success : Bool,
) -> PolyBoolResult {
  { vertices, faces, success, }
}

///|
/// Check if point is inside polyhedron (ray casting). / 检查点是否在多面体内（射线法）。
fn point_in_polyhedron(
  p : @core.Point3D,
  vertices : Array[@core.Point3D],
  faces : Array[Array[Int32]],
) -> Bool {
  let ray_dir = @core.Point3D::new(
    0.5773502691896258, 0.5773502691896258, 0.5773502691896258,
  )
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

///|
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

///|
/// Polyhedron union. / 多面体并集。
pub fn polyhedron_union(
  verts_a : Array[@core.Point3D],
  faces_a : Array[Array[Int32]],
  verts_b : Array[@core.Point3D],
  faces_b : Array[Array[Int32]],
) -> PolyBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[Array[Int32]] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for face in faces_a {
    let c = face_centroid(face, verts_a)
    if !point_in_polyhedron(c, verts_b, faces_b) {
      result_faces.push(face)
    }
  }
  let offset = verts_a.length()
  for v in verts_b {
    result_verts.push(v)
  }
  for face in faces_b {
    let c = face_centroid(face, verts_b)
    if !point_in_polyhedron(c, verts_a, faces_a) {
      let new_face : Array[Int32] = []
      for idx in face {
        new_face.push(idx + offset)
      }
      result_faces.push(new_face)
    }
  }
  { vertices: result_verts, faces: result_faces, success: true, }
}

///|
/// Polyhedron intersection. / 多面体交集。
pub fn polyhedron_intersection(
  verts_a : Array[@core.Point3D],
  faces_a : Array[Array[Int32]],
  verts_b : Array[@core.Point3D],
  faces_b : Array[Array[Int32]],
) -> PolyBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[Array[Int32]] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for face in faces_a {
    let c = face_centroid(face, verts_a)
    if point_in_polyhedron(c, verts_b, faces_b) {
      result_faces.push(face)
    }
  }
  { vertices: result_verts, faces: result_faces, success: true, }
}

///|
/// Polyhedron difference (A - B). / 多面体差集（A - B）。
pub fn polyhedron_difference(
  verts_a : Array[@core.Point3D],
  faces_a : Array[Array[Int32]],
  verts_b : Array[@core.Point3D],
  faces_b : Array[Array[Int32]],
) -> PolyBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[Array[Int32]] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for face in faces_a {
    let c = face_centroid(face, verts_a)
    if !point_in_polyhedron(c, verts_b, faces_b) {
      result_faces.push(face)
    }
  }
  { vertices: result_verts, faces: result_faces, success: true, }
}

///|
fn face_centroid(
  face : Array[Int32],
  verts : Array[@core.Point3D],
) -> @core.Point3D {
  let n = face.length()
  if n == 0 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  let mut cx = 0.0
  let mut cy = 0.0
  let mut cz = 0.0
  for idx in face {
    cx += verts[idx].x
    cy += verts[idx].y
    cz += verts[idx].z
  }
  @core.Point3D::new(cx / n.to_double(), cy / n.to_double(), cz / n.to_double())
}
