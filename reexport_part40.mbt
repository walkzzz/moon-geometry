///|
/// Check if constraints are feasible. / 检查约束是否可行。
pub fn is_feasible(constraints : Array[(Double, Double, Double)]) -> Bool {
  @linear_prog.is_feasible(constraints)
}

// ---------------------------------------------------------------------------
// convex_hull3d: 3D convex hull / 三维凸包
// ---------------------------------------------------------------------------


///|
/// 3D hull face type. / 三维凸包面类型。
pub type HullFace = @convex_hull3d.HullFace


///|
/// Compute 3D convex hull. / 三维凸包。
pub fn convex_hull_3d(points : Array[Point3D]) -> Array[HullFace] {
  @convex_hull3d.convex_hull_3d(points)
}


///|
/// Volume of 3D convex hull. / 三维凸包体积。
pub fn hull_volume(points : Array[Point3D], faces : Array[HullFace]) -> Double {
  @convex_hull3d.hull_volume(points, faces)
}

// ---------------------------------------------------------------------------
// support: support functions / 支持函数
// ---------------------------------------------------------------------------


///|
/// Support point index in a direction. / 支持点索引。
pub fn support_point_set(points : Array[Point2D], dir : Point2D) -> Int? {
  @support.support_point_set(points, dir)
}


///|
/// Support point of a circle. / 圆的支持点。
pub fn support_circle(center : Point2D, radius : Double, dir : Point2D) -> Point2D {
  @support.support_circle(center, radius, dir)
}
