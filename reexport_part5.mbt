///|
/// Simplify polygon (Douglas-Peucker). / 多边形简化（Douglas-Peucker）。
pub fn simplify_polygon(poly : Polygon, epsilon : Double) -> Array[Point2D] {
  @polygon.simplify_polygon(poly, epsilon)
}

// ---------------------------------------------------------------------------
// intersect: intersection / 相交
// ---------------------------------------------------------------------------


///|
/// Whether two segments intersect. / 两线段是否相交。
pub fn segments_intersect(s1 : Segment, s2 : Segment) -> Bool {
  @intersect.segments_intersect(s1, s2)
}


///|
/// Intersection point of two segments (None if no intersection). / 两线段交点。
pub fn segment_intersection(s1 : Segment, s2 : Segment) -> Point2D? {
  @intersect.segment_intersection(s1, s2)
}


///|
/// Intersection of a line and a segment. / 直线与线段交点。
pub fn line_segment_intersection(line : Line, seg : Segment) -> Point2D? {
  @intersect.line_segment_intersection(line, seg)
}

// ---------------------------------------------------------------------------
// nearest: closest pair / 最近点对
// ---------------------------------------------------------------------------


///|
/// Closest pair of points (divide & conquer, O(n log n)). / 最近点对。
pub fn closest_pair(points : Array[Point2D]) -> (Point2D, Point2D, Double)? {
  @nearest.closest_pair(points)
}

// ---------------------------------------------------------------------------
// boolean: polygon boolean operations / 多边形布尔运算
// ---------------------------------------------------------------------------


///|
/// Clip polygon against a rectangle (Sutherland-Hodgman). / 矩形裁剪多边形。
pub fn clip_polygon(poly : Polygon, clip_rect : Rectangle) -> Array[Point2D] {
  @boolean.clip_polygon(poly, clip_rect)
}
