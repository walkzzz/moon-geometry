///|
/// Intersection of half-planes. / 半平面交。
pub fn half_plane_intersect(planes : Array[HalfPlane]) -> Array[Point2D] {
  @half_plane.half_plane_intersect(planes)
}

// ---------------------------------------------------------------------------
// convex_clip: convex polygon clipping / 凸多边形裁剪
// ---------------------------------------------------------------------------


///|
/// Clip convex polygon by a line. / 用直线裁剪凸多边形。
pub fn clip_convex_by_line(poly : Polygon, line : Line) -> Array[Point2D] {
  @convex_clip.clip_convex_by_line(poly, line)
}


///|
/// Clip convex polygon by half-plane. / 用半平面裁剪凸多边形。
pub fn clip_convex_by_half_plane(
  poly : Polygon,
  a : Double,
  b : Double,
  c : Double,
) -> Array[Point2D] {
  @convex_clip.clip_convex_by_half_plane(poly, a, b, c)
}


///|
/// Area of convex polygon from vertex array. / 凸多边形面积。
pub fn convex_area(vertices : Array[Point2D]) -> Double {
  @convex_clip.convex_area(vertices)
}

// ---------------------------------------------------------------------------
// convex_sum: point set operations / 点集运算
// ---------------------------------------------------------------------------


///|
/// All pairwise sums of two point sets. / 两个点集的成对和。
pub fn point_set_sum(p1 : Array[Point2D], p2 : Array[Point2D]) -> Array[Point2D] {
  @convex_sum.point_set_sum(p1, p2)
}


///|
/// All pairwise differences. / 两个点集的成对差。
pub fn point_set_difference(p1 : Array[Point2D], p2 : Array[Point2D]) -> Array[Point2D] {
  @convex_sum.point_set_difference(p1, p2)
}


///|
/// Centroid of a point set. / 点集质心。
pub fn point_set_centroid(points : Array[Point2D]) -> Point2D? {
  @convex_sum.point_set_centroid(points)
}

// ---------------------------------------------------------------------------
// polar_dual: polar duality / 极对偶
// ---------------------------------------------------------------------------
