///|
/// Least-squares circle fit. / 最小二乘圆拟合。
pub fn fit_circle(points : Array[Point2D]) -> CircleFit? {
  @fitting.fit_circle(points)
}


///|
/// Centroid of a point set. / 点集质心。
pub fn centroid(points : Array[Point2D]) -> Point2D? {
  @fitting.centroid(points)
}

// ---------------------------------------------------------------------------
// sweep_line: segment intersection / 线段相交检测
// ---------------------------------------------------------------------------


///|
/// Check if any pair of segments intersects. / 检测是否有任何线段对相交。
pub fn has_any_intersection(segments : Array[Segment]) -> Bool {
  @sweep_line.has_any_intersection(segments)
}


///|
/// Find all intersecting pairs. / 找出所有相交线段对。
pub fn find_all_intersections(segments : Array[Segment]) -> Array[(Int, Int)] {
  @sweep_line.find_all_intersections(segments)
}


///|
/// Count intersecting pairs. / 计数相交线段对。
pub fn count_intersections(segments : Array[Segment]) -> Int {
  @sweep_line.count_intersections(segments)
}


///|
/// Find all intersection points. / 找出所有线段交点。
pub fn find_intersection_points(
  segments : Array[Segment],
) -> Array[(Int, Int, Point2D)] {
  @sweep_line.find_intersection_points(segments)
}
