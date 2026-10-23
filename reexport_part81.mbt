///|
pub fn collapsible_edges(m : Mesh, t : Double) -> Int {
  @mesh_simplify.collapsible_edges(m, t)
}

///|
pub fn simplification_ratio(o : Mesh, s : Mesh) -> Double {
  @mesh_simplify.simplification_ratio(o, s)
}

// ---------------------------------------------------------------------------
// mesh_smooth: mesh smoothing / 网格平滑
// ---------------------------------------------------------------------------

///|
pub fn laplacian_smooth(m : Mesh, l : Double) -> Mesh {
  @mesh_smooth.laplacian_smooth(m, l)
}

///|
pub fn laplacian_smooth_iter(m : Mesh, l : Double, i : Int) -> Mesh {
  @mesh_smooth.laplacian_smooth_iter(m, l, i)
}

///|
pub fn taubin_smooth(m : Mesh, l : Double, mu : Double) -> Mesh {
  @mesh_smooth.taubin_smooth(m, l, mu)
}

///|
pub fn smooth_displacement(o : Mesh, s : Mesh) -> Double {
  @mesh_smooth.smooth_displacement(o, s)
}

// ---------------------------------------------------------------------------
// mesh_normal: mesh normals / 网格法向量
// ---------------------------------------------------------------------------

///|
pub fn face_normal(m : Mesh, fi : Int) -> Point3D {
  @mesh_normal.face_normal(m, fi)
}