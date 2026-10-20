///|
/// Add a vertex to a mesh from coordinates. Returns vertex index. / 从坐标添加顶点到网格，返回顶点索引。
pub fn add_vertex_coords(
  mesh : @mesh_data.Mesh,
  x : Double,
  y : Double,
  z : Double,
) -> Int {
  mesh.add_vertex(@core.Point3D::new(x, y, z))
}

///|
/// Simplify a mesh by collapsing edges shorter than threshold. / 通过折叠短于阈值的边来简化网格。
pub fn simplify_by_edge_length(
  mesh : @mesh_data.Mesh,
  threshold : Double,
) -> @mesh_data.Mesh {
  let result = @mesh_data.Mesh::new()
  let old_to_new : Array[Int] = Array::make(@mesh_data.Mesh::vertex_count(mesh), -1)
  for i in 0..<@mesh_data.Mesh::vertex_count(mesh) {
    let v = @mesh_data.Mesh::get_vertex(mesh, i)
    let mut keep = true
    for j in 0..<@mesh_data.Mesh::vertex_count(mesh) {
      if i == j || old_to_new[j] == -1 {
        continue
      }
      let vj = @mesh_data.Mesh::get_vertex(mesh, j)
      if v.dist(vj) < threshold {
        old_to_new[i] = old_to_new[j]
        keep = false
        break
      }
    }
    if keep {
      old_to_new[i] = result.add_vertex(v)
    }
  }
  for i in 0..<@mesh_data.Mesh::face_count(mesh) {
    let f = @mesh_data.Mesh::get_face(mesh, i)
    let n0 = old_to_new[f.v0]
    let n1 = old_to_new[f.v1]
    let n2 = old_to_new[f.v2]
    if n0 != n1 && n1 != n2 && n0 != n2 {
      result.add_face(n0, n1, n2)
    }
  }
  result
}

///|
/// Compute the cost of collapsing an edge (distance between endpoints). / 计算折叠边的代价（端点间距离）。
pub fn edge_collapse_cost(
  mesh : @mesh_data.Mesh,
  v0 : Int,
  v1 : Int,
) -> Double {
  @mesh_data.Mesh::get_vertex(mesh, v0).dist(@mesh_data.Mesh::get_vertex(mesh, v1))
}

///|
/// Count the number of edges that can be collapsed. / 计算可折叠的边数。
pub fn collapsible_edges(
  mesh : @mesh_data.Mesh,
  threshold : Double,
) -> Int {
  let mut count = 0
  let n = @mesh_data.Mesh::vertex_count(mesh)
  for i in 0..<n {
    for j in (i + 1)..<n {
      if edge_collapse_cost(mesh, i, j) < threshold {
        count += 1
      }
    }
  }
  count
}

///|
/// Compute the simplification ratio. / 计算简化率。
pub fn simplification_ratio(
  original : @mesh_data.Mesh,
  simplified : @mesh_data.Mesh,
) -> Double {
  let orig_count = @mesh_data.Mesh::vertex_count(original)
  if orig_count == 0 {
    return 0.0
  }
  1.0 - @mesh_data.Mesh::vertex_count(simplified).to_double() / orig_count.to_double()
}