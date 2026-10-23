///|
/// Compute the Betti number b0 (number of connected components, approximation). / 计算 Betti 数 b0（连通分量数，近似）。
pub fn betti_0(mesh : @mesh_data.Mesh) -> Int32 {
  let n = @mesh_data.Mesh::vertex_count(mesh)
  if n == 0 {
    return 0
  }
  let visited = Array::make(n, false)
  let mut components = 0
  for start in 0..<n {
    if visited[start] {
      continue
    }
    components += 1
    let queue : Array[Int32] = [start]
    visited[start] = true
    while queue.length() > 0 {
      let v = queue.remove(0)
      for fi in 0..<@mesh_data.Mesh::face_count(mesh) {
        let f = @mesh_data.Mesh::get_face(mesh, fi)
        let neighbors = get_face_neighbors(f, v)
        for u in neighbors {
          if !visited[u] {
            visited[u] = true
            queue.push(u)
          }
        }
      }
    }
  }
  components
}

///|
fn get_face_neighbors(f : @mesh_data.MeshFace, v : Int32) -> Array[Int32] {
  let result : Array[Int32] = []
  if f.v0 == v {
    result.push(f.v1)
    result.push(f.v2)
  }
  if f.v1 == v {
    result.push(f.v0)
    result.push(f.v2)
  }
  if f.v2 == v {
    result.push(f.v0)
    result.push(f.v1)
  }
  result
}
