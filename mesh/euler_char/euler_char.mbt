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
