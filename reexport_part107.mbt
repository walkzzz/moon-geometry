///|
pub fn poly_mul(a : Array[Double], b : Array[Double]) -> Array[Double] {
  @polynomial.poly_mul(a, b)
}

///|
pub fn poly_roots(coeffs : Array[Double]) -> Array[Double] {
  @polynomial.poly_roots(coeffs)
}

// ---------------------------------------------------------------------------
// root_find: Root finding / 求根
// ---------------------------------------------------------------------------

///|
pub fn bisection(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  max_iter : Int,
) -> Double {
  @root_find.bisection(f, lo, hi, max_iter)
}

///|
pub fn newton(
  f : (Double) -> Double,
  fp : (Double) -> Double,
  x0 : Double,
  max_iter : Int,
) -> Double {
  @root_find.newton(f, fp, x0, max_iter)
}

///|
pub fn secant(
  f : (Double) -> Double,
  x0 : Double,
  x1 : Double,
  max_iter : Int,
) -> Double {
  @root_find.secant(f, x0, x1, max_iter)
}

///|
pub fn find_all_roots(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n_samples : Int,
) -> Array[Double] {
  @root_find.find_all_roots(f, lo, hi, n_samples)
}

// ---------------------------------------------------------------------------
// integration: Numerical integration / 数值积分
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// differentiation: Numerical differentiation / 数值微分
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// interpolation: Interpolation / 插值
// ---------------------------------------------------------------------------

///|
pub fn lagrange_interp(
  xs : Array[Double],
  ys : Array[Double],
  x : Double,
) -> Double {
  @interpolation.lagrange_interp(xs, ys, x)
}