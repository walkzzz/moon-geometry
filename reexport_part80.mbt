///|
pub fn mesh_vertex_count(m : Mesh) -> Int {
  @mesh_data.Mesh::vertex_count(m)
}

///|
pub fn mesh_face_count(m : Mesh) -> Int {
  @mesh_data.Mesh::face_count(m)
}

///|
pub fn mesh_edge_count(m : Mesh) -> Int {
  @mesh_data.Mesh::edge_count(m)
}

///|
pub fn mesh_bounding_box(m : Mesh) -> (Point3D, Point3D) {
  @mesh_data.Mesh::bounding_box(m)
}

///|
pub fn mesh_tetrahedron(a : Point3D, b : Point3D, c : Point3D, d : Point3D) -> Mesh {
  @mesh_data.Mesh::tetrahedron(a, b, c, d)
}

// ---------------------------------------------------------------------------
// mesh_simplify: mesh simplification / 网格简化
// ---------------------------------------------------------------------------

///|
pub fn simplify_by_edge_length(m : Mesh, t : Double) -> Mesh {
  @mesh_simplify.simplify_by_edge_length(m, t)
}

///|
pub fn edge_collapse_cost(m : Mesh, v0 : Int, v1 : Int) -> Double {
  @mesh_simplify.edge_collapse_cost(m, v0, v1)
}