///|
pub fn nurbs_surface_point(
  control_net : Array[Array[(Double, Double, Double)]],
  weights : Array[Array[Double]],
  degree_u : Int,
  degree_v : Int,
  u : Double,
  v : Double,
  knots_u : Array[Double],
  knots_v : Array[Double],
) -> (Double, Double, Double) {
  @nurbs.nurbs_surface_point(control_net, weights, degree_u, degree_v, u, v, knots_u, knots_v)
}

///|
pub fn find_span(
  n : Int,
  p : Int,
  u : Double,
  knots : Array[Double],
) -> Int {
  @nurbs.find_span(n, p, u, knots)
}

///|
pub fn nurbs_uniform_knots(num_ctrl : Int, degree : Int) -> Array[Double] {
  @nurbs.uniform_knots(num_ctrl, degree)
}

// ---------------------------------------------------------------------------
// surface_mesh: Surface mesh operations / 曲面网格操作
// ---------------------------------------------------------------------------

///|
pub fn surf_face_normal(
  vertices : Array[(Double, Double, Double)],
  face : (Int, Int, Int),
) -> (Double, Double, Double) {
  @surface_mesh.face_normal(vertices, face)
}

///|
pub fn surf_vertex_normal(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
  vidx : Int,
) -> (Double, Double, Double) {
  @surface_mesh.vertex_normal(vertices, faces, vidx)
}

///|
pub fn triangle_area(
  vertices : Array[(Double, Double, Double)],
  face : (Int, Int, Int),
) -> Double {
  @surface_mesh.triangle_area(vertices, face)
}

///|
pub fn mesh_area(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> Double {
  @surface_mesh.mesh_area(vertices, faces)
}