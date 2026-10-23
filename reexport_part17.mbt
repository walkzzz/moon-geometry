///|
/// Check if segments form a simple polygon. / 检测线段是否构成简单多边形。
pub fn is_simple_polygon_chain(segments : Array[Segment]) -> Bool {
  @sweep_line.is_simple_polygon_chain(segments)
}

// ---------------------------------------------------------------------------
// convex_polygon: convex polygon ops / 凸多边形操作
// ---------------------------------------------------------------------------


///|
/// Support function value. / 支持函数值。
pub fn support_function(poly : Polygon, dir : Point2D) -> Double {
  @convex_polygon.support_function(poly, dir)
}


///|
/// Extreme point index in a direction. / 沿方向的极点索引。
pub fn extreme_point(poly : Polygon, dir : Point2D) -> Int {
  @convex_polygon.extreme_point(poly, dir)
}


///|
/// O(log n) point-in-convex-polygon test. / O(log n) 凸多边形点包含检测。
pub fn point_in_convex_polygon(poly : Polygon, p : Point2D) -> Bool {
  @convex_polygon.point_in_convex_polygon(poly, p)
}


///|
/// Tangent indices from external point. / 外部点到凸多边形的切线索引。
pub fn tangent_from_point(poly : Polygon, p : Point2D) -> (Int, Int) {
  @convex_polygon.tangent_from_point(poly, p)
}
