///|
pub fn midpoint_subdivide(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @surface_mesh.midpoint_subdivide(vertices, faces)
}

///|
pub fn surf_mesh_bounding_box(
  vertices : Array[(Double, Double, Double)],
) -> (Double, Double, Double, Double, Double, Double) {
  @surface_mesh.mesh_bounding_box(vertices)
}

///|
pub fn validate_mesh(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> Bool {
  @surface_mesh.validate_mesh(vertices, faces)
}

// ---------------------------------------------------------------------------
// surface_param: Parametric surfaces / 参数曲面
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// surface_revolve: Surface of revolution / 旋转曲面
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// surface_sweep: Sweep surfaces / 扫掠曲面
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// surface_loft: Lofted surfaces / 放样曲面
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// surface_trim: Trimmed surfaces / 裁剪曲面
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// bezier_surface: Bezier surfaces / 贝塞尔曲面
// ---------------------------------------------------------------------------

///|
pub fn bernstein(i : Int, n : Int, t : Double) -> Double {
  @bezier_surface.bernstein(i, n, t)
}

///|
pub fn bezier_curve(
  control_pts : Array[(Double, Double, Double)],
  t : Double,
) -> (Double, Double, Double) {
  @bezier_surface.bezier_curve(control_pts, t)
}

///|
pub fn bezier_surface(
  control_net : Array[Array[(Double, Double, Double)]],
  u : Double,
  v : Double,
) -> (Double, Double, Double) {
  @bezier_surface.bezier_surface(control_net, u, v)
}

///|
pub fn bezier_surface_decasteljau(
  control_net : Array[Array[(Double, Double, Double)]],
  u : Double,
  v : Double,
) -> (Double, Double, Double) {
  @bezier_surface.bezier_surface_decasteljau(control_net, u, v)
}