///|
pub fn jacobi_preconditioner(
  a : Array[Array[Double]],
  n : Int,
) -> (Array[Double]) -> Array[Double] {
  @conjugate_gradient.jacobi_preconditioner(a, n)
}

// ---------------------------------------------------------------------------
// simplex_method: Simplex method / 单纯形法
// ---------------------------------------------------------------------------

///|
pub type SimplexResult = @simplex_method.SimplexResult

///|
pub fn simplex_result_new(
  x : Array[Double],
  value : Double,
  success : Bool,
) -> SimplexResult {
  @simplex_method.SimplexResult::new(x, value, success)
}

///|
pub fn simplex(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> SimplexResult {
  @simplex_method.simplex(a, b, c, max_iter)
}

///|
pub fn simplex_max(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> SimplexResult {
  @simplex_method.simplex_max(a, b, c, max_iter)
}

// ---------------------------------------------------------------------------
// interior_point: Interior point method / 内点法
// ---------------------------------------------------------------------------

///|
pub type IPResult = @interior_point.IPResult

///|
pub fn ip_result_new(x : Array[Double], value : Double, success : Bool) -> IPResult {
  @interior_point.IPResult::new(x, value, success)
}