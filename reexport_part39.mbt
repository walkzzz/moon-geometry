///|
/// Polar dual of a point. / 点的极对偶。
pub fn polar_dual_point(p : Point2D) -> Point2D {
  @polar_dual.polar_dual_point(p)
}


///|
/// Polar dual of a convex polygon. / 凸多边形的极对偶。
pub fn polar_dual(poly : Polygon) -> Array[Point2D] {
  @polar_dual.polar_dual(poly)
}


///|
/// Check if origin is inside polygon. / 检查原点是否在多边形内。
pub fn origin_inside(poly : Polygon) -> Bool {
  @polar_dual.origin_inside(poly)
}

// ---------------------------------------------------------------------------
// linear_prog: 2D linear programming / 二维线性规划
// ---------------------------------------------------------------------------


///|
/// LP result type. / 线性规划结果类型。
pub type LPResult = @linear_prog.LPResult


///|
/// Solve 2D LP. / 求解二维线性规划。
pub fn linear_program_2d(
  constraints : Array[(Double, Double, Double)],
  cx : Double,
  cy : Double,
) -> LPResult? {
  @linear_prog.linear_program_2d(constraints, cx, cy)
}
