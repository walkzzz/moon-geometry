///|
/// Evaluate B-spline at t. / 计算 B样条在 t 处的值。
pub fn bspline_eval(
  cps : Array[Point2D], degree : Int, knots : Array[Double], t : Double,
) -> Point2D {
  @bspline.bspline_eval(cps, degree, knots, t)
}


///|
/// Uniform knot vector. / 均匀节点向量。
pub fn uniform_knots(n : Int, degree : Int) -> Array[Double] {
  @bspline.uniform_knots(n, degree)
}


///|
/// Generate B-spline points. / 生成 B样条点。
pub fn bspline_points(cps : Array[Point2D], degree : Int, num_samples : Int) -> Array[Point2D] {
  @bspline.bspline_points(cps, degree, num_samples)
}

// ---------------------------------------------------------------------------
// lagrange: Lagrange interpolation / Lagrange 插值
// ---------------------------------------------------------------------------


///|
/// Evaluate Lagrange interpolation at x. / 在 x 处计算 Lagrange 插值。
pub fn lagrange_eval(xs : Array[Double], ys : Array[Double], x : Double) -> Double {
  @lagrange.lagrange_eval(xs, ys, x)
}


///|
/// Lagrange basis polynomial. / Lagrange 基多项式。
pub fn lagrange_basis(xs : Array[Double], i : Int, x : Double) -> Double {
  @lagrange.lagrange_basis(xs, i, x)
}


///|
/// Lagrange interpolate 2D points. / Lagrange 插值2D点。
pub fn lagrange_interpolate(pts : Array[Point2D], x : Double) -> Double {
  @lagrange.lagrange_interpolate(pts, x)
}


///|
/// Check distinct nodes. / 检查节点互异。
pub fn lagrange_nodes_distinct(xs : Array[Double]) -> Bool {
  @lagrange.lagrange_nodes_distinct(xs)
}

// ---------------------------------------------------------------------------
// spline: spline utilities / 样条工具
// ---------------------------------------------------------------------------
