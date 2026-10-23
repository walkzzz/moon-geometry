///|
/// Check if polygon is y-monotone. / 检查多边形是否 y-单调。
pub fn is_y_monotone(poly : Array[Point2D]) -> Bool {
  @monotone.is_y_monotone(poly)
}


///|
/// Check if polygon is x-monotone. / 检查多边形是否 x-单调。
pub fn is_x_monotone(poly : Array[Point2D]) -> Bool {
  @monotone.is_x_monotone(poly)
}


///|
/// Triangulate y-monotone polygon. / 三角剖分 y-单调多边形。
pub fn triangulate_monotone(poly : Array[Point2D]) -> Array[(Int, Int, Int)] {
  @monotone.triangulate_monotone(poly)
}


///|
/// Count monotone triangles. / 单调三角剖分三角形数。
pub fn monotone_triangulate_count(poly : Array[Point2D]) -> Int {
  @monotone.monotone_triangulate_count(poly)
}
// ---------------------------------------------------------------------------
// catmull_rom: Catmull-Rom spline / Catmull-Rom 样条
// ---------------------------------------------------------------------------


///|
/// Evaluate Catmull-Rom spline at t. / 计算 Catmull-Rom 样条在 t 处的值。
pub fn catmull_rom_eval(
  p0 : Point2D, p1 : Point2D, p2 : Point2D, p3 : Point2D, t : Double,
) -> Point2D {
  @catmull_rom.catmull_rom_eval(p0, p1, p2, p3, t)
}
