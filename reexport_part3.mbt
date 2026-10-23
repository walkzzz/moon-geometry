///|
/// Check if two doubles are approximately equal. / 检查两浮点数是否近似相等。
pub fn approx_eq(a : Double, b : Double, eps : Double) -> Bool {
  @core.approx_eq(a, b, eps)
}


///|
/// Cross product of vectors OA and OB. / 向量 OA 和 OB 的叉积。
pub fn turn(o : Point2D, a : Point2D, b : Point2D) -> Double {
  @core.turn(o, a, b)
}


///|
/// Minimum distance from a point to a set of points. / 点到点集的最小距离。
pub fn min_dist_to_set(p : Point2D, set : Array[Point2D]) -> Double {
  @core.min_dist_to_set(p, set)
}

// ---------------------------------------------------------------------------
// hull: convex hull / 凸包
// ---------------------------------------------------------------------------


///|
/// Orientation of three points. / 三点方向判定。
pub fn ccw(a : Point2D, b : Point2D, c : Point2D) -> Orientation {
  @hull.ccw(a, b, c)
}


///|
/// Convex hull via Andrew's monotone chain. / Andrew 单调链凸包。
pub fn convex_hull_andrew(points : Array[Point2D]) -> Array[Point2D] {
  @hull.convex_hull_andrew(points)
}


///|
/// Convex hull via Graham scan. / Graham 扫描凸包。
pub fn convex_hull_graham(points : Array[Point2D]) -> Array[Point2D] {
  @hull.convex_hull_graham(points)
}

// ---------------------------------------------------------------------------
// polygon: polygon operations / 多边形操作
// ---------------------------------------------------------------------------
