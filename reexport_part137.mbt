///|
pub fn newton_line_search(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_iter : Int,
) -> Array[Double] {
  @newton_method.newton_line_search(f, grad, hess, x0, max_iter)
}

///|
pub fn newton_trust_region(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_delta : Double,
  max_iter : Int,
) -> Array[Double] {
  @newton_method.newton_trust_region(f, grad, hess, x0, max_delta, max_iter)
}

///|
pub fn newton_2d(
  grad : (Double, Double) -> (Double, Double),
  hess : (Double, Double) -> ((Double, Double), (Double, Double)),
  x0 : Double,
  y0 : Double,
  max_iter : Int,
) -> Point2D {
  @newton_method.newton_2d(grad, hess, x0, y0, max_iter)
}

// ---------------------------------------------------------------------------
// levenberg_marquardt: Levenberg-Marquardt / 非线性最小二乘
// ---------------------------------------------------------------------------

///|
pub type LMResult = @levenberg_marquardt.LMResult

///|
pub fn lm_result_new(
  x : Array[Double],
  residual : Double,
  iterations : Int,
  success : Bool,
) -> LMResult {
  @levenberg_marquardt.LMResult::new(x, residual, iterations, success)
}

///|
pub fn levenberg_marquardt(
  residual : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> LMResult {
  @levenberg_marquardt.levenberg_marquardt(residual, x0, max_iter)
}

///|
pub fn levenberg_marquardt_jac(
  residual : (Array[Double]) -> Array[Double],
  jacobian : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_iter : Int,
) -> LMResult {
  @levenberg_marquardt.levenberg_marquardt_jac(residual, jacobian, x0, max_iter)
}