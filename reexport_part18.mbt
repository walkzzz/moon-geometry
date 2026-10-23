///|
/// Check if two convex polygons intersect (SAT). / 检测两凸多边形是否相交（分离轴定理）。
pub fn convex_polygons_intersect(poly1 : Polygon, poly2 : Polygon) -> Bool {
  @convex_polygon.convex_polygons_intersect(poly1, poly2)
}


///|
/// Distance from point to convex polygon. / 点到凸多边形距离。
pub fn point_to_convex_polygon_distance(poly : Polygon, p : Point2D) -> Double {
  @convex_polygon.point_to_convex_polygon_distance(poly, p)
}
// ---------------------------------------------------------------------------
// vector: vector operations / 向量运算
// ---------------------------------------------------------------------------


///|
/// Normalize a 2D vector to unit length. / 2D向量归一化。
pub fn vec_normalize(v : Point2D) -> Point2D {
  @vector.normalize(v)
}


///|
/// Reflect vector v across normal n. / 向量 v 关于法线 n 反射。
pub fn vec_reflect(v : Point2D, n : Point2D) -> Point2D {
  @vector.reflect(v, n)
}


///|
/// Project vector v onto vector u. / 向量 v 投影到向量 u。
pub fn vec_project(v : Point2D, u : Point2D) -> Point2D {
  @vector.project(v, u)
}


///|
/// Linear interpolation between a and b. / 线性插值。
pub fn vec_lerp(a : Point2D, b : Point2D, t : Double) -> Point2D {
  @vector.lerp(a, b, t)
}
