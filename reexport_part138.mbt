///|
pub fn lm_line_fit(xs : Array[Double], ys : Array[Double]) -> (Double, Double) {
  @levenberg_marquardt.lm_line_fit(xs, ys)
}

///|
pub fn lm_rms_error(residual_sq : Double, n : Int) -> Double {
  @levenberg_marquardt.lm_rms_error(residual_sq, n)
}

///|
pub fn lm_log_residual(residual_sq : Double) -> Double {
  @levenberg_marquardt.lm_log_residual(residual_sq)
}

// ---------------------------------------------------------------------------
// conjugate_gradient: Conjugate gradient / 共轭梯度
// ---------------------------------------------------------------------------

///|
pub fn cg_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> Array[Double] {
  @conjugate_gradient.cg_linear(a, b, x0, max_iter)
}

///|
pub fn pcg_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  m_inv : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> Array[Double] {
  @conjugate_gradient.pcg_linear(a, b, m_inv, x0, max_iter)
}

///|
pub fn nonlinear_cg(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> Array[Double] {
  @conjugate_gradient.nonlinear_cg(f, grad, x0, max_iter)
}

///|
pub fn nonlinear_cg_2d(
  f : (Double, Double) -> Double,
  grad : (Double, Double) -> (Double, Double),
  x0 : Double,
  y0 : Double,
  max_iter : Int,
) -> Point2D {
  @conjugate_gradient.nonlinear_cg_2d(f, grad, x0, y0, max_iter)
}