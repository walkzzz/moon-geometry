///|
pub fn qp_result_new(x : Array[Double], value : Double, success : Bool) -> QPResult {
  @quadratic_prog.QPResult::new(x, value, success)
}

///|
pub fn qp_solve_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int,
) -> Array[Double]? {
  @quadratic_prog.solve_linear(a, b, n)
}

///|
pub fn solve_unconstrained_qp(
  q : Array[Array[Double]],
  c : Array[Double],
  n : Int,
) -> Array[Double]? {
  @quadratic_prog.solve_unconstrained_qp(q, c, n)
}

///|
pub fn active_set_qp(
  q : Array[Array[Double]],
  c : Array[Double],
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int,
  max_iter : Int,
) -> QPResult {
  @quadratic_prog.active_set_qp(q, c, a, b, n, max_iter)
}

///|
pub fn qp_2d_box(
  q11 : Double,
  q12 : Double,
  q22 : Double,
  c1 : Double,
  c2 : Double,
  lo1 : Double,
  hi1 : Double,
  lo2 : Double,
  hi2 : Double,
) -> Point2D {
  @quadratic_prog.qp_2d_box(q11, q12, q22, c1, c2, lo1, hi1, lo2, hi2)
}

///|
pub fn qp_objective(
  q : Array[Array[Double]],
  c : Array[Double],
  x : Array[Double],
  n : Int,
) -> Double {
  @quadratic_prog.qp_objective(q, c, x, n)
}

// ---------------------------------------------------------------------------
// gradient_descent: Gradient descent / 梯度下降
// ---------------------------------------------------------------------------

///|
pub fn gradient_descent(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.gradient_descent(grad, x0, lr, max_iter)
}