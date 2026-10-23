///|
pub fn normalize3d(v : Point3D) -> Point3D {
  @mesh_normal.normalize(v)
}

///|
pub fn vertex_normal(m : Mesh, vi : Int) -> Point3D {
  @mesh_normal.vertex_normal(m, vi)
}

///|
pub fn all_face_normals(m : Mesh) -> Array[Point3D] {
  @mesh_normal.all_face_normals(m)
}

///|
pub fn all_vertex_normals(m : Mesh) -> Array[Point3D] {
  @mesh_normal.all_vertex_normals(m)
}

///|
pub fn mesh_face_area(m : Mesh, fi : Int) -> Double {
  @mesh_normal.face_area(m, fi)
}

// ---------------------------------------------------------------------------
// mesh_subdiv: mesh subdivision / 网格细分
// ---------------------------------------------------------------------------

///|
pub fn loop_subdivide(m : Mesh) -> Mesh {
  @mesh_subdiv.loop_subdivide(m)
}

///|
pub fn edge_bisection(m : Mesh) -> Mesh {
  @mesh_subdiv.edge_bisection(m)
}