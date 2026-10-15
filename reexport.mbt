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
  points : Array[Point2D],
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
  dy : Double,
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
  angle : Double,
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
  sy : Double,
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
  f : Double,
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
  f : Double,
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
  points : Array[Point2D],
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
  seg : Segment,
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
  poly : Polygon,
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
pub fn minkowski_sum_convex(poly1 : Polygon, poly2 : Polygon) -> Array[Point2D] {
  @minkowski.minkowski_sum_convex(poly1, poly2)
}

///|
/// Minkowski difference of two convex polygons. / 两个凸多边形的 Minkowski 差。
pub fn minkowski_difference_convex(
  poly1 : Polygon,
  poly2 : Polygon,
) -> Array[Point2D] {
  @minkowski.minkowski_difference_convex(poly1, poly2)
}

///|
/// Minkowski sum of a circle and a convex polygon. / 圆与凸多边形的 Minkowski 和。
pub fn minkowski_sum_circle_polygon(
  circle : Circle,
  poly : Polygon,
) -> (Array[Point2D], Double) {
  @minkowski.minkowski_sum_circle_polygon(circle, poly)
}

///|
/// Check if two convex polygons collide via Minkowski difference. / 用 Minkowski 差检查两凸多边形碰撞。
pub fn convex_polygons_collide(poly1 : Polygon, poly2 : Polygon) -> Bool {
  @minkowski.convex_polygons_collide(poly1, poly2)
}
// ---------------------------------------------------------------------------
// rotating_calipers: rotating calipers / 旋转卡壳
// ---------------------------------------------------------------------------

///|
/// Convex polygon diameter (farthest vertex pair). / 凸多边形直径（最远顶点对）。
pub fn convex_polygon_diameter(poly : Polygon) -> (Point2D, Point2D, Double) {
  @rotating_calipers.convex_polygon_diameter(poly)
}

///|
/// Convex polygon width (min parallel supporting line distance). / 凸多边形宽度。
pub fn convex_polygon_width(poly : Polygon) -> Double {
  @rotating_calipers.convex_polygon_width(poly)
}

///|
/// Farthest point pair from a point set. / 点集最远点对。
pub fn farthest_point_pair(
  points : Array[Point2D],
) -> (Point2D, Point2D, Double)? {
  @rotating_calipers.farthest_point_pair(points)
}

///|
/// Min perimeter bounding rectangle of convex polygon. / 凸多边形最小周长包围矩形。
pub fn min_perimeter_bounding_rect(
  poly : Polygon,
) -> (Double, Double, Double, Double, Double) {
  @rotating_calipers.min_perimeter_bounding_rect(poly)
}

// ---------------------------------------------------------------------------
// ellipse: ellipse geometry / 椭圆几何
// ---------------------------------------------------------------------------

///|
/// Ellipse type. / 椭圆类型。
pub type Ellipse = @ellipse.Ellipse

///|
/// Construct an ellipse. / 构造椭圆。
pub fn ellipse_new(
  center : Point2D,
  a : Double,
  b : Double,
  angle : Double,
) -> Ellipse {
  @ellipse.Ellipse::new(center, a, b, angle)
}

///|
/// Area of the ellipse. / 椭圆面积。
pub fn ellipse_area(e : Ellipse) -> Double {
  @ellipse.Ellipse::area(e)
}

///|
/// Perimeter of the ellipse (Ramanujan approximation). / 椭圆周长。
pub fn ellipse_perimeter(e : Ellipse) -> Double {
  @ellipse.Ellipse::perimeter(e)
}

///|
/// Eccentricity of the ellipse. / 椭圆离心率。
pub fn ellipse_eccentricity(e : Ellipse) -> Double {
  @ellipse.Ellipse::eccentricity(e)
}

///|
/// Check if a point is inside the ellipse. / 检查点是否在椭圆内。
pub fn ellipse_contains(e : Ellipse, p : Point2D) -> Bool {
  @ellipse.Ellipse::contains(e, p)
}

///|
/// Check if a point is on the ellipse boundary. / 检查点是否在椭圆边界上。
pub fn ellipse_on_boundary(e : Ellipse, p : Point2D, eps : Double) -> Bool {
  @ellipse.Ellipse::on_boundary(e, p, eps)
}

///|
/// Focal points of the ellipse. / 椭圆焦点。
pub fn ellipse_foci(e : Ellipse) -> (Point2D, Point2D) {
  @ellipse.Ellipse::foci(e)
}

// ---------------------------------------------------------------------------
// bezier: Bezier curves / 贝塞尔曲线
// ---------------------------------------------------------------------------

///|
/// Quadratic Bezier curve type. / 二次贝塞尔曲线类型。
pub type Bezier2 = @bezier.Bezier2

///|
/// Cubic Bezier curve type. / 三次贝塞尔曲线类型。
pub type Bezier3 = @bezier.Bezier3

///|
/// Construct a quadratic Bezier curve. / 构造二次贝塞尔曲线。
pub fn bezier2_new(p0 : Point2D, p1 : Point2D, p2 : Point2D) -> Bezier2 {
  @bezier.Bezier2::new(p0, p1, p2)
}

///|
/// Evaluate quadratic Bezier at t. / 计算二次贝塞尔曲线在 t 处的值。
pub fn bezier2_eval(b : Bezier2, t : Double) -> Point2D {
  @bezier.Bezier2::eval(b, t)
}

///|
/// Derivative of quadratic Bezier at t. / 二次贝塞尔曲线在 t 处的导数。
pub fn bezier2_derivative(b : Bezier2, t : Double) -> Point2D {
  @bezier.Bezier2::derivative(b, t)
}

///|
/// Arc length of quadratic Bezier. / 二次贝塞尔曲线弧长。
pub fn bezier2_length(b : Bezier2) -> Double {
  @bezier.Bezier2::length(b)
}

///|
/// Bounding box of quadratic Bezier. / 二次贝塞尔曲线包围盒。
pub fn bezier2_bbox(b : Bezier2) -> (Double, Double, Double, Double) {
  @bezier.Bezier2::bbox(b)
}

///|
/// Subdivide quadratic Bezier at t. / 细分二次贝塞尔曲线。
pub fn bezier2_subdivide(b : Bezier2, t : Double) -> (Bezier2, Bezier2) {
  @bezier.Bezier2::subdivide(b, t)
}

///|
/// Construct a cubic Bezier curve. / 构造三次贝塞尔曲线。
pub fn bezier3_new(
  p0 : Point2D,
  p1 : Point2D,
  p2 : Point2D,
  p3 : Point2D,
) -> Bezier3 {
  @bezier.Bezier3::new(p0, p1, p2, p3)
}

///|
/// Evaluate cubic Bezier at t. / 计算三次贝塞尔曲线在 t 处的值。
pub fn bezier3_eval(b : Bezier3, t : Double) -> Point2D {
  @bezier.Bezier3::eval(b, t)
}

///|
/// Derivative of cubic Bezier at t. / 三次贝塞尔曲线在 t 处的导数。
pub fn bezier3_derivative(b : Bezier3, t : Double) -> Point2D {
  @bezier.Bezier3::derivative(b, t)
}

///|
/// Arc length of cubic Bezier. / 三次贝塞尔曲线弧长。
pub fn bezier3_length(b : Bezier3) -> Double {
  @bezier.Bezier3::length(b)
}

///|
/// Bounding box of cubic Bezier. / 三次贝塞尔曲线包围盒。
pub fn bezier3_bbox(b : Bezier3) -> (Double, Double, Double, Double) {
  @bezier.Bezier3::bbox(b)
}

///|
/// Subdivide cubic Bezier at t. / 细分三次贝塞尔曲线。
pub fn bezier3_subdivide(b : Bezier3, t : Double) -> (Bezier3, Bezier3) {
  @bezier.Bezier3::subdivide(b, t)
}
// ---------------------------------------------------------------------------
// fitting: geometric fitting / 几何拟合
// ---------------------------------------------------------------------------

///|
/// Line fit result. / 直线拟合结果。
pub type LineFit = @fitting.LineFit

///|
/// Circle fit result. / 圆拟合结果。
pub type CircleFit = @fitting.CircleFit

///|
/// Least-squares line fit. / 最小二乘直线拟合。
pub fn fit_line(points : Array[Point2D]) -> LineFit? {
  @fitting.fit_line(points)
}

///|
/// Orthogonal distance regression line fit. / 正交距离回归直线拟合。
pub fn fit_line_orthogonal(
  points : Array[Point2D],
) -> (Double, Double, Double)? {
  @fitting.fit_line_orthogonal(points)
}

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

///|
/// Check if segments form a simple polygon. / 检测线段是否构成简单多边形。
pub fn is_simple_polygon_chain(segments : Array[Segment]) -> Bool {
  @sweep_line.is_simple_polygon_chain(segments)
}

// ---------------------------------------------------------------------------
// convex_polygon: convex polygon ops / 凸多边形操作
// ---------------------------------------------------------------------------

///|
/// Support function value. / 支持函数值。
pub fn support_function(poly : Polygon, dir : Point2D) -> Double {
  @convex_polygon.support_function(poly, dir)
}

///|
/// Extreme point index in a direction. / 沿方向的极点索引。
pub fn extreme_point(poly : Polygon, dir : Point2D) -> Int {
  @convex_polygon.extreme_point(poly, dir)
}

///|
/// O(log n) point-in-convex-polygon test. / O(log n) 凸多边形点包含检测。
pub fn point_in_convex_polygon(poly : Polygon, p : Point2D) -> Bool {
  @convex_polygon.point_in_convex_polygon(poly, p)
}

///|
/// Tangent indices from external point. / 外部点到凸多边形的切线索引。
pub fn tangent_from_point(poly : Polygon, p : Point2D) -> (Int, Int) {
  @convex_polygon.tangent_from_point(poly, p)
}

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

///|
/// Perpendicular vector (rotated 90° CCW). / 垂直向量（逆时针旋转90°）。
pub fn vec_perp(v : Point2D) -> Point2D {
  @vector.perp(v)
}

///|
/// Vector length. / 向量长度。
pub fn vec_length(v : Point2D) -> Double {
  @vector.length(v)
}

///|
/// Angle between two vectors in radians. / 两向量夹角（弧度）。
pub fn vec_angle_between(a : Point2D, b : Point2D) -> Double {
  @vector.angle_between(a, b)
}

///|
/// Reject component of v along u. / 拒绝分量。
pub fn vec_reject(v : Point2D, u : Point2D) -> Point2D {
  @vector.reject(v, u)
}

// ---------------------------------------------------------------------------
// matrix: 2x2 matrix / 2x2 矩阵
// ---------------------------------------------------------------------------

///|
/// 2x2 matrix type. / 2x2 矩阵类型。
pub type Mat2 = @matrix.Mat2

///|
/// Construct a 2x2 matrix. / 构造 2x2 矩阵。
pub fn mat2_new(a11 : Double, a12 : Double, a21 : Double, a22 : Double) -> Mat2 {
  @matrix.Mat2::new(a11, a12, a21, a22)
}

///|
/// Identity matrix. / 单位矩阵。
pub fn mat2_identity() -> Mat2 {
  @matrix.Mat2::identity()
}

///|
/// Determinant. / 行列式。
pub fn mat2_det(m : Mat2) -> Double {
  @matrix.Mat2::det(m)
}

///|
/// Matrix multiplication. / 矩阵乘法。
pub fn mat2_mul(m : Mat2, other : Mat2) -> Mat2 {
  @matrix.Mat2::mul(m, other)
}

///|
/// Apply matrix to a 2D point. / 矩阵作用于点。
pub fn mat2_transform(m : Mat2, p : Point2D) -> Point2D {
  @matrix.Mat2::transform(m, p)
}

///|
/// Inverse matrix. Returns None if singular. / 逆矩阵。奇异返回 None。
pub fn mat2_inverse(m : Mat2) -> Mat2? {
  @matrix.Mat2::inverse(m)
}

///|
/// Rotation matrix. / 旋转矩阵。
pub fn mat2_rotation(angle : Double) -> Mat2 {
  @matrix.Mat2::rotation(angle)
}

///|
/// Scaling matrix. / 缩放矩阵。
pub fn mat2_scaling(sx : Double, sy : Double) -> Mat2 {
  @matrix.Mat2::scaling(sx, sy)
}

///|
/// Trace of the matrix. / 矩阵的迹。
pub fn mat2_trace(m : Mat2) -> Double {
  @matrix.Mat2::trace(m)
}

// ---------------------------------------------------------------------------
// angle: angle utilities / 角度工具
// ---------------------------------------------------------------------------

///|
/// Degrees to radians. / 角度转弧度。
pub fn deg_to_rad(deg : Double) -> Double {
  @angle.deg_to_rad(deg)
}

///|
/// Radians to degrees. / 弧度转角度。
pub fn rad_to_deg(rad : Double) -> Double {
  @angle.rad_to_deg(rad)
}

///|
/// Normalize angle to [0, 2π). / 归一化角度到 [0, 2π)。
pub fn normalize_angle(angle : Double) -> Double {
  @angle.normalize_angle(angle)
}

///|
/// Normalize angle to [-π, π). / 归一化角度到 [-π, π)。
pub fn normalize_angle_signed(angle : Double) -> Double {
  @angle.normalize_angle_signed(angle)
}

///|
/// Angular difference (b - a) normalized to [-π, π]. / 角差归一化到 [-π, π]。
pub fn angle_diff(a : Double, b : Double) -> Double {
  @angle.angle_diff(a, b)
}

///|
/// Bisector angle of two angles. / 两角平分线角度。
pub fn angle_bisector(a : Double, b : Double) -> Double {
  @angle.bisector(a, b)
}

///|
/// Check if angle c is between a and b (CCW). / 检查角度 c 是否在 a 和 b 之间（逆时针）。
pub fn angle_is_between(a : Double, c : Double, b : Double) -> Bool {
  @angle.is_between(a, c, b)
}

// ---------------------------------------------------------------------------
// constants: geometric constants / 几何常数
// ---------------------------------------------------------------------------

///|
/// Pi. / 圆周率。
pub let pi : Double = @constants.pi

///|
/// 2 * Pi. / 2倍圆周率。
pub let two_pi : Double = @constants.two_pi

///|
/// Pi / 2. / 半圆周率。
pub let half_pi : Double = @constants.half_pi

///|
/// Pi / 4. / 四分之一圆周率。
pub let quarter_pi : Double = @constants.quarter_pi

///|
/// Euler's number. / 自然常数。
pub let euler_e : Double = @constants.e

///|
/// Square root of 2. / 根号2。
pub let sqrt2 : Double = @constants.sqrt2

///|
/// Square root of 3. / 根号3。
pub let sqrt3 : Double = @constants.sqrt3

///|
/// Golden ratio. / 黄金比例。
pub let golden_ratio : Double = @constants.golden_ratio

///|
/// Degrees to radians factor. / 角度转弧度因子。
pub let deg2rad : Double = @constants.deg2rad

///|
/// Radians to degrees factor. / 弧度转角度因子。
pub let rad2deg : Double = @constants.rad2deg

///|
/// Epsilon for geometric comparisons. / 几何比较精度。
pub let geom_eps : Double = @constants.eps

// ---------------------------------------------------------------------------
// interval: interval operations / 区间运算
// ---------------------------------------------------------------------------

///|
/// Closed interval type. / 闭区间类型。
pub type Interval = @interval.Interval

///|
/// Construct an interval. / 构造区间。
pub fn interval_new(lo : Double, hi : Double) -> Interval {
  @interval.Interval::new(lo, hi)
}

///|
/// Check if value is in the interval. / 检查值是否在区间内。
pub fn interval_contains(i : Interval, x : Double) -> Bool {
  @interval.Interval::contains(i, x)
}

///|
/// Intersection of two intervals. / 两区间交集。
pub fn interval_intersect(a : Interval, b : Interval) -> Interval? {
  @interval.Interval::intersect(a, b)
}

///|
/// Union of two overlapping intervals. / 两区间并集。
pub fn interval_union(a : Interval, b : Interval) -> Interval {
  @interval.Interval::union(a, b)
}

///|
/// Length of the interval. / 区间长度。
pub fn interval_length(i : Interval) -> Double {
  @interval.Interval::length(i)
}

///|
/// Midpoint of the interval. / 区间中点。
pub fn interval_midpoint(i : Interval) -> Double {
  @interval.Interval::midpoint(i)
}

///|
/// Check if two intervals overlap. / 检查两区间是否重叠。
pub fn interval_overlaps(a : Interval, b : Interval) -> Bool {
  @interval.Interval::overlaps(a, b)
}

///|
/// Check if interval a contains interval b. / 检查区间 a 是否包含区间 b。
pub fn interval_contains_interval(a : Interval, b : Interval) -> Bool {
  @interval.Interval::contains_interval(a, b)
}
