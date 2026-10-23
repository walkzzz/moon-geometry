///|
pub fn inversion_is_on_circle(inv : Inversion, p : Point2D) -> Bool {
  @inversion.Inversion::is_on_circle(inv, p)
}

///|
pub fn inversion_invert_line(inv : Inversion, a : Double, b : Double, c : Double) -> Circle? {
  @inversion.Inversion::invert_line(inv, a, b, c)
}

// ---------------------------------------------------------------------------
// mesh_data: 3D triangle mesh / 三维三角网格
// ---------------------------------------------------------------------------

///|
pub type MeshFace = @mesh_data.MeshFace

///|
pub type Mesh = @mesh_data.Mesh

///|
pub fn mesh_new() -> Mesh {
  @mesh_data.Mesh::new()
}

///|
pub fn mesh_add_vertex(m : Mesh, p : Point3D) -> Int {
  @mesh_data.Mesh::add_vertex(m, p)
}

///|
pub fn mesh_add_face(m : Mesh, v0 : Int, v1 : Int, v2 : Int) -> Unit {
  @mesh_data.Mesh::add_face(m, v0, v1, v2)
}