///|
/// Check if polygon is convex. / 检查多边形是否为凸。
pub fn is_convex_polygon(poly : Array[Point2D]) -> Bool {
  @convex_decomp.is_convex_polygon(poly)
}


///|
/// Decompose polygon into convex pieces. / 分解为凸块。
pub fn convex_decomposition(poly : Array[Point2D]) -> Array[Array[Point2D]] {
  @convex_decomp.convex_decomposition(poly)
}


///|
/// Count convex pieces. / 凸块数量。
pub fn convex_decomp_count(poly : Array[Point2D]) -> Int {
  @convex_decomp.convex_decomp_count(poly)
}


///|
/// Lower bound on convex pieces. / 凸块下界。
pub fn convex_decomp_lower_bound(poly : Array[Point2D]) -> Int {
  @convex_decomp.convex_decomp_lower_bound(poly)
}


///|
/// Total area of convex pieces. / 凸块总面积。
pub fn convex_decomp_area(poly : Array[Point2D]) -> Double {
  @convex_decomp.convex_decomp_area(poly)
}

// ---------------------------------------------------------------------------
// polygon_symmetry: symmetry detection / 对称性检测
// ---------------------------------------------------------------------------


///|
/// Check reflection symmetry. / 检查反射对称。
pub fn has_reflection_symmetry(poly : Array[Point2D], axis_angle : Double) -> Bool {
  @polygon_symmetry.has_reflection_symmetry(poly, axis_angle)
}
