///|
/// Generate Catmull-Rom spline points. / 生成 Catmull-Rom 样条点。
pub fn catmull_rom_points(cps : Array[Point2D], num_segments : Int) -> Array[Point2D] {
  @catmull_rom.catmull_rom_points(cps, num_segments)
}


///|
/// Catmull-Rom derivative at t. / Catmull-Rom 样条导数。
pub fn catmull_rom_derivative(
  p0 : Point2D, p1 : Point2D, p2 : Point2D, p3 : Point2D, t : Double,
) -> Point2D {
  @catmull_rom.catmull_rom_derivative(p0, p1, p2, p3, t)
}

// ---------------------------------------------------------------------------
// hermite: Hermite spline / Hermite 样条
// ---------------------------------------------------------------------------


///|
/// Evaluate Hermite spline at t. / 计算 Hermite 样条在 t 处的值。
pub fn hermite_eval(
  p0 : Point2D, p1 : Point2D, m0 : Point2D, m1 : Point2D, t : Double,
) -> Point2D {
  @hermite.hermite_eval(p0, p1, m0, m1, t)
}


///|
/// Generate Hermite spline points. / 生成 Hermite 样条点。
pub fn hermite_points(
  pts : Array[Point2D], tans : Array[Point2D], num_segments : Int,
) -> Array[Point2D] {
  @hermite.hermite_points(pts, tans, num_segments)
}


///|
/// Hermite spline derivative. / Hermite 样条导数。
pub fn hermite_derivative(
  p0 : Point2D, p1 : Point2D, m0 : Point2D, m1 : Point2D, t : Double,
) -> Point2D {
  @hermite.hermite_derivative(p0, p1, m0, m1, t)
}


///|
/// Cardinal spline tangents. / Cardinal 样条切线。
pub fn cardinal_tangents(pts : Array[Point2D], tension : Double) -> Array[Point2D] {
  @hermite.cardinal_tangents(pts, tension)
}

// ---------------------------------------------------------------------------
// bspline: B-spline / B样条
// ---------------------------------------------------------------------------


///|
/// B-spline basis function. / B样条基函数。
pub fn bspline_basis(degree : Int, knots : Array[Double], i : Int, t : Double) -> Double {
  @bspline.bspline_basis(degree, knots, i, t)
}
