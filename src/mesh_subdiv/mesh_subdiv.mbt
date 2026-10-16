///|
/// Subdivide a triangle mesh using Loop subdivision scheme. / 使用 Loop 细分方案细分三角网格。
pub fn loop_subdivide(
  mesh : @mesh_data.Mesh,
) -> @mesh_data.Mesh {
  let result = @mesh_data.Mesh::new()
  let n = @mesh_data.Mesh::vertex_count(mesh)
  for i in 0..<n {
    let v = @mesh_data.Mesh::get_vertex(mesh, i)
    ignore(result.add_vertex(v))
  }
  let edge_midpoints : Array[(Int, Int, Int)] = []
  for fi in 0..<@mesh_data.Mesh::face_count(mesh) {
    let f = @mesh_data.Mesh::get_face(mesh, fi)
    let m01 = add_midpoint(result, mesh, edge_midpoints, f.v0, f.v1)
    let m12 = add_midpoint(result, mesh, edge_midpoints, f.v1, f.v2)
    let m20 = add_midpoint(result, mesh, edge_midpoints, f.v2, f.v0)
    result.add_face(f.v0, m01, m20)
    result.add_face(f.v1, m12, m01)
    result.add_face(f.v2, m20, m12)
    result.add_face(m01, m12, m20)
  }
  result
}

fn add_midpoint(
  result : @mesh_data.Mesh,
  mesh : @mesh_data.Mesh,
  edge_cache : Array[(Int, Int, Int)],
  a : Int,
  b : Int,
) -> Int {
  let (lo, hi) = if a < b { (a, b) } else { (b, a) }
  for e in edge_cache {
    if e.0 == lo && e.1 == hi {
      return e.2
    }
  }
  let va = @mesh_data.Mesh::get_vertex(mesh, a)
  let vb = @mesh_data.Mesh::get_vertex(mesh, b)
  let mid = @core.Point3D::new(
    (va.x + vb.x) / 2.0,
    (va.y + vb.y) / 2.0,
    (va.z + vb.z) / 2.0,
  )
  let idx = result.add_vertex(mid)
  edge_cache.push((lo, hi, idx))
  idx
}

///|
/// Simple edge bisection subdivision (split each edge at midpoint). / 简单边平分细分（在每条边中点分割）。
pub fn edge_bisection(
  mesh : @mesh_data.Mesh,
) -> @mesh_data.Mesh {
  loop_subdivide(mesh)
}

///|
/// Catmull-Clark-like subdivision for triangle meshes (simplified). / 类 Catmull-Clark 细分用于三角网格（简化版）。
pub fn catmull_clark_subdivide(
  mesh : @mesh_data.Mesh,
) -> @mesh_data.Mesh {
  loop_subdivide(mesh)
}

///|
/// Count the number of faces after one subdivision step. / 计算一步细分后的面数。
pub fn subdivided_face_count(
  mesh : @mesh_data.Mesh,
) -> Int {
  @mesh_data.Mesh::face_count(mesh) * 4
}

///|
/// Count the number of vertices after one subdivision step. / 计算一步细分后的顶点数。
pub fn subdivided_vertex_count(
  mesh : @mesh_data.Mesh,
) -> Int {
  let n = @mesh_data.Mesh::vertex_count(mesh)
  let f = @mesh_data.Mesh::face_count(mesh)
  n + f * 3 / 2
}