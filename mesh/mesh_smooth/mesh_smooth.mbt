///|
/// Laplacian smoothing of a mesh (one iteration). / 网格的拉普拉斯平滑（一次迭代）。
pub fn laplacian_smooth(
  mesh : @mesh_data.Mesh,
  lambda : Double,
) -> @mesh_data.Mesh {
  let n = @mesh_data.Mesh::vertex_count(mesh)
  let result = @mesh_data.Mesh::new()
  let neighbor_sums : Array[@core.Point3D] = Array::make(
    n,
    @core.Point3D::new(0.0, 0.0, 0.0),
  )
  let neighbor_counts : Array[Int32] = Array::make(n, 0)
  for i in 0..<@mesh_data.Mesh::face_count(mesh) {
    let f = @mesh_data.Mesh::get_face(mesh, i)
    accumulate_neighbor(neighbor_sums, neighbor_counts, mesh, f.v0, f.v1)
    accumulate_neighbor(neighbor_sums, neighbor_counts, mesh, f.v1, f.v2)
    accumulate_neighbor(neighbor_sums, neighbor_counts, mesh, f.v2, f.v0)
    accumulate_neighbor(neighbor_sums, neighbor_counts, mesh, f.v1, f.v0)
    accumulate_neighbor(neighbor_sums, neighbor_counts, mesh, f.v2, f.v1)
    accumulate_neighbor(neighbor_sums, neighbor_counts, mesh, f.v0, f.v2)
  }
  for i in 0..<n {
    let v = @mesh_data.Mesh::get_vertex(mesh, i)
    if neighbor_counts[i] > 0 {
      let avg = @core.Point3D::new(
        neighbor_sums[i].x / neighbor_counts[i].to_double(),
        neighbor_sums[i].y / neighbor_counts[i].to_double(),
        neighbor_sums[i].z / neighbor_counts[i].to_double(),
      )
      let smoothed = @core.Point3D::new(
        v.x + lambda * (avg.x - v.x),
        v.y + lambda * (avg.y - v.y),
        v.z + lambda * (avg.z - v.z),
      )
      ignore(result.add_vertex(smoothed))
    } else {
      ignore(result.add_vertex(v))
    }
  }
  for i in 0..<@mesh_data.Mesh::face_count(mesh) {
    let f = @mesh_data.Mesh::get_face(mesh, i)
    result.add_face(f.v0, f.v1, f.v2)
  }
  result
}

///|
fn accumulate_neighbor(
  sums : Array[@core.Point3D],
  counts : Array[Int32],
  mesh : @mesh_data.Mesh,
  v : Int32,
  u : Int32,
) -> Unit {
  let pu = @mesh_data.Mesh::get_vertex(mesh, u)
  sums[v] = @core.Point3D::new(
    sums[v].x + pu.x,
    sums[v].y + pu.y,
    sums[v].z + pu.z,
  )
  counts[v] += 1
}

///|
/// Apply multiple iterations of Laplacian smoothing. / 多次拉普拉斯平滑迭代。
pub fn laplacian_smooth_iter(
  mesh : @mesh_data.Mesh,
  lambda : Double,
  iterations : Int32,
) -> @mesh_data.Mesh {
  let mut result = mesh
  for _ in 0..<iterations {
    result = laplacian_smooth(result, lambda)
  }
  result
}

///|
/// Taubin smoothing (lambda-mu filter, one iteration). / Taubin 平滑（lambda-mu 滤波，一次迭代）。
pub fn taubin_smooth(
  mesh : @mesh_data.Mesh,
  lambda : Double,
  mu : Double,
) -> @mesh_data.Mesh {
  let m1 = laplacian_smooth(mesh, lambda)
  laplacian_smooth(m1, mu)
}

///|
/// Compute the total displacement after smoothing. / 计算平滑后的总位移。
pub fn smooth_displacement(
  original : @mesh_data.Mesh,
  smoothed : @mesh_data.Mesh,
) -> Double {
  let mut total = 0.0
  let n = @mesh_data.Mesh::vertex_count(original)
  for i in 0..<n {
    let v0 = @mesh_data.Mesh::get_vertex(original, i)
    let v1 = @mesh_data.Mesh::get_vertex(smoothed, i)
    total += v0.dist(v1)
  }
  total
}
