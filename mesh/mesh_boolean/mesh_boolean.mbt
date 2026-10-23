///|
/// Boolean operation type. / 布尔运算类型。
pub(all) enum BoolOp {
  Union
  Intersection
  Difference
}

///|

///|
/// Result of mesh boolean operation. / 网格布尔运算结果。
pub struct MeshBoolResult {
  vertices : Array[@core.Point3D]
  faces : Array[(Int32, Int32, Int32)]
}

///|
/// Construct mesh bool result. / 构造网格布尔结果。
pub fn MeshBoolResult::new(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
) -> MeshBoolResult {
  { vertices, faces, }
}

///|
/// Check if a point is inside a mesh (ray casting). / 检查点是否在网格内（射线法）。
fn point_inside_mesh(
  p : @core.Point3D,
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
) -> Bool {
  let ray_dir = @core.Point3D::new(
    0.5773502691896258, 0.5773502691896258, 0.5773502691896258,
  )
  let mut count = 0
  for f in faces {
    let v0 = vertices[f.0]
    let v1 = vertices[f.1]
    let v2 = vertices[f.2]
    if ray_triangle_intersect(p, ray_dir, v0, v1, v2) {
      count += 1
    }
  }
  count % 2 == 1
}

///|
/// Ray-triangle intersection (Moller-Trumbore). / 射线-三角形相交（Moller-Trumbore）。
fn ray_triangle_intersect(
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
/// Mesh boolean union (simple: merge vertices and faces, remove internal). / 网格布尔并集（简单：合并顶点和面，移除内部）。
pub fn mesh_union(
  verts_a : Array[@core.Point3D],
  faces_a : Array[(Int32, Int32, Int32)],
  verts_b : Array[@core.Point3D],
  faces_b : Array[(Int32, Int32, Int32)],
) -> MeshBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[(Int32, Int32, Int32)] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for f in faces_a {
    if !point_inside_mesh(
        centroid3(verts_a[f.0], verts_a[f.1], verts_a[f.2]),
        verts_b,
        faces_b,
      ) {
      result_faces.push(f)
    }
  }
  let offset = verts_a.length()
  for v in verts_b {
    result_verts.push(v)
  }
  for f in faces_b {
    let c = centroid3(verts_b[f.0], verts_b[f.1], verts_b[f.2])
    if !point_inside_mesh(c, verts_a, faces_a) {
      result_faces.push((f.0 + offset, f.1 + offset, f.2 + offset))
    }
  }
  { vertices: result_verts, faces: result_faces, }
}

///|
/// Mesh boolean intersection. / 网格布尔交集。
pub fn mesh_intersection(
  verts_a : Array[@core.Point3D],
  faces_a : Array[(Int32, Int32, Int32)],
  verts_b : Array[@core.Point3D],
  faces_b : Array[(Int32, Int32, Int32)],
) -> MeshBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[(Int32, Int32, Int32)] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for f in faces_a {
    let c = centroid3(verts_a[f.0], verts_a[f.1], verts_a[f.2])
    if point_inside_mesh(c, verts_b, faces_b) {
      result_faces.push(f)
    }
  }
  { vertices: result_verts, faces: result_faces, }
}

///|
/// Mesh boolean difference (A - B). / 网格布尔差集（A - B）。
pub fn mesh_difference(
  verts_a : Array[@core.Point3D],
  faces_a : Array[(Int32, Int32, Int32)],
  verts_b : Array[@core.Point3D],
  faces_b : Array[(Int32, Int32, Int32)],
) -> MeshBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[(Int32, Int32, Int32)] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for f in faces_a {
    let c = centroid3(verts_a[f.0], verts_a[f.1], verts_a[f.2])
    if !point_inside_mesh(c, verts_b, faces_b) {
      result_faces.push(f)
    }
  }
  { vertices: result_verts, faces: result_faces, }
}

///|
fn centroid3(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
) -> @core.Point3D {
  @core.Point3D::new(
    (p0.x + p1.x + p2.x) / 3.0,
    (p0.y + p1.y + p2.y) / 3.0,
    (p0.z + p1.z + p2.z) / 3.0,
  )
}
