///|
/// Check rotational symmetry. / 检查旋转对称。
pub fn has_rotation_symmetry(poly : Array[Point2D], order : Int) -> Bool {
  @polygon_symmetry.has_rotation_symmetry(poly, order)
}


///|
/// Find rotational symmetry order. / 求旋转对称阶。
pub fn polygon_symmetry_order(poly : Array[Point2D]) -> Int {
  @polygon_symmetry.polygon_symmetry_order(poly)
}


///|
/// Check any symmetry. / 检查任何对称性。
pub fn has_any_symmetry(poly : Array[Point2D]) -> Bool {
  @polygon_symmetry.has_any_symmetry(poly)
}

// ---------------------------------------------------------------------------
// polygon_cover: polygon covering / 多边形覆盖
// ---------------------------------------------------------------------------


///|
/// Cover by rectangles. / 矩形覆盖。
pub fn cover_by_rectangles(poly : Array[Point2D]) -> Array[Rectangle] {
  @polygon_cover.cover_by_rectangles(poly)
}


///|
/// Cover by triangles. / 三角形覆盖。
pub fn cover_by_triangles(poly : Array[Point2D]) -> Array[Triangle] {
  @polygon_cover.cover_by_triangles(poly)
}


///|
/// Rectangle cover area. / 矩形覆盖面积。
pub fn cover_area_rectangles(poly : Array[Point2D]) -> Double {
  @polygon_cover.cover_area_rectangles(poly)
}


///|
/// Triangle cover area. / 三角形覆盖面积。
pub fn cover_area_triangles(poly : Array[Point2D]) -> Double {
  @polygon_cover.cover_area_triangles(poly)
}

// ---------------------------------------------------------------------------
// ear_clip: ear clipping triangulation / 耳裁剪三角剖分
// ---------------------------------------------------------------------------
