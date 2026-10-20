///|
/// Compute the Euler characteristic χ = V - E + F of a mesh. / 计算网格的欧拉示性数 χ = V - E + F。
pub fn euler_characteristic(mesh : @mesh_data.Mesh) -> Int {
  let v = @mesh_data.Mesh::vertex_count(mesh)
  let e = @mesh_data.Mesh::edge_count(mesh)
  let f = @mesh_data.Mesh::face_count(mesh)
  v - e + f
}

///|
/// Create a unit tetrahedron mesh for testing. / 创建单位四面体网格用于测试。
pub fn unit_tetrahedron() -> @mesh_data.Mesh {
  @mesh_data.Mesh::tetrahedron(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
}

///|
/// Compute the genus of a closed orientable surface: g = (2 - χ) / 2. / 计算闭可定向曲面的亏格：g = (2 - χ) / 2。
pub fn surface_genus(mesh : @mesh_data.Mesh) -> Int {
  let chi = euler_characteristic(mesh)
  (2 - chi) / 2
}

///|
/// Check if the mesh is a valid sphere (χ = 2). / 检查网格是否为球面（χ = 2）。
pub fn is_sphere(mesh : @mesh_data.Mesh) -> Bool {
  euler_characteristic(mesh) == 2
}

///|
/// Check if the mesh is a valid torus (χ = 0). / 检查网格是否为环面（χ = 0）。
pub fn is_torus(mesh : @mesh_data.Mesh) -> Bool {
  euler_characteristic(mesh) == 0
}

///|
/// Compute the Euler characteristic from component counts. / 由分量计数计算欧拉示性数。
pub fn euler_from_counts(
  vertices : Int,
  edges : Int,
  faces : Int,
) -> Int {
  vertices - edges + faces
}

///|
/// Compute the Betti number b0 (number of connected components, approximation). / 计算 Betti 数 b0（连通分量数，近似）。
pub fn betti_0(mesh : @mesh_data.Mesh) -> Int {
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
    let queue : Array[Int] = [start]
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

fn get_face_neighbors(
  f : @mesh_data.MeshFace,
  v : Int,
) -> Array[Int] {
  let result : Array[Int] = []
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

///|
/// Check if the mesh is manifold (each edge shared by at most 2 faces). / 检查网格是否为流形（每条边最多被 2 个面共享）。
pub fn is_manifold(mesh : @mesh_data.Mesh) -> Bool {
  let edge_count_map : Array[(Int, Int, Int)] = []
  for fi in 0..<@mesh_data.Mesh::face_count(mesh) {
    let f = @mesh_data.Mesh::get_face(mesh, fi)
    check_edge_manifold(edge_count_map, f.v0, f.v1)
    check_edge_manifold(edge_count_map, f.v1, f.v2)
    check_edge_manifold(edge_count_map, f.v2, f.v0)
  }
  for e in edge_count_map {
    if e.2 > 2 {
      return false
    }
  }
  true
}

fn check_edge_manifold(
  map : Array[(Int, Int, Int)],
  a : Int,
  b : Int,
) -> Unit {
  let (lo, hi) = if a < b { (a, b) } else { (b, a) }
  for i in 0..<map.length() {
    if map[i].0 == lo && map[i].1 == hi {
      map[i] = (lo, hi, map[i].2 + 1)
      return
    }
  }
  map.push((lo, hi, 1))
}