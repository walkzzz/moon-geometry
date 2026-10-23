///|
pub fn mat4_inverse(m : Array[Array[Double]]) -> Array[Array[Double]]? {
  @matrix3d.mat4_inverse(m)
}

///|
pub fn look_at(
  eye : (Double, Double, Double),
  target : (Double, Double, Double),
  up : (Double, Double, Double),
) -> Array[Array[Double]] {
  @matrix3d.look_at(eye, target, up)
}

///|
pub fn perspective(
  fovy : Double,
  aspect : Double,
  near : Double,
  far : Double,
) -> Array[Array[Double]] {
  @matrix3d.perspective(fovy, aspect, near, far)
}

///|
pub fn ortho(
  left : Double,
  right : Double,
  bottom : Double,
  top : Double,
  near : Double,
  far : Double,
) -> Array[Array[Double]] {
  @matrix3d.ortho(left, right, bottom, top, near, far)
}

// ---------------------------------------------------------------------------
// nurbs: NURBS curves and surfaces / NURBS 曲线与曲面
// ---------------------------------------------------------------------------

///|
pub fn nurbs_basis(
  i : Int,
  p : Int,
  u : Double,
  knots : Array[Double],
) -> Double {
  @nurbs.bspline_basis(i, p, u, knots)
}

///|
pub fn bspline_curve_point(
  control_pts : Array[(Double, Double, Double)],
  degree : Int,
  u : Double,
  knots : Array[Double],
) -> (Double, Double, Double) {
  @nurbs.bspline_curve_point(control_pts, degree, u, knots)
}

///|
pub fn nurbs_curve_point(
  control_pts : Array[(Double, Double, Double)],
  weights : Array[Double],
  degree : Int,
  u : Double,
  knots : Array[Double],
) -> (Double, Double, Double) {
  @nurbs.nurbs_curve_point(control_pts, weights, degree, u, knots)
}