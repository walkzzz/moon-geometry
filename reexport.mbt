///|
/// Re-export of all public types and functions from sub-packages.
/// Users can import a single package `walkzzz/moon-geometry` to access all APIs.
///
/// 重导出所有子包的公开类型和函数。
/// 用户只需导入单个包 `walkzzz/moon-geometry` 即可访问全部 API。

///|
/// 2D point. / 二维点。
pub type Point2D = @core.Point2D

///|
/// 3D point. / 三维点。
pub type Point3D = @core.Point3D

///|
/// Line segment. / 线段。
pub type Segment = @core.Segment

///|
/// Infinite line (a*x + b*y + c = 0). / 无限直线。
pub type Line = @core.Line

///|
/// Polygon. / 多边形。
pub type Polygon = @core.Polygon

///|
/// Triangle. / 三角形。
pub type Triangle = @core.Triangle

///|
/// Circle. / 圆。
pub type Circle = @core.Circle

///|
/// Axis-aligned rectangle. / 轴对齐矩形。
pub type Rectangle = @core.Rectangle

///|
/// Orientation enum. / 方向枚举。
pub type Orientation = @core.Orientation

///|
/// Triangle index triple for triangulation. / 三角剖分索引三元组。
pub type TriangleIdx = @triangulation.TriangleIdx

///|
/// Default epsilon for geometry comparisons. / 几何比较的默认精度。
pub let default_eps : Double = @core.default_eps

// ---------------------------------------------------------------------------
// core: utility functions / 核心工具函数
// ---------------------------------------------------------------------------

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

///|
/// Signed area of a polygon. / 多边形有符号面积。
pub fn polygon_signed_area(poly : Polygon) -> Double {
  @polygon.polygon_signed_area(poly)
}

///|
/// Absolute area of a polygon. / 多边形绝对面积。
pub fn polygon_area(poly : Polygon) -> Double {
  @polygon.polygon_area(poly)
}

///|
/// Perimeter of a polygon. / 多边形周长。
pub fn polygon_perimeter(poly : Polygon) -> Double {
  @polygon.polygon_perimeter(poly)
}

///|
/// Centroid of a polygon. / 多边形质心。
pub fn polygon_centroid(poly : Polygon) -> Point2D {
  @polygon.polygon_centroid(poly)
}

///|
/// Orientation of a polygon (CW/CCW/Collinear). / 多边形方向。
pub fn polygon_orientation(poly : Polygon) -> Orientation {
  @polygon.polygon_orientation(poly)
}

///|
/// Whether a polygon is convex. / 多边形是否为凸。
pub fn is_convex(poly : Polygon) -> Bool {
  @polygon.is_convex(poly)
}

///|
/// Point-in-polygon test (ray casting). / 点是否在多边形内。
pub fn point_in_polygon(p : Point2D, poly : Polygon) -> Bool {
  @polygon.point_in_polygon(p, poly)
}

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

///|
/// Intersection of two polygons. / 两多边形交集。
pub fn polygon_intersection(subject : Polygon, clip : Polygon) -> Polygon? {
  @boolean.polygon_intersection(subject, clip)
}

///|
/// Union area of two polygons. / 两多边形并集面积。
pub fn polygon_union_area(p1 : Polygon, p2 : Polygon) -> Double {
  @boolean.polygon_union_area(p1, p2)
}

///|
/// Difference area of two polygons. / 两多边形差集面积。
pub fn polygon_difference_area(p1 : Polygon, p2 : Polygon) -> Double {
  @boolean.polygon_difference_area(p1, p2)
}

// ---------------------------------------------------------------------------
// triangulation: Delaunay / Voronoi / 三角剖分
// ---------------------------------------------------------------------------

///|
/// Delaunay triangulation. / Delaunay 三角剖分。
pub fn delaunay_triangulation(points : Array[Point2D]) -> Array[TriangleIdx] {
  @triangulation.delaunay_triangulation(points)
}

///|
/// Voronoi diagram from Delaunay. / 由 Delaunay 构造 Voronoi 图。
pub fn voronoi_diagram(
  points : Array[Point2D]
) -> (Array[Point2D], Array[(Int, Int)]) {
  @triangulation.voronoi_diagram(points)
}

// ---------------------------------------------------------------------------
// transform: affine transforms / 仿射变换
// ---------------------------------------------------------------------------

///|
/// Translate a point. / 平移点。
pub fn translate(p : Point2D, dx : Double, dy : Double) -> Point2D {
  @transform.translate(p, dx, dy)
}

///|
/// Translate an array of points. / 平移点数组。
pub fn translate_points(
  points : Array[Point2D],
  dx : Double,
  dy : Double
) -> Array[Point2D] {
  @transform.translate_points(points, dx, dy)
}

///|
/// Rotate a point around the origin. / 绕原点旋转点。
pub fn rotate(p : Point2D, angle : Double) -> Point2D {
  @transform.rotate(p, angle)
}

///|
/// Rotate a point around a center. / 绕中心点旋转。
pub fn rotate_around(p : Point2D, center : Point2D, angle : Double) -> Point2D {
  @transform.rotate_around(p, center, angle)
}

///|
/// Rotate an array of points around a center. / 绕中心点旋转点数组。
pub fn rotate_points(
  points : Array[Point2D],
  center : Point2D,
  angle : Double
) -> Array[Point2D] {
  @transform.rotate_points(points, center, angle)
}

///|
/// Scale a point. / 缩放点。
pub fn scale(p : Point2D, sx : Double, sy : Double) -> Point2D {
  @transform.scale(p, sx, sy)
}

///|
/// Scale a point relative to a center. / 相对中心点缩放。
pub fn scale_around(
  p : Point2D,
  center : Point2D,
  sx : Double,
  sy : Double
) -> Point2D {
  @transform.scale_around(p, center, sx, sy)
}

///|
/// Affine transform: (x,y) -> (a*x+b*y+c, d*x+e*y+f). / 仿射变换。
pub fn affine_transform(
  p : Point2D,
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double
) -> Point2D {
  @transform.affine_transform(p, a, b, c, d, e, f)
}

///|
/// Affine transform on an array of points. / 对点数组应用仿射变换。
pub fn affine_transform_points(
  points : Array[Point2D],
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double
) -> Array[Point2D] {
  @transform.affine_transform_points(points, a, b, c, d, e, f)
}

///|
/// Mirror across x-axis. / 关于 x 轴镜像。
pub fn mirror_x(p : Point2D) -> Point2D {
  @transform.mirror_x(p)
}

///|
/// Mirror across y-axis. / 关于 y 轴镜像。
pub fn mirror_y(p : Point2D) -> Point2D {
  @transform.mirror_y(p)
}

///|
/// Mirror through origin. / 关于原点镜像。
pub fn mirror_origin(p : Point2D) -> Point2D {
  @transform.mirror_origin(p)
}

///|
/// Mirror across a line. / 关于直线镜像。
pub fn mirror_line(p : Point2D, line : Line) -> Point2D {
  @transform.mirror_line(p, line)
}

///|
/// Shear transform. / 剪切变换。
pub fn shear(p : Point2D, kx : Double, ky : Double) -> Point2D {
  @transform.shear(p, kx, ky)
}

// ---------------------------------------------------------------------------
// distance: distance computations / 距离计算
// ---------------------------------------------------------------------------

///|
/// Distance from a point to a segment. / 点到线段距离。
pub fn point_to_segment_distance(p : Point2D, seg : Segment) -> Double {
  @distance.point_to_segment_distance(p, seg)
}

///|
/// Distance from a point to a polygon. / 点到多边形距离。
pub fn point_to_polygon_distance(p : Point2D, poly : Polygon) -> Double {
  @distance.point_to_polygon_distance(p, poly)
}

///|
/// Minimum distance between two segments. / 两线段最小距离。
pub fn segment_to_segment_distance(s1 : Segment, s2 : Segment) -> Double {
  @distance.segment_to_segment_distance(s1, s2)
}

///|
/// Minimum distance between two polygons. / 两多边形最小距离。
pub fn polygon_to_polygon_distance(p1 : Polygon, p2 : Polygon) -> Double {
  @distance.polygon_to_polygon_distance(p1, p2)
}

///|
/// Distance from a point to a line. / 点到直线距离。
pub fn point_to_line_distance(p : Point2D, line : Line) -> Double {
  @distance.point_to_line_distance(p, line)
}

// ---------------------------------------------------------------------------
// bounding: bounding volumes / 包围体
// ---------------------------------------------------------------------------

///|
/// Axis-aligned bounding box of points. / 点集轴对齐包围盒。
pub fn aabb(points : Array[Point2D]) -> Rectangle {
  @bounding.aabb(points)
}

///|
/// Axis-aligned bounding box of a polygon. / 多边形轴对齐包围盒。
pub fn aabb_polygon(poly : Polygon) -> Rectangle {
  @bounding.aabb_polygon(poly)
}

///|
/// Minimum-area bounding rectangle (rotating calipers). / 最小面积包围矩形。
pub fn min_area_bounding_rect(
  points : Array[Point2D]
) -> (Double, Double, Double, Double, Double) {
  @bounding.min_area_bounding_rect(points)
}

///|
/// Bounding circle (centroid + max distance). / 包围圆。
pub fn bounding_circle(points : Array[Point2D]) -> (Point2D, Double) {
  @bounding.bounding_circle(points)
}
// ---------------------------------------------------------------------------
// circle_ops: circle intersection / 圆相交
// ---------------------------------------------------------------------------

///|
/// Circle-segment intersection points (0/1/2). / 圆与线段交点。
pub fn circle_segment_intersect(
  circle : Circle,
  seg : Segment
) -> Array[Point2D] {
  @circle_ops.circle_segment_intersect(circle, seg)
}

///|
/// Circle-circle intersection points (0/1/2). / 两圆交点。
pub fn circle_circle_intersect(c1 : Circle, c2 : Circle) -> Array[Point2D] {
  @circle_ops.circle_circle_intersect(c1, c2)
}

///|
/// Circle-line intersection points (0/1/2). / 圆与直线交点。
pub fn circle_line_intersect(circle : Circle, line : Line) -> Array[Point2D] {
  @circle_ops.circle_line_intersect(circle, line)
}

///|
/// Circle-polygon boundary intersection points. / 圆与多边形边界交点。
pub fn circle_polygon_intersect(
  circle : Circle,
  poly : Polygon
) -> Array[Point2D] {
  @circle_ops.circle_polygon_intersect(circle, poly)
}
// ---------------------------------------------------------------------------
// triangulate: polygon triangulation / 多边形三角剖分
// ---------------------------------------------------------------------------

///|
/// Triangulate a simple polygon via ear clipping.
/// Returns vertex index triples. / 简单多边形三角剖分（ear clipping），返回顶点索引三元组。
pub fn triangulate_polygon(poly : Polygon) -> Array[(Int, Int, Int)] {
  @triangulate.triangulate_polygon(poly)
}
// ---------------------------------------------------------------------------
// minkowski: Minkowski operations / Minkowski 运算
// ---------------------------------------------------------------------------

///|
/// Minkowski sum of two convex polygons. / 两个凸多边形的 Minkowski 和。
pub fn minkowski_sum_convex(
  poly1 : Polygon,
  poly2 : Polygon
) -> Array[Point2D] {
  @minkowski.minkowski_sum_convex(poly1, poly2)
}

///|
/// Minkowski difference of two convex polygons. / 两个凸多边形的 Minkowski 差。
pub fn minkowski_difference_convex(
  poly1 : Polygon,
  poly2 : Polygon
) -> Array[Point2D] {
  @minkowski.minkowski_difference_convex(poly1, poly2)
}

///|
/// Minkowski sum of a circle and a convex polygon. / 圆与凸多边形的 Minkowski 和。
pub fn minkowski_sum_circle_polygon(
  circle : Circle,
  poly : Polygon
) -> (Array[Point2D], Double) {
  @minkowski.minkowski_sum_circle_polygon(circle, poly)
}

///|
/// Check if two convex polygons collide via Minkowski difference. / 用 Minkowski 差检查两凸多边形碰撞。
pub fn convex_polygons_collide(poly1 : Polygon, poly2 : Polygon) -> Bool {
  @minkowski.convex_polygons_collide(poly1, poly2)
}