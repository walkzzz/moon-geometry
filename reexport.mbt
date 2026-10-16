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
// ---------------------------------------------------------------------------
// aabb_tree: AABB tree / AABB 树
// ---------------------------------------------------------------------------

///|
/// AABB tree node type. / AABB 树节点类型。
pub type AABBNode = @aabb_tree.AABBNode

///|
/// Build an AABB tree from rectangles. / 由矩形数组构建 AABB 树。
pub fn build_aabb_tree(rects : Array[Rectangle]) -> Array[AABBNode] {
  @aabb_tree.build_aabb_tree(rects)
}

///|
/// Query overlapping rectangle indices. / 查询重叠矩形索引。
pub fn query_aabb(nodes : Array[AABBNode], query : Rectangle) -> Array[Int] {
  @aabb_tree.query_aabb(nodes, query)
}

///|
/// Query rectangle indices containing a point. / 查询包含点的矩形索引。
pub fn query_point_aabb(nodes : Array[AABBNode], p : Point2D) -> Array[Int] {
  @aabb_tree.query_point_aabb(nodes, p)
}

///|
/// Count leaf nodes. / 统计叶子节点数。
pub fn count_leaves(nodes : Array[AABBNode]) -> Int {
  @aabb_tree.count_leaves(nodes)
}

// ---------------------------------------------------------------------------
// hash: geometric hashing / 几何哈希
// ---------------------------------------------------------------------------

///|
/// Grid cell index of a 2D point. / 二维点网格单元索引。
pub fn cell_index(p : Point2D, cell_size : Double) -> (Int, Int) {
  @hash.cell_index(p, cell_size)
}

///|
/// Grid cell index of a 3D point. / 三维点网格单元索引。
pub fn cell_index_3d(p : Point3D, cell_size : Double) -> (Int, Int, Int) {
  @hash.cell_index_3d(p, cell_size)
}

///|
/// Hash a 2D point to table index. / 二维点哈希到表索引。
pub fn cell_hash(p : Point2D, cell_size : Double, table_size : Int) -> Int {
  @hash.cell_hash(p, cell_size, table_size)
}

///|
/// Hash a 3D point to table index. / 三维点哈希到表索引。
pub fn cell_hash_3d(p : Point3D, cell_size : Double, table_size : Int) -> Int {
  @hash.cell_hash_3d(p, cell_size, table_size)
}

///|
/// Combine two hash values. / 合并两个哈希值。
pub fn hash_combine(a : Int, b : Int) -> Int {
  @hash.hash_combine(a, b)
}

///|
/// Cell indices of segment endpoints. / 线段端点单元索引。
pub fn segment_cells(seg : Segment, cell_size : Double) -> ((Int, Int), (Int, Int)) {
  @hash.segment_cells(seg, cell_size)
}

///|
/// Hash a segment to table index. / 线段哈希到表索引。
pub fn segment_hash(seg : Segment, cell_size : Double, table_size : Int) -> Int {
  @hash.segment_hash(seg, cell_size, table_size)
}

// ---------------------------------------------------------------------------
// compare: comparison predicates / 比较谓词
// ---------------------------------------------------------------------------

///|
/// Robust orientation test. / 鲁棒方向判定。
pub fn robust_orientation(a : Point2D, b : Point2D, c : Point2D) -> Int {
  @compare.robust_orientation(a, b, c)
}

///|
/// Robust left turn test. / 鲁棒左转判定。
pub fn robust_left_turn(a : Point2D, b : Point2D, c : Point2D) -> Bool {
  @compare.robust_left_turn(a, b, c)
}

///|
/// Robust right turn test. / 鲁棒右转判定。
pub fn robust_right_turn(a : Point2D, b : Point2D, c : Point2D) -> Bool {
  @compare.robust_right_turn(a, b, c)
}

///|
/// Robust collinearity test. / 鲁棒共线判定。
pub fn robust_collinear(a : Point2D, b : Point2D, c : Point2D, eps : Double) -> Bool {
  @compare.robust_collinear(a, b, c, eps)
}

///|
/// Lexicographic comparison of points. / 点的字典序比较。
pub fn compare_points(a : Point2D, b : Point2D) -> Int {
  @compare.compare_points(a, b)
}

///|
/// Compare segments by start point. / 按起点比较线段。
pub fn compare_segments(s1 : Segment, s2 : Segment) -> Int {
  @compare.compare_segments(s1, s2)
}

///|
/// Lexicographic less-than. / 字典序小于。
pub fn less_than(a : Point2D, b : Point2D) -> Bool {
  @compare.less_than(a, b)
}

///|
/// Check if two points are equal within epsilon. / 检查两点是否在精度内相等。
pub fn points_equal(a : Point2D, b : Point2D, eps : Double) -> Bool {
  @compare.points_equal(a, b, eps)
}

// ---------------------------------------------------------------------------
// ray: ray operations / 射线运算
// ---------------------------------------------------------------------------

///|
/// Ray type. / 射线类型。
pub type Ray = @ray.Ray

///|
/// Construct a ray. / 构造射线。
pub fn ray_new(origin : Point2D, dir : Point2D) -> Ray {
  @ray.Ray::new(origin, dir)
}

///|
/// Construct a ray from two points. / 由两点构造射线。
pub fn ray_from_points(origin : Point2D, through : Point2D) -> Ray {
  @ray.Ray::from_points(origin, through)
}

///|
/// Evaluate ray at parameter t. / 计算射线上参数 t 处的点。
pub fn ray_eval(r : Ray, t : Double) -> Point2D {
  @ray.Ray::eval(r, t)
}

///|
/// Ray-segment intersection. / 射线与线段交点。
pub fn ray_segment_intersect(r : Ray, seg : Segment) -> Point2D? {
  @ray.ray_segment_intersect(r, seg)
}

///|
/// Ray-line intersection. / 射线与直线交点。
pub fn ray_line_intersect(r : Ray, line : Line) -> Point2D? {
  @ray.ray_line_intersect(r, line)
}

///|
/// Ray-polygon boundary intersections. / 射线与多边形边界交点。
pub fn ray_polygon_intersect(r : Ray, poly : Polygon) -> Array[Point2D] {
  @ray.ray_polygon_intersect(r, poly)
}

///|
/// Check if ray origin is inside polygon. / 检查射线起点是否在多边形内。
pub fn ray_polygon_contains(r : Ray, poly : Polygon) -> Bool {
  @ray.ray_polygon_contains(r, poly)
}

// ---------------------------------------------------------------------------
// plane: 3D plane operations / 三维平面
// ---------------------------------------------------------------------------

///|
/// 3D plane type. / 三维平面类型。
pub type Plane = @plane.Plane

///|
/// Plane from normal and point. / 由法向量和点构造平面。
pub fn plane_from_normal_point(normal : Point3D, point : Point3D) -> Plane {
  @plane.Plane::from_normal_point(normal, point)
}

///|
/// Plane from three points. / 由三点构造平面。
pub fn plane_from_three_points(a : Point3D, b : Point3D, c : Point3D) -> Plane {
  @plane.Plane::from_three_points(a, b, c)
}

///|
/// Signed distance from point to plane. / 点到平面有符号距离。
pub fn plane_distance(plane : Plane, p : Point3D) -> Double {
  @plane.Plane::distance(plane, p)
}

///|
/// Check if point is on plane. / 检查点是否在平面上。
pub fn plane_contains(plane : Plane, p : Point3D, eps : Double) -> Bool {
  @plane.Plane::contains(plane, p, eps)
}

///|
/// Plane-line intersection. / 平面与直线交点。
pub fn plane_line_intersect(
  plane : Plane,
  origin : Point3D,
  dir : Point3D,
) -> Point3D? {
  @plane.Plane::line_intersect(plane, origin, dir)
}

///|
/// Normalize plane normal. / 归一化平面法向量。
pub fn plane_normalize(plane : Plane) -> Plane {
  @plane.Plane::normalize(plane)
}

///|
/// Project point onto plane. / 将点投影到平面。
pub fn plane_project(plane : Plane, p : Point3D) -> Point3D {
  @plane.Plane::project(plane, p)
}
// ---------------------------------------------------------------------------
// kdtree: k-d tree / K-d 树
// ---------------------------------------------------------------------------

///|
/// K-d tree node type. / K-d 树节点类型。
pub type KDNode = @kdtree.KDNode

///|
/// Build a k-d tree. / 构建 k-d 树。
pub fn build_kdtree(points : Array[Point2D]) -> Array[KDNode] {
  @kdtree.build_kdtree(points)
}

///|
/// Nearest neighbor search. / 最近邻搜索。
pub fn kdtree_nearest(nodes : Array[KDNode], query : Point2D) -> (Int, Double)? {
  @kdtree.kdtree_nearest(nodes, query)
}

///|
/// Range query in k-d tree. / K-d 树范围查询。
pub fn kdtree_range_query(nodes : Array[KDNode], rect : Rectangle) -> Array[Int] {
  @kdtree.kdtree_range_query(nodes, rect)
}

// ---------------------------------------------------------------------------
// quadtree: quadtree / 四叉树
// ---------------------------------------------------------------------------

///|
/// Quadtree node type. / 四叉树节点类型。
pub type QuadNode = @quadtree.QuadNode

///|
/// Build a quadtree. / 构建四叉树。
pub fn build_quadtree(points : Array[Point2D], bounds : Rectangle) -> Array[QuadNode] {
  @quadtree.build_quadtree(points, bounds)
}

///|
/// Range query in quadtree. / 四叉树范围查询。
pub fn quadtree_range_query(nodes : Array[QuadNode], rect : Rectangle) -> Array[Int] {
  @quadtree.quadtree_range_query(nodes, rect)
}

///|
/// Count points in quadtree. / 统计四叉树点数。
pub fn quadtree_count(nodes : Array[QuadNode]) -> Int {
  @quadtree.quadtree_count(nodes)
}

// ---------------------------------------------------------------------------
// grid_index: uniform grid / 均匀网格
// ---------------------------------------------------------------------------

///|
/// Grid index type. / 网格索引类型。
pub type GridIndex = @grid_index.GridIndex

///|
/// Build a grid index. / 构建网格索引。
pub fn build_grid_index(points : Array[Point2D], cell_size : Double) -> GridIndex {
  @grid_index.build_grid_index(points, cell_size)
}

///|
/// Query points within radius. / 查询半径内的点。
pub fn grid_query_radius(grid : GridIndex, center : Point2D, radius : Double) -> Array[Int] {
  @grid_index.grid_query_radius(grid, center, radius)
}

///|
/// Query points within rectangle. / 查询矩形内的点。
pub fn grid_query_rect(grid : GridIndex, rect : Rectangle) -> Array[Int] {
  @grid_index.grid_query_rect(grid, rect)
}

///|
/// Query points in a grid cell. / 查询网格单元内的点。
pub fn grid_query_cell(grid : GridIndex, p : Point2D) -> Array[Int] {
  @grid_index.grid_query_cell(grid, p)
}

///|
/// Number of points in grid. / 网格中的点数。
pub fn grid_size(grid : GridIndex) -> Int {
  @grid_index.grid_size(grid)
}

// ---------------------------------------------------------------------------
// range_tree: range tree / 范围树
// ---------------------------------------------------------------------------

///|
/// Range tree type. / 范围树类型。
pub type RangeTree = @range_tree.RangeTree

///|
/// Build a range tree. / 构建范围树。
pub fn build_range_tree(points : Array[Point2D]) -> RangeTree {
  @range_tree.build_range_tree(points)
}

///|
/// Orthogonal range query. / 正交范围查询。
pub fn range_query(
  tree : RangeTree,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
) -> Array[Int] {
  @range_tree.range_query(tree, x_lo, x_hi, y_lo, y_hi)
}

///|
/// Query by x-range. / 按 x 范围查询。
pub fn range_query_x(tree : RangeTree, x_lo : Double, x_hi : Double) -> Array[Int] {
  @range_tree.range_query_x(tree, x_lo, x_hi)
}

///|
/// Query by y-range. / 按 y 范围查询。
pub fn range_query_y(tree : RangeTree, y_lo : Double, y_hi : Double) -> Array[Int] {
  @range_tree.range_query_y(tree, y_lo, y_hi)
}

///|
/// Number of points in tree. / 范围树中的点数。
pub fn range_tree_size(tree : RangeTree) -> Int {
  @range_tree.range_tree_size(tree)
}

// ---------------------------------------------------------------------------
// sort_search: sorted array search / 有序数组搜索
// ---------------------------------------------------------------------------

///|
/// Binary search. / 二分查找。
pub fn binary_search(arr : Array[Double], target : Double) -> Int? {
  @sort_search.binary_search(arr, target)
}

///|
/// Lower bound. / 下界。
pub fn lower_bound(arr : Array[Double], target : Double) -> Int {
  @sort_search.lower_bound(arr, target)
}

///|
/// Upper bound. / 上界。
pub fn upper_bound(arr : Array[Double], target : Double) -> Int {
  @sort_search.upper_bound(arr, target)
}

///|
/// Remove duplicates from sorted array. / 去重有序数组。
pub fn unique_sorted(arr : Array[Double]) -> Array[Double] {
  @sort_search.unique_sorted(arr)
}

///|
/// Check if array is sorted. / 检查数组是否有序。
pub fn is_sorted(arr : Array[Double]) -> Bool {
  @sort_search.is_sorted(arr)
}

///|
/// K-th smallest element. / 第 k 小元素。
pub fn kth_element(arr : Array[Double], k : Int) -> Double? {
  @sort_search.kth_element(arr, k)
}

///|
/// Merge two sorted arrays. / 合并两个有序数组。
pub fn merge_sorted(a : Array[Double], b : Array[Double]) -> Array[Double] {
  @sort_search.merge_sorted(a, b)
}

// ---------------------------------------------------------------------------
// bucket_pr: bucket PR k-d tree / 桶 PR k-d 树
// ---------------------------------------------------------------------------

///|
/// Bucket PR node type. / 桶 PR 节点类型。
pub type BucketPRNode = @bucket_pr.BucketPRNode

///|
/// Build a bucket PR k-d tree. / 构建桶 PR k-d 树。
pub fn build_bucket_pr(points : Array[Point2D], bucket_size : Int) -> Array[BucketPRNode] {
  @bucket_pr.build_bucket_pr(points, bucket_size)
}

///|
/// Nearest neighbor in bucket PR tree. / 桶 PR 树最近邻。
pub fn bucket_pr_nearest(
  nodes : Array[BucketPRNode],
  points : Array[Point2D],
  query : Point2D,
) -> (Int, Double)? {
  @bucket_pr.bucket_pr_nearest(nodes, points, query)
}

///|
/// Count points in bucket PR tree. / 统计桶 PR 树点数。
pub fn bucket_pr_count(nodes : Array[BucketPRNode]) -> Int {
  @bucket_pr.bucket_pr_count(nodes)
}

// ---------------------------------------------------------------------------
// spatial_hash: spatial hash table / 空间哈希表
// ---------------------------------------------------------------------------

///|
/// Spatial hash type. / 空间哈希类型。
pub type SpatialHash = @spatial_hash.SpatialHash

///|
/// Build a spatial hash. / 构建空间哈希。
pub fn build_spatial_hash(points : Array[Point2D], cell_size : Double) -> SpatialHash {
  @spatial_hash.build_spatial_hash(points, cell_size)
}

///|
/// Query points within radius. / 查询半径内的点。
pub fn spatial_hash_query_radius(
  hash : SpatialHash,
  center : Point2D,
  radius : Double,
) -> Array[Int] {
  @spatial_hash.spatial_hash_query_radius(hash, center, radius)
}

///|
/// Query points within rectangle. / 查询矩形内的点。
pub fn spatial_hash_query_rect(hash : SpatialHash, rect : Rectangle) -> Array[Int] {
  @spatial_hash.spatial_hash_query_rect(hash, rect)
}

///|
/// Query nearby points. / 查询邻近点。
pub fn spatial_hash_nearby(hash : SpatialHash, p : Point2D) -> Array[Int] {
  @spatial_hash.spatial_hash_nearby(hash, p)
}

///|
/// Number of points. / 点数。
pub fn spatial_hash_size(hash : SpatialHash) -> Int {
  @spatial_hash.spatial_hash_size(hash)
}

// ---------------------------------------------------------------------------
// bvh: bounding volume hierarchy / 层次包围体
// ---------------------------------------------------------------------------

///|
/// BVH node type. / BVH 节点类型。
pub type BVHNode = @bvh.BVHNode

///|
/// Build a BVH. / 构建 BVH。
pub fn build_bvh(rects : Array[Rectangle]) -> Array[BVHNode] {
  @bvh.build_bvh(rects)
}

///|
/// Query overlapping rectangles. / 查询重叠矩形。
pub fn bvh_query(nodes : Array[BVHNode], rect : Rectangle) -> Array[Int] {
  @bvh.bvh_query(nodes, rect)
}

///|
/// Query rectangles containing a point. / 查询包含点的矩形。
pub fn bvh_query_point(nodes : Array[BVHNode], p : Point2D) -> Array[Int] {
  @bvh.bvh_query_point(nodes, p)
}

///|
/// Count leaf nodes. / 统计叶子节点数。
pub fn bvh_count_leaves(nodes : Array[BVHNode]) -> Int {
  @bvh.bvh_count_leaves(nodes)
}
// ---------------------------------------------------------------------------
// half_plane: half-plane intersection / 半平面交
// ---------------------------------------------------------------------------

///|
/// Half-plane type. / 半平面类型。
pub type HalfPlane = @half_plane.HalfPlane

///|
/// Construct a half-plane. / 构造半平面。
pub fn half_plane_new(a : Double, b : Double, c : Double) -> HalfPlane {
  @half_plane.HalfPlane::new(a, b, c)
}

///|
/// Check if point is in half-plane. / 检查点是否在半平面内。
pub fn half_plane_contains(hp : HalfPlane, p : Point2D) -> Bool {
  @half_plane.HalfPlane::contains(hp, p)
}

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

///|
/// Polar dual of a point. / 点的极对偶。
pub fn polar_dual_point(p : Point2D) -> Point2D {
  @polar_dual.polar_dual_point(p)
}

///|
/// Polar dual of a convex polygon. / 凸多边形的极对偶。
pub fn polar_dual(poly : Polygon) -> Array[Point2D] {
  @polar_dual.polar_dual(poly)
}

///|
/// Check if origin is inside polygon. / 检查原点是否在多边形内。
pub fn origin_inside(poly : Polygon) -> Bool {
  @polar_dual.origin_inside(poly)
}

// ---------------------------------------------------------------------------
// linear_prog: 2D linear programming / 二维线性规划
// ---------------------------------------------------------------------------

///|
/// LP result type. / 线性规划结果类型。
pub type LPResult = @linear_prog.LPResult

///|
/// Solve 2D LP. / 求解二维线性规划。
pub fn linear_program_2d(
  constraints : Array[(Double, Double, Double)],
  cx : Double,
  cy : Double,
) -> LPResult? {
  @linear_prog.linear_program_2d(constraints, cx, cy)
}

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

///|
/// Width in a direction. / 方向宽度。
pub fn width_in_direction(points : Array[Point2D], dir : Point2D) -> Double {
  @support.width_in_direction(points, dir)
}

// ---------------------------------------------------------------------------
// separating: separating axis / 分离轴
// ---------------------------------------------------------------------------

///|
/// Find separating axis. / 寻找分离轴。
pub fn find_separating_axis(poly1 : Polygon, poly2 : Polygon) -> Line? {
  @separating.find_separating_axis(poly1, poly2)
}

///|
/// Separating distance. / 分离距离。
pub fn separating_distance(poly1 : Polygon, poly2 : Polygon) -> Double {
  @separating.separating_distance(poly1, poly2)
}

///|
/// Check if two convex polygons are separated. / 检查两凸多边形是否分离。
pub fn are_separated(poly1 : Polygon, poly2 : Polygon) -> Bool {
  @separating.are_separated(poly1, poly2)
}
// ---------------------------------------------------------------------------
// polygon_offset: polygon offset / 多边形偏移
// ---------------------------------------------------------------------------

///|
/// Offset a polygon outward by a distance. / 将多边形向外偏移指定距离。
pub fn polygon_offset_outward(poly : Array[Point2D], dist : Double) -> Array[Point2D] {
  @polygon_offset.polygon_offset_outward(poly, dist)
}

///|
/// Offset a polygon inward by a distance. / 将多边形向内偏移指定距离。
pub fn polygon_offset_inward(poly : Array[Point2D], dist : Double) -> Array[Point2D] {
  @polygon_offset.polygon_offset_inward(poly, dist)
}

///|
/// Compute offset polygon area (Steiner formula). / 使用 Steiner 公式计算偏移面积。
pub fn polygon_offset_area(poly : Array[Point2D], dist : Double) -> Double {
  @polygon_offset.polygon_offset_area(poly, dist)
}

///|
/// Check if offset polygon is valid. / 检查偏移多边形是否有效。
pub fn polygon_offset_valid(poly : Array[Point2D], dist : Double) -> Bool {
  @polygon_offset.polygon_offset_valid(poly, dist)
}

// ---------------------------------------------------------------------------
// polygon_holes: polygon with holes / 带孔多边形
// ---------------------------------------------------------------------------

///|
/// Polygon with holes type. / 带孔多边形类型。
pub type PolygonWithHoles = @polygon_holes.PolygonWithHoles

///|
/// Create a polygon with holes. / 创建带孔多边形。
pub fn polygon_with_holes_new(
  outer : Array[Point2D],
  holes : Array[Array[Point2D]],
) -> PolygonWithHoles {
  @polygon_holes.polygon_with_holes_new(outer, holes)
}

///|
/// Area of polygon with holes. / 带孔多边形面积。
pub fn polygon_with_holes_area(p : PolygonWithHoles) -> Double {
  @polygon_holes.polygon_with_holes_area(p)
}

///|
/// Check if point is in polygon with holes. / 检查点是否在带孔多边形内。
pub fn polygon_with_holes_contains(p : PolygonWithHoles, pt : Point2D) -> Bool {
  @polygon_holes.polygon_with_holes_contains(p, pt)
}

///|
/// Perimeter of polygon with holes. / 带孔多边形周长。
pub fn polygon_with_holes_perimeter(p : PolygonWithHoles) -> Double {
  @polygon_holes.polygon_with_holes_perimeter(p)
}

///|
/// Count holes. / 计算孔数。
pub fn polygon_with_holes_count(p : PolygonWithHoles) -> Int {
  @polygon_holes.polygon_with_holes_count(p)
}

// ---------------------------------------------------------------------------
// visibility: visibility polygon / 可见性多边形
// ---------------------------------------------------------------------------

///|
/// Check if two points are mutually visible. / 检查两点是否互相可见。
pub fn is_visible(poly : Array[Point2D], from : Point2D, to : Point2D) -> Bool {
  @visibility.is_visible(poly, from, to)
}

///|
/// Visibility polygon from a point in convex polygon. / 凸多边形内一点的可见多边形。
pub fn visibility_polygon_convex(poly : Array[Point2D], pt : Point2D) -> Array[Point2D] {
  @visibility.visibility_polygon_convex(poly, pt)
}

///|
/// Visibility polygon (general). / 可见多边形（通用）。
pub fn visibility_polygon(poly : Array[Point2D], pt : Point2D) -> Array[Point2D] {
  @visibility.visibility_polygon(poly, pt)
}

///|
/// Count visible vertices. / 计算可见顶点数。
pub fn visible_vertex_count(poly : Array[Point2D], pt : Point2D) -> Int {
  @visibility.visible_vertex_count(poly, pt)
}

// ---------------------------------------------------------------------------
// art_gallery: art gallery problem / 美术馆问题
// ---------------------------------------------------------------------------

///|
/// Upper bound on guards (floor(n/3)). / 守卫数上界。
pub fn art_gallery_guard_count(n : Int) -> Int {
  @art_gallery.art_gallery_guard_count(n)
}

///|
/// Place guards at vertices. / 在顶点放置守卫。
pub fn art_gallery_place_guards(poly : Array[Point2D]) -> Array[Point2D] {
  @art_gallery.art_gallery_place_guards(poly)
}

///|
/// Check if guards cover all vertices. / 检查守卫是否覆盖所有顶点。
pub fn art_gallery_covers_vertices(
  poly : Array[Point2D],
  guards : Array[Point2D],
) -> Bool {
  @art_gallery.art_gallery_covers_vertices(poly, guards)
}

///|
/// Estimate guard count. / 估计守卫数。
pub fn art_gallery_estimate(poly : Array[Point2D]) -> Int {
  @art_gallery.art_gallery_estimate(poly)
}

// ---------------------------------------------------------------------------
// polygon_kernel: polygon kernel / 多边形核
// ---------------------------------------------------------------------------

///|
/// Compute polygon kernel. / 计算多边形核。
pub fn polygon_kernel(poly : Array[Point2D]) -> Array[Point2D] {
  @polygon_kernel.polygon_kernel(poly)
}

///|
/// Check if polygon is star-shaped. / 检查多边形是否为星形。
pub fn is_star_shaped(poly : Array[Point2D]) -> Bool {
  @polygon_kernel.is_star_shaped(poly)
}

///|
/// Kernel area. / 核面积。
pub fn polygon_kernel_area(poly : Array[Point2D]) -> Double {
  @polygon_kernel.polygon_kernel_area(poly)
}

///|
/// Find a point in the kernel. / 在核中找一点。
pub fn kernel_point(poly : Array[Point2D]) -> Point2D? {
  @polygon_kernel.kernel_point(poly)
}

// ---------------------------------------------------------------------------
// convex_decomp: convex decomposition / 凸分解
// ---------------------------------------------------------------------------

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

///|
/// Check if vertex is an ear. / 检查顶点是否为耳。
pub fn is_ear(poly : Array[Point2D], indices : Array[Int], i : Int) -> Bool {
  @ear_clip.is_ear(poly, indices, i)
}

///|
/// Find an ear vertex. / 找耳顶点。
pub fn find_ear(poly : Array[Point2D], indices : Array[Int]) -> Int? {
  @ear_clip.find_ear(poly, indices)
}

///|
/// Triangulate via ear clipping. / 耳裁剪三角剖分。
pub fn ear_clip_triangulate(poly : Array[Point2D]) -> Array[(Int, Int, Int)] {
  @ear_clip.ear_clip_triangulate(poly)
}

///|
/// Count ear clip triangles. / 耳裁剪三角形数。
pub fn ear_clip_count(poly : Array[Point2D]) -> Int {
  @ear_clip.ear_clip_count(poly)
}

///|
/// Ear clip total area. / 耳裁剪总面积。
pub fn ear_clip_area(poly : Array[Point2D]) -> Double {
  @ear_clip.ear_clip_area(poly)
}

// ---------------------------------------------------------------------------
// monotone: monotone polygon triangulation / 单调多边形三角剖分
// ---------------------------------------------------------------------------

///|
/// Check if polygon is y-monotone. / 检查多边形是否 y-单调。
pub fn is_y_monotone(poly : Array[Point2D]) -> Bool {
  @monotone.is_y_monotone(poly)
}

///|
/// Check if polygon is x-monotone. / 检查多边形是否 x-单调。
pub fn is_x_monotone(poly : Array[Point2D]) -> Bool {
  @monotone.is_x_monotone(poly)
}

///|
/// Triangulate y-monotone polygon. / 三角剖分 y-单调多边形。
pub fn triangulate_monotone(poly : Array[Point2D]) -> Array[(Int, Int, Int)] {
  @monotone.triangulate_monotone(poly)
}

///|
/// Count monotone triangles. / 单调三角剖分三角形数。
pub fn monotone_triangulate_count(poly : Array[Point2D]) -> Int {
  @monotone.monotone_triangulate_count(poly)
}
// ---------------------------------------------------------------------------
// catmull_rom: Catmull-Rom spline / Catmull-Rom 样条
// ---------------------------------------------------------------------------

///|
/// Evaluate Catmull-Rom spline at t. / 计算 Catmull-Rom 样条在 t 处的值。
pub fn catmull_rom_eval(
  p0 : Point2D, p1 : Point2D, p2 : Point2D, p3 : Point2D, t : Double,
) -> Point2D {
  @catmull_rom.catmull_rom_eval(p0, p1, p2, p3, t)
}

///|
/// Generate Catmull-Rom spline points. / 生成 Catmull-Rom 样条点。
pub fn catmull_rom_points(cps : Array[Point2D], num_segments : Int) -> Array[Point2D] {
  @catmull_rom.catmull_rom_points(cps, num_segments)
}

///|
/// Catmull-Rom derivative at t. / Catmull-Rom 样条导数。
pub fn catmull_rom_derivative(
  p0 : Point2D, p1 : Point2D, p2 : Point2D, p3 : Point2D, t : Double,
) -> Point2D {
  @catmull_rom.catmull_rom_derivative(p0, p1, p2, p3, t)
}

// ---------------------------------------------------------------------------
// hermite: Hermite spline / Hermite 样条
// ---------------------------------------------------------------------------

///|
/// Evaluate Hermite spline at t. / 计算 Hermite 样条在 t 处的值。
pub fn hermite_eval(
  p0 : Point2D, p1 : Point2D, m0 : Point2D, m1 : Point2D, t : Double,
) -> Point2D {
  @hermite.hermite_eval(p0, p1, m0, m1, t)
}

///|
/// Generate Hermite spline points. / 生成 Hermite 样条点。
pub fn hermite_points(
  pts : Array[Point2D], tans : Array[Point2D], num_segments : Int,
) -> Array[Point2D] {
  @hermite.hermite_points(pts, tans, num_segments)
}

///|
/// Hermite spline derivative. / Hermite 样条导数。
pub fn hermite_derivative(
  p0 : Point2D, p1 : Point2D, m0 : Point2D, m1 : Point2D, t : Double,
) -> Point2D {
  @hermite.hermite_derivative(p0, p1, m0, m1, t)
}

///|
/// Cardinal spline tangents. / Cardinal 样条切线。
pub fn cardinal_tangents(pts : Array[Point2D], tension : Double) -> Array[Point2D] {
  @hermite.cardinal_tangents(pts, tension)
}

// ---------------------------------------------------------------------------
// bspline: B-spline / B样条
// ---------------------------------------------------------------------------

///|
/// B-spline basis function. / B样条基函数。
pub fn bspline_basis(degree : Int, knots : Array[Double], i : Int, t : Double) -> Double {
  @bspline.bspline_basis(degree, knots, i, t)
}

///|
/// Evaluate B-spline at t. / 计算 B样条在 t 处的值。
pub fn bspline_eval(
  cps : Array[Point2D], degree : Int, knots : Array[Double], t : Double,
) -> Point2D {
  @bspline.bspline_eval(cps, degree, knots, t)
}

///|
/// Uniform knot vector. / 均匀节点向量。
pub fn uniform_knots(n : Int, degree : Int) -> Array[Double] {
  @bspline.uniform_knots(n, degree)
}

///|
/// Generate B-spline points. / 生成 B样条点。
pub fn bspline_points(cps : Array[Point2D], degree : Int, num_samples : Int) -> Array[Point2D] {
  @bspline.bspline_points(cps, degree, num_samples)
}

// ---------------------------------------------------------------------------
// lagrange: Lagrange interpolation / Lagrange 插值
// ---------------------------------------------------------------------------

///|
/// Evaluate Lagrange interpolation at x. / 在 x 处计算 Lagrange 插值。
pub fn lagrange_eval(xs : Array[Double], ys : Array[Double], x : Double) -> Double {
  @lagrange.lagrange_eval(xs, ys, x)
}

///|
/// Lagrange basis polynomial. / Lagrange 基多项式。
pub fn lagrange_basis(xs : Array[Double], i : Int, x : Double) -> Double {
  @lagrange.lagrange_basis(xs, i, x)
}

///|
/// Lagrange interpolate 2D points. / Lagrange 插值2D点。
pub fn lagrange_interpolate(pts : Array[Point2D], x : Double) -> Double {
  @lagrange.lagrange_interpolate(pts, x)
}

///|
/// Check distinct nodes. / 检查节点互异。
pub fn lagrange_nodes_distinct(xs : Array[Double]) -> Bool {
  @lagrange.lagrange_nodes_distinct(xs)
}

// ---------------------------------------------------------------------------
// spline: spline utilities / 样条工具
// ---------------------------------------------------------------------------

///|
/// Spline total length. / 样条总长度。
pub fn spline_length(pts : Array[Point2D]) -> Double {
  @spline.spline_length(pts)
}

///|
/// Spline curvature at point i. / 样条在点 i 处曲率。
pub fn spline_curvature(pts : Array[Point2D], i : Int) -> Double {
  @spline.spline_curvature(pts, i)
}

///|
/// Spline curvature profile. / 样条曲率分布。
pub fn spline_curvature_profile(pts : Array[Point2D]) -> Array[Double] {
  @spline.spline_curvature_profile(pts)
}

///|
/// Spline total curvature. / 样条总曲率。
pub fn spline_total_curvature(pts : Array[Point2D]) -> Double {
  @spline.spline_total_curvature(pts)
}

///|
/// Max curvature point. / 最大曲率点。
pub fn spline_max_curvature_point(pts : Array[Point2D]) -> Int? {
  @spline.spline_max_curvature_point(pts)
}

// ---------------------------------------------------------------------------
// curve_arc: arc length / 弧长
// ---------------------------------------------------------------------------

///|
/// Total arc length. / 总弧长。
pub fn arc_length(pts : Array[Point2D]) -> Double {
  @curve_arc.arc_length(pts)
}

///|
/// Arc length at parameter t. / 参数 t 处弧长。
pub fn arc_length_at(pts : Array[Point2D], t : Double) -> Double {
  @curve_arc.arc_length_at(pts, t)
}

///|
/// Reparameterize by arc length. / 按弧长重参数化。
pub fn arc_length_parametrize(pts : Array[Point2D], num_samples : Int) -> Array[Point2D] {
  @curve_arc.arc_length_parametrize(pts, num_samples)
}

///|
/// Arc length to parameter. / 弧长转参数。
pub fn arc_length_to_param(pts : Array[Point2D], s : Double) -> Double {
  @curve_arc.arc_length_to_param(pts, s)
}

// ---------------------------------------------------------------------------
// curve_intersect: curve intersection / 曲线相交
// ---------------------------------------------------------------------------

///|
/// Check if two segments cross. / 检查两线段相交。
pub fn segments_cross(p1 : Point2D, p2 : Point2D, p3 : Point2D, p4 : Point2D) -> Bool {
  @curve_intersect.segments_cross(p1, p2, p3, p4)
}

///|
/// Check polyline self-intersection. / 检查折线自相交。
pub fn curve_self_intersect(pts : Array[Point2D]) -> Bool {
  @curve_intersect.curve_self_intersect(pts)
}

///|
/// Count self-intersections. / 自相交计数。
pub fn curve_self_intersect_count(pts : Array[Point2D]) -> Int {
  @curve_intersect.curve_self_intersect_count(pts)
}

///|
/// Check if two curves intersect. / 检查两曲线相交。
pub fn curves_intersect(c1 : Array[Point2D], c2 : Array[Point2D]) -> Bool {
  @curve_intersect.curves_intersect(c1, c2)
}

// ---------------------------------------------------------------------------
// polyline: polyline operations / 折线操作
// ---------------------------------------------------------------------------

///|
/// Polyline length. / 折线长度。
pub fn polyline_length(pts : Array[Point2D]) -> Double {
  @polyline.polyline_length(pts)
}

///|
/// Simplify polyline (Douglas-Peucker). / 简化折线。
pub fn polyline_simplify(pts : Array[Point2D], eps : Double) -> Array[Point2D] {
  @polyline.polyline_simplify(pts, eps)
}

///|
/// Subdivide polyline segment. / 细分折线段。
pub fn polyline_subdivide(pts : Array[Point2D], idx : Int, t : Double) -> Array[Point2D] {
  @polyline.polyline_subdivide(pts, idx, t)
}

///|
/// Polyline segment count. / 折线段数。
pub fn polyline_segment_count(pts : Array[Point2D]) -> Int {
  @polyline.polyline_segment_count(pts)
}

// ---------------------------------------------------------------------------
// arc_length: arc length utilities / 弧长工具
// ---------------------------------------------------------------------------

///|
/// Single segment arc length. / 单线段弧长。
pub fn arc_length_segment(p1 : Point2D, p2 : Point2D) -> Double {
  @arc_length.arc_length_segment(p1, p2)
}

///|
/// Total arc length. / 总弧长。
pub fn arc_length_total(pts : Array[Point2D]) -> Double {
  @arc_length.arc_length_total(pts)
}

///|
/// Cumulative arc lengths. / 累积弧长。
pub fn arc_length_cumulative(pts : Array[Point2D]) -> Array[Double] {
  @arc_length.arc_length_cumulative(pts)
}

///|
/// Average segment length. / 平均线段长度。
pub fn arc_length_average(pts : Array[Point2D]) -> Double {
  @arc_length.arc_length_average(pts)
}

///|
/// Max segment length. / 最大线段长度。
pub fn arc_length_max_segment(pts : Array[Point2D]) -> Double {
  @arc_length.arc_length_max_segment(pts)
}

// ---------------------------------------------------------------------------
// curvature: curvature computation / 曲率计算
// ---------------------------------------------------------------------------

///|
/// Curvature at middle point. / 中间点曲率。
pub fn curvature_at(p1 : Point2D, p2 : Point2D, p3 : Point2D) -> Double {
  @curvature.curvature_at(p1, p2, p3)
}

///|
/// Signed curvature. / 有符号曲率。
pub fn curvature_signed(p1 : Point2D, p2 : Point2D, p3 : Point2D) -> Double {
  @curvature.curvature_signed(p1, p2, p3)
}

///|
/// Curvature profile. / 曲率分布。
pub fn curvature_profile(pts : Array[Point2D]) -> Array[Double] {
  @curvature.curvature_profile(pts)
}

///|
/// Radius of curvature. / 曲率半径。
pub fn curvature_radius(p1 : Point2D, p2 : Point2D, p3 : Point2D) -> Double {
  @curvature.curvature_radius(p1, p2, p3)
}

///|
/// Total curvature. / 总曲率。
pub fn curvature_total(pts : Array[Point2D]) -> Double {
  @curvature.curvature_total(pts)
}
// ---------------------------------------------------------------------------
// hausdorff: Hausdorff distance / Hausdorff 距离
// ---------------------------------------------------------------------------
///|
pub fn hausdorff_directed(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @hausdorff.hausdorff_directed(a, b)
}
///|
pub fn hausdorff_distance(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @hausdorff.hausdorff_distance(a, b)
}
///|
pub fn hausdorff_within(a : Array[Point2D], b : Array[Point2D], eps : Double) -> Bool {
  @hausdorff.hausdorff_within(a, b, eps)
}
///|
pub fn partial_hausdorff(a : Array[Point2D], b : Array[Point2D], k : Int) -> Double {
  @hausdorff.partial_hausdorff(a, b, k)
}

// ---------------------------------------------------------------------------
// frechet: Fréchet distance / Fréchet 距离
// ---------------------------------------------------------------------------
///|
pub fn frechet_distance(c1 : Array[Point2D], c2 : Array[Point2D]) -> Double {
  @frechet.frechet_distance(c1, c2)
}
///|
pub fn frechet_within(c1 : Array[Point2D], c2 : Array[Point2D], eps : Double) -> Bool {
  @frechet.frechet_within(c1, c2, eps)
}
///|
pub fn frechet_point_distance(p1 : Point2D, p2 : Point2D) -> Double {
  @frechet.frechet_point_distance(p1, p2)
}

// ---------------------------------------------------------------------------
// chamfer: Chamfer distance / Chamfer 距离
// ---------------------------------------------------------------------------
///|
pub fn chamfer_directed(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @chamfer.chamfer_directed(a, b)
}
///|
pub fn chamfer_distance(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @chamfer.chamfer_distance(a, b)
}
///|
pub fn chamfer_squared_directed(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @chamfer.chamfer_squared_directed(a, b)
}
///|
pub fn chamfer_rms(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @chamfer.chamfer_rms(a, b)
}

// ---------------------------------------------------------------------------
// emd: Earth Mover's Distance / EMD 距离
// ---------------------------------------------------------------------------
///|
pub fn emd_1d(a : Array[Double], b : Array[Double]) -> Double {
  @emd.emd_1d(a, b)
}
///|
pub fn emd_uniform(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @emd.emd_uniform(a, b)
}
///|
pub fn emd_weighted(pos : Array[Double], wa : Array[Double], wb : Array[Double]) -> Double {
  @emd.emd_weighted(pos, wa, wb)
}

// ---------------------------------------------------------------------------
// bottleneck: bottleneck matching / 瓶颈匹配
// ---------------------------------------------------------------------------
///|
pub fn bottleneck_distance(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @bottleneck.bottleneck_distance(a, b)
}
///|
pub fn bottleneck_within(a : Array[Point2D], b : Array[Point2D], t : Double) -> Bool {
  @bottleneck.bottleneck_within(a, b, t)
}
///|
pub fn bottleneck_match(a : Array[Point2D], b : Array[Point2D]) -> Array[(Int, Int, Double)] {
  @bottleneck.bottleneck_match(a, b)
}
///|
pub fn bottleneck_max(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @bottleneck.bottleneck_max(a, b)
}

// ---------------------------------------------------------------------------
// pmatch: point matching / 点匹配
// ---------------------------------------------------------------------------
///|
pub fn point_match(a : Array[Point2D], b : Array[Point2D], t : Double) -> Array[(Int, Int)] {
  @pmatch.point_match(a, b, t)
}
///|
pub fn match_count(a : Array[Point2D], b : Array[Point2D], t : Double) -> Int {
  @pmatch.match_count(a, b, t)
}
///|
pub fn match_ratio(a : Array[Point2D], b : Array[Point2D], t : Double) -> Double {
  @pmatch.match_ratio(a, b, t)
}
///|
pub fn unmatched_a(a : Array[Point2D], b : Array[Point2D], t : Double) -> Int {
  @pmatch.unmatched_a(a, b, t)
}
///|
pub fn unmatched_b(a : Array[Point2D], b : Array[Point2D], t : Double) -> Int {
  @pmatch.unmatched_b(a, b, t)
}

// ---------------------------------------------------------------------------
// dtw: dynamic time warping / DTW
// ---------------------------------------------------------------------------
///|
pub fn dtw_distance(c1 : Array[Point2D], c2 : Array[Point2D]) -> Double {
  @dtw.dtw_distance(c1, c2)
}
///|
pub fn dtw_windowed(c1 : Array[Point2D], c2 : Array[Point2D], w : Int) -> Double {
  @dtw.dtw_windowed(c1, c2, w)
}
///|
pub fn dtw_normalized(c1 : Array[Point2D], c2 : Array[Point2D]) -> Double {
  @dtw.dtw_normalized(c1, c2)
}

// ---------------------------------------------------------------------------
// metric_tree: metric tree / 度量树
// ---------------------------------------------------------------------------
///|
pub type MetricNode = @metric_tree.MetricNode
///|
pub fn build_metric_tree(pts : Array[Point2D]) -> MetricNode? {
  @metric_tree.build_metric_tree(pts)
}
///|
pub fn metric_tree_query(node : MetricNode?, q : Point2D, r : Double) -> Array[Point2D] {
  @metric_tree.metric_tree_query(node, q, r)
}
///|
pub fn metric_tree_count(node : MetricNode?) -> Int {
  @metric_tree.metric_tree_count(node)
}
///|
pub fn metric_tree_nearest(node : MetricNode?, q : Point2D) -> Point2D? {
  @metric_tree.metric_tree_nearest(node, q)
}

// ---------------------------------------------------------------------------
// dcel: doubly connected edge list / 双向连接边表
// ---------------------------------------------------------------------------
///|
pub type HalfEdge = @dcel.HalfEdge
///|
pub type DcelFace = @dcel.Face
///|
pub type DCEL = @dcel.DCEL
///|
pub fn dcel_new() -> DCEL {
  @dcel.DCEL::new()
}
///|
pub fn dcel_add_vertex(d : DCEL, p : Point2D) -> Int {
  @dcel.DCEL::add_vertex(d, p)
}
///|
pub fn dcel_add_edge(d : DCEL, from : Int, to : Int) -> Int {
  @dcel.DCEL::add_edge(d, from, to)
}
///|
pub fn dcel_add_face(d : DCEL, outer : Int) -> Int {
  @dcel.DCEL::add_face(d, outer)
}
///|
pub fn dcel_set_next(d : DCEL, he : Int, next : Int) -> Unit {
  @dcel.DCEL::set_next(d, he, next)
}
///|
pub fn dcel_set_face(d : DCEL, he : Int, face : Int) -> Unit {
  @dcel.DCEL::set_face(d, he, face)
}
///|
pub fn dcel_vertex_count(d : DCEL) -> Int {
  @dcel.DCEL::vertex_count(d)
}
///|
pub fn dcel_edge_count(d : DCEL) -> Int {
  @dcel.DCEL::edge_count(d)
}
///|
pub fn dcel_face_count(d : DCEL) -> Int {
  @dcel.DCEL::face_count(d)
}
///|
pub fn dcel_trace_face(d : DCEL, start_he : Int) -> Array[Int] {
  @dcel.DCEL::trace_face(d, start_he)
}
///|
pub fn dcel_from_polygon(d : DCEL, poly : Polygon) -> DCEL {
  @dcel.DCEL::from_polygon(d, poly)
}

// ---------------------------------------------------------------------------
// arrangement: line segment arrangement / 线段排列
// ---------------------------------------------------------------------------
///|
pub type ArrangementVertex = @arrangement.ArrangementVertex
///|
pub type Arrangement = @arrangement.Arrangement
///|
pub fn build_arrangement(segs : Array[Segment]) -> Arrangement {
  @arrangement.build_arrangement(segs)
}
///|
pub fn arrangement_vertices(arr : Arrangement) -> Array[ArrangementVertex] {
  @arrangement.arrangement_vertices(arr)
}
///|
pub fn arrangement_intersection_count(arr : Arrangement) -> Int {
  @arrangement.arrangement_intersection_count(arr)
}
///|
pub fn arrangement_edge_count(arr : Arrangement) -> Int {
  @arrangement.arrangement_edge_count(arr)
}
///|
pub fn arrangement_face_count(arr : Arrangement) -> Int {
  @arrangement.arrangement_face_count(arr)
}

// ---------------------------------------------------------------------------
// planar_graph: planar graph / 平面图
// ---------------------------------------------------------------------------
///|
pub type PlanarEdge = @planar_graph.PlanarEdge
///|
pub type PlanarGraph = @planar_graph.PlanarGraph
///|
pub fn planar_graph_new() -> PlanarGraph {
  @planar_graph.PlanarGraph::new()
}
///|
pub fn planar_graph_add_vertex(g : PlanarGraph, p : Point2D) -> Int {
  @planar_graph.PlanarGraph::add_vertex(g, p)
}
///|
pub fn planar_graph_add_edge(g : PlanarGraph, from : Int, to : Int) -> Unit {
  @planar_graph.PlanarGraph::add_edge(g, from, to)
}
///|
pub fn planar_graph_vertex_count(g : PlanarGraph) -> Int {
  @planar_graph.PlanarGraph::vertex_count(g)
}
///|
pub fn planar_graph_edge_count(g : PlanarGraph) -> Int {
  @planar_graph.PlanarGraph::edge_count(g)
}
///|
pub fn planar_graph_is_planar(g : PlanarGraph) -> Bool {
  @planar_graph.PlanarGraph::is_planar(g)
}
///|
pub fn planar_graph_degree(g : PlanarGraph, v : Int) -> Int {
  @planar_graph.PlanarGraph::degree(g, v)
}
///|
pub fn planar_graph_neighbors(g : PlanarGraph, v : Int) -> Array[Int] {
  @planar_graph.PlanarGraph::neighbors(g, v)
}
///|
pub fn planar_graph_is_connected(g : PlanarGraph) -> Bool {
  @planar_graph.PlanarGraph::is_connected(g)
}
///|
pub fn planar_graph_face_count(g : PlanarGraph) -> Int {
  @planar_graph.PlanarGraph::face_count(g)
}
///|
pub fn planar_graph_from_polygon(g : PlanarGraph, poly : Polygon) -> PlanarGraph {
  @planar_graph.PlanarGraph::from_polygon(g, poly)
}

// ---------------------------------------------------------------------------
// face_extract: face extraction / 面提取
// ---------------------------------------------------------------------------
///|
pub type ExtractFace = @face_extract.Face
///|
pub fn extract_faces(verts : Array[Point2D], edges : Array[(Int, Int)]) -> Array[ExtractFace] {
  @face_extract.extract_faces(verts, edges)
}
///|
pub fn face_area(f : ExtractFace) -> Double {
  @face_extract.face_area(f)
}
///|
pub fn face_count(faces : Array[ExtractFace]) -> Int {
  @face_extract.face_count(faces)
}

// ---------------------------------------------------------------------------
// overlay: planar subdivision overlay / 平面细分叠加
// ---------------------------------------------------------------------------
///|
pub type OverlayResult = @overlay.OverlayResult
///|
pub fn overlay(s1 : Array[Segment], s2 : Array[Segment]) -> OverlayResult {
  @overlay.overlay(s1, s2)
}
///|
pub fn overlay_vertex_count(r : OverlayResult) -> Int {
  @overlay.overlay_vertex_count(r)
}
///|
pub fn overlay_edge_count(r : OverlayResult) -> Int {
  @overlay.overlay_edge_count(r)
}
///|
pub fn overlay_vertices(r : OverlayResult) -> Array[Point2D] {
  @overlay.overlay_vertices(r)
}
///|
pub fn overlay_edges(r : OverlayResult) -> Array[(Int, Int)] {
  @overlay.overlay_edges(r)
}

// ---------------------------------------------------------------------------
// euler_tour: Euler tour / 欧拉回路
// ---------------------------------------------------------------------------
///|
pub type EulerTour = @euler_tour.EulerTour
///|
pub fn build_euler_tour(n : Int, adj : Array[Array[Int]], root : Int) -> EulerTour {
  @euler_tour.build_euler_tour(n, adj, root)
}
///|
pub fn euler_tour_sequence(t : EulerTour) -> Array[Int] {
  @euler_tour.euler_tour_sequence(t)
}
///|
pub fn euler_tour_depths(t : EulerTour) -> Array[Int] {
  @euler_tour.euler_tour_depths(t)
}
///|
pub fn euler_tour_length(t : EulerTour) -> Int {
  @euler_tour.euler_tour_length(t)
}
///|
pub fn euler_tour_first_occurrence(t : EulerTour, v : Int) -> Int {
  @euler_tour.euler_tour_first_occurrence(t, v)
}
///|
pub fn euler_tour_lca(t : EulerTour, u : Int, v : Int) -> Int {
  @euler_tour.euler_tour_lca(t, u, v)
}
///|
pub fn euler_tour_is_valid(t : EulerTour) -> Bool {
  @euler_tour.euler_tour_is_valid(t)
}

// ---------------------------------------------------------------------------
// trapezoidal: trapezoidal decomposition / 梯形分解
// ---------------------------------------------------------------------------
///|
pub type Trapezoid = @trapezoidal.Trapezoid
///|
pub type TrapezoidalMap = @trapezoidal.TrapezoidalMap
///|
pub fn build_trapezoidal_map(segs : Array[Segment]) -> TrapezoidalMap {
  @trapezoidal.build_trapezoidal_map(segs)
}
///|
pub fn trapezoidal_locate(m : TrapezoidalMap, p : Point2D) -> Int {
  @trapezoidal.trapezoidal_locate(m, p)
}
///|
pub fn trapezoidal_count(m : TrapezoidalMap) -> Int {
  @trapezoidal.trapezoidal_count(m)
}
///|
pub fn trapezoidal_all(m : TrapezoidalMap) -> Array[Trapezoid] {
  @trapezoidal.trapezoidal_all(m)
}
///|
pub fn trapezoidal_above_segment(s : Segment, p : Point2D) -> Bool {
  @trapezoidal.trapezoidal_above_segment(s, p)
}
///|
pub fn trapezoidal_expected_count(m : TrapezoidalMap) -> Int {
  @trapezoidal.trapezoidal_expected_count(m)
}

// ---------------------------------------------------------------------------
// zone: zone theorem / 区域定理
// ---------------------------------------------------------------------------
///|
pub type Zone = @zone.Zone
///|
pub fn compute_zone(line : Line, segs : Array[Segment]) -> Zone {
  @zone.compute_zone(line, segs)
}
///|
pub fn zone_crossed_count(z : Zone) -> Int {
  @zone.zone_crossed_count(z)
}
///|
pub fn zone_entry_points(z : Zone) -> Array[Point2D] {
  @zone.zone_entry_points(z)
}
///|
pub fn zone_crossed_faces(z : Zone) -> Array[Int] {
  @zone.zone_crossed_faces(z)
}
///|
pub fn zone_complexity(z : Zone) -> Int {
  @zone.zone_complexity(z)
}
///|
pub fn zone_complexity_bound(n : Int) -> Int {
  @zone.zone_complexity_bound(n)
}
