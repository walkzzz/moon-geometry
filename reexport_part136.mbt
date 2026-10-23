///|
pub fn momentum_gd(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  momentum : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.momentum_gd(grad, x0, lr, momentum, max_iter)
}

///|
pub fn nesterov_gd(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  momentum : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.nesterov_gd(grad, x0, lr, momentum, max_iter)
}

///|
pub fn adam(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  beta1 : Double,
  beta2 : Double,
  eps : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.adam(grad, x0, lr, beta1, beta2, eps, max_iter)
}

///|
pub fn gd_2d(
  grad : (Double, Double) -> (Double, Double),
  x0 : Double,
  y0 : Double,
  lr : Double,
  max_iter : Int,
) -> Point2D {
  @gradient_descent.gd_2d(grad, x0, y0, lr, max_iter)
}

///|
pub fn rmsprop(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  decay : Double,
  eps : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.rmsprop(grad, x0, lr, decay, eps, max_iter)
}

// ---------------------------------------------------------------------------
// newton_method: Newton's method / 牛顿法
// ---------------------------------------------------------------------------

///|
pub fn newton_1d(
  f : (Double) -> Double,
  fp : (Double) -> Double,
  x0 : Double,
  tol : Double,
  max_iter : Int,
) -> Double {
  @newton_method.newton_1d(f, fp, x0, tol, max_iter)
}

///|
pub fn newton_multi(
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  tol : Double,
  max_iter : Int,
) -> Array[Double] {
  @newton_method.newton_multi(grad, hess, x0, tol, max_iter)
}