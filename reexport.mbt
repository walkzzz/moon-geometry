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

// ---------------------------------------------------------------------------
// project3d: 3D projection / 三维投影
// ---------------------------------------------------------------------------
///|
pub fn orthographic(p : Point3D) -> Point2D {
  @project3d.orthographic(p)
}
///|
pub fn perspective_project(p : Point3D, f : Double) -> Point2D? {
  @project3d.perspective_project(p, f)
}
///|
pub fn orthographic_batch(pts : Array[Point3D]) -> Array[Point2D] {
  @project3d.orthographic_batch(pts)
}
///|
pub fn perspective_batch(pts : Array[Point3D], f : Double) -> Array[Point2D] {
  @project3d.perspective_batch(pts, f)
}
///|
pub fn project_to_plane(p : Point3D, normal : Point3D, d : Double) -> Point3D {
  @project3d.project_to_plane(p, normal, d)
}
///|
pub fn isometric(p : Point3D) -> Point2D {
  @project3d.isometric(p)
}
///|
pub fn oblique(p : Point3D, alpha : Double, beta : Double) -> Point2D {
  @project3d.oblique(p, alpha, beta)
}

// ---------------------------------------------------------------------------
// homography: 3x3 projective transform / 单应变换
// ---------------------------------------------------------------------------
///|
pub type Homography = @homography.Homography
///|
pub fn homography_identity() -> Homography {
  @homography.Homography::identity()
}
///|
pub fn homography_from_array(h : Array[Double]) -> Homography {
  @homography.Homography::from_array(h)
}
///|
pub fn homography_apply(m : Homography, p : Point2D) -> Point2D? {
  @homography.Homography::apply(m, p)
}
///|
pub fn homography_compose(m1 : Homography, m2 : Homography) -> Homography {
  @homography.Homography::compose(m1, m2)
}
///|
pub fn homography_apply_batch(m : Homography, pts : Array[Point2D]) -> Array[Point2D] {
  @homography.Homography::apply_batch(m, pts)
}
///|
pub fn homography_determinant(m : Homography) -> Double {
  @homography.Homography::determinant(m)
}

// ---------------------------------------------------------------------------
// perspective: perspective transform / 透视变换
// ---------------------------------------------------------------------------
///|
pub type Perspective = @perspective.Perspective
///|
pub fn perspective_new(f : Double, cx : Double, cy : Double, n : Double, fr : Double) -> Perspective {
  @perspective.Perspective::new(f, cx, cy, n, fr)
}
///|
pub fn perspective_project_3d(p : Perspective, pt : Point3D) -> Point2D? {
  @perspective.Perspective::project(p, pt)
}
///|
pub fn perspective_unproject(p : Perspective, pt : Point2D) -> Point3D {
  @perspective.Perspective::unproject(p, pt)
}
///|
pub fn perspective_depth(p : Perspective, pt : Point3D) -> Double {
  @perspective.Perspective::depth(p, pt)
}
///|
pub fn perspective_fov(p : Perspective, w : Double) -> Double {
  @perspective.Perspective::fov(p, w)
}
///|
pub fn focal_from_fov(fov : Double, w : Double) -> Double {
  @perspective.focal_from_fov(fov, w)
}

// ---------------------------------------------------------------------------
// stereographic: stereographic projection / 球极投影
// ---------------------------------------------------------------------------
///|
pub fn stereographic_from_sphere(p : Point3D, r : Double) -> Point2D? {
  @stereographic.stereographic_from_sphere(p, r)
}
///|
pub fn stereographic_to_sphere(p : Point2D, r : Double) -> Point3D {
  @stereographic.stereographic_to_sphere(p, r)
}
///|
pub fn stereographic_from_south(p : Point3D, r : Double) -> Point2D? {
  @stereographic.stereographic_from_south(p, r)
}
///|
pub fn on_sphere(p : Point3D, r : Double) -> Bool {
  @stereographic.on_sphere(p, r)
}
///|
pub fn stereographic_scale(p : Point3D, r : Double) -> Double {
  @stereographic.stereographic_scale(p, r)
}

// ---------------------------------------------------------------------------
// affine2: 2D affine transform / 二维仿射变换
// ---------------------------------------------------------------------------
///|
pub type Affine2 = @affine2.Affine2
///|
pub fn affine2_identity() -> Affine2 {
  @affine2.Affine2::identity()
}
///|
pub fn affine2_translation(tx : Double, ty : Double) -> Affine2 {
  @affine2.Affine2::translation(tx, ty)
}
///|
pub fn affine2_scale(sx : Double, sy : Double) -> Affine2 {
  @affine2.Affine2::scale(sx, sy)
}
///|
pub fn affine2_shear(shx : Double, shy : Double) -> Affine2 {
  @affine2.Affine2::shear(shx, shy)
}
///|
pub fn affine2_apply(m : Affine2, p : Point2D) -> Point2D {
  @affine2.Affine2::apply(m, p)
}
///|
pub fn affine2_compose(m1 : Affine2, m2 : Affine2) -> Affine2 {
  @affine2.Affine2::compose(m1, m2)
}
///|
pub fn affine2_determinant(m : Affine2) -> Double {
  @affine2.Affine2::determinant(m)
}
///|
pub fn affine2_inverse(m : Affine2) -> Affine2? {
  @affine2.Affine2::inverse(m)
}
///|
pub fn affine2_apply_batch(m : Affine2, pts : Array[Point2D]) -> Array[Point2D] {
  @affine2.Affine2::apply_batch(m, pts)
}

// ---------------------------------------------------------------------------
// rigid: rigid transform / 刚体变换
// ---------------------------------------------------------------------------
///|
pub type Rigid = @rigid.Rigid
///|
pub fn rigid_identity() -> Rigid {
  @rigid.Rigid::identity()
}
///|
pub fn rigid_translation(tx : Double, ty : Double) -> Rigid {
  @rigid.Rigid::translation(tx, ty)
}
///|
pub fn rigid_rotation(angle : Double) -> Rigid {
  @rigid.Rigid::rotation(angle)
}
///|
pub fn rigid_apply(r : Rigid, p : Point2D) -> Point2D {
  @rigid.Rigid::apply(r, p)
}
///|
pub fn rigid_compose(r1 : Rigid, r2 : Rigid) -> Rigid {
  @rigid.Rigid::compose(r1, r2)
}
///|
pub fn rigid_inverse(r : Rigid) -> Rigid {
  @rigid.Rigid::inverse(r)
}
///|
pub fn rigid_apply_batch(r : Rigid, pts : Array[Point2D]) -> Array[Point2D] {
  @rigid.Rigid::apply_batch(r, pts)
}
///|
pub fn rigid_from_correspondence(s1 : Point2D, d1 : Point2D, s2 : Point2D, d2 : Point2D) -> Rigid {
  @rigid.Rigid::from_correspondence(s1, d1, s2, d2)
}

// ---------------------------------------------------------------------------
// similarity: similarity transform / 相似变换
// ---------------------------------------------------------------------------
///|
pub type Similarity = @similarity.Similarity
///|
pub fn similarity_identity() -> Similarity {
  @similarity.Similarity::identity()
}
///|
pub fn similarity_scaling(s : Double) -> Similarity {
  @similarity.Similarity::scaling(s)
}
///|
pub fn similarity_rotation(angle : Double) -> Similarity {
  @similarity.Similarity::rotation(angle)
}
///|
pub fn similarity_translation(tx : Double, ty : Double) -> Similarity {
  @similarity.Similarity::translation(tx, ty)
}
///|
pub fn similarity_apply(s : Similarity, p : Point2D) -> Point2D {
  @similarity.Similarity::apply(s, p)
}
///|
pub fn similarity_compose(s1 : Similarity, s2 : Similarity) -> Similarity {
  @similarity.Similarity::compose(s1, s2)
}
///|
pub fn similarity_inverse(s : Similarity) -> Similarity? {
  @similarity.Similarity::inverse(s)
}
///|
pub fn similarity_apply_batch(s : Similarity, pts : Array[Point2D]) -> Array[Point2D] {
  @similarity.Similarity::apply_batch(s, pts)
}
///|
pub fn similarity_from_correspondence(s1 : Point2D, d1 : Point2D, s2 : Point2D, d2 : Point2D) -> Similarity {
  @similarity.Similarity::from_correspondence(s1, d1, s2, d2)
}

// ---------------------------------------------------------------------------
// inversion: geometric inversion / 几何反演
// ---------------------------------------------------------------------------
///|
pub type Inversion = @inversion.Inversion
///|
pub fn inversion_new(center : Point2D, r : Double) -> Inversion {
  @inversion.Inversion::new(center, r)
}
///|
pub fn inversion_apply(inv : Inversion, p : Point2D) -> Point2D? {
  @inversion.Inversion::apply(inv, p)
}
///|
pub fn inversion_apply_batch(inv : Inversion, pts : Array[Point2D]) -> Array[Point2D] {
  @inversion.Inversion::apply_batch(inv, pts)
}
///|
pub fn inversion_power(inv : Inversion, p : Point2D) -> Double {
  @inversion.Inversion::power(inv, p)
}
///|
pub fn inversion_is_inside(inv : Inversion, p : Point2D) -> Bool {
  @inversion.Inversion::is_inside(inv, p)
}
///|
pub fn inversion_is_on_circle(inv : Inversion, p : Point2D) -> Bool {
  @inversion.Inversion::is_on_circle(inv, p)
}
///|
pub fn inversion_invert_line(inv : Inversion, a : Double, b : Double, c : Double) -> Circle? {
  @inversion.Inversion::invert_line(inv, a, b, c)
}

// ---------------------------------------------------------------------------
// mesh_data: 3D triangle mesh / 三维三角网格
// ---------------------------------------------------------------------------
///|
pub type MeshFace = @mesh_data.MeshFace
///|
pub type Mesh = @mesh_data.Mesh
///|
pub fn mesh_new() -> Mesh {
  @mesh_data.Mesh::new()
}
///|
pub fn mesh_add_vertex(m : Mesh, p : Point3D) -> Int {
  @mesh_data.Mesh::add_vertex(m, p)
}
///|
pub fn mesh_add_face(m : Mesh, v0 : Int, v1 : Int, v2 : Int) -> Unit {
  @mesh_data.Mesh::add_face(m, v0, v1, v2)
}
///|
pub fn mesh_vertex_count(m : Mesh) -> Int {
  @mesh_data.Mesh::vertex_count(m)
}
///|
pub fn mesh_face_count(m : Mesh) -> Int {
  @mesh_data.Mesh::face_count(m)
}
///|
pub fn mesh_edge_count(m : Mesh) -> Int {
  @mesh_data.Mesh::edge_count(m)
}
///|
pub fn mesh_bounding_box(m : Mesh) -> (Point3D, Point3D) {
  @mesh_data.Mesh::bounding_box(m)
}
///|
pub fn mesh_tetrahedron(a : Point3D, b : Point3D, c : Point3D, d : Point3D) -> Mesh {
  @mesh_data.Mesh::tetrahedron(a, b, c, d)
}

// ---------------------------------------------------------------------------
// mesh_simplify: mesh simplification / 网格简化
// ---------------------------------------------------------------------------
///|
pub fn simplify_by_edge_length(m : Mesh, t : Double) -> Mesh {
  @mesh_simplify.simplify_by_edge_length(m, t)
}
///|
pub fn edge_collapse_cost(m : Mesh, v0 : Int, v1 : Int) -> Double {
  @mesh_simplify.edge_collapse_cost(m, v0, v1)
}
///|
pub fn collapsible_edges(m : Mesh, t : Double) -> Int {
  @mesh_simplify.collapsible_edges(m, t)
}
///|
pub fn simplification_ratio(o : Mesh, s : Mesh) -> Double {
  @mesh_simplify.simplification_ratio(o, s)
}

// ---------------------------------------------------------------------------
// mesh_smooth: mesh smoothing / 网格平滑
// ---------------------------------------------------------------------------
///|
pub fn laplacian_smooth(m : Mesh, l : Double) -> Mesh {
  @mesh_smooth.laplacian_smooth(m, l)
}
///|
pub fn laplacian_smooth_iter(m : Mesh, l : Double, i : Int) -> Mesh {
  @mesh_smooth.laplacian_smooth_iter(m, l, i)
}
///|
pub fn taubin_smooth(m : Mesh, l : Double, mu : Double) -> Mesh {
  @mesh_smooth.taubin_smooth(m, l, mu)
}
///|
pub fn smooth_displacement(o : Mesh, s : Mesh) -> Double {
  @mesh_smooth.smooth_displacement(o, s)
}

// ---------------------------------------------------------------------------
// mesh_normal: mesh normals / 网格法向量
// ---------------------------------------------------------------------------
///|
pub fn face_normal(m : Mesh, fi : Int) -> Point3D {
  @mesh_normal.face_normal(m, fi)
}
///|
pub fn normalize3d(v : Point3D) -> Point3D {
  @mesh_normal.normalize(v)
}
///|
pub fn vertex_normal(m : Mesh, vi : Int) -> Point3D {
  @mesh_normal.vertex_normal(m, vi)
}
///|
pub fn all_face_normals(m : Mesh) -> Array[Point3D] {
  @mesh_normal.all_face_normals(m)
}
///|
pub fn all_vertex_normals(m : Mesh) -> Array[Point3D] {
  @mesh_normal.all_vertex_normals(m)
}
///|
pub fn mesh_face_area(m : Mesh, fi : Int) -> Double {
  @mesh_normal.face_area(m, fi)
}

// ---------------------------------------------------------------------------
// mesh_subdiv: mesh subdivision / 网格细分
// ---------------------------------------------------------------------------
///|
pub fn loop_subdivide(m : Mesh) -> Mesh {
  @mesh_subdiv.loop_subdivide(m)
}
///|
pub fn edge_bisection(m : Mesh) -> Mesh {
  @mesh_subdiv.edge_bisection(m)
}
///|
pub fn catmull_clark_subdivide(m : Mesh) -> Mesh {
  @mesh_subdiv.catmull_clark_subdivide(m)
}
///|
pub fn subdivided_face_count(m : Mesh) -> Int {
  @mesh_subdiv.subdivided_face_count(m)
}

// ---------------------------------------------------------------------------
// euler_char: Euler characteristic / 欧拉示性数
// ---------------------------------------------------------------------------
///|
pub fn euler_characteristic(m : Mesh) -> Int {
  @euler_char.euler_characteristic(m)
}
///|
pub fn surface_genus(m : Mesh) -> Int {
  @euler_char.surface_genus(m)
}
///|
pub fn is_sphere(m : Mesh) -> Bool {
  @euler_char.is_sphere(m)
}
///|
pub fn is_torus(m : Mesh) -> Bool {
  @euler_char.is_torus(m)
}
///|
pub fn euler_from_counts(v : Int, e : Int, f : Int) -> Int {
  @euler_char.euler_from_counts(v, e, f)
}
///|
pub fn betti_0(m : Mesh) -> Int {
  @euler_char.betti_0(m)
}
///|
pub fn is_manifold(m : Mesh) -> Bool {
  @euler_char.is_manifold(m)
}

// ---------------------------------------------------------------------------
// optim: geometric optimization / 几何优化
// ---------------------------------------------------------------------------
///|
pub fn smallest_enclosing_circle(pts : Array[Point2D]) -> Circle {
  @optim.smallest_enclosing_circle(pts)
}
///|
pub fn min_area_rect(pts : Array[Point2D]) -> Rectangle {
  @optim.min_area_rect(pts)
}
///|
pub fn optim_centroid(pts : Array[Point2D]) -> Point2D {
  @optim.centroid(pts)
}
///|
pub fn closest_to_centroid(pts : Array[Point2D]) -> Point2D? {
  @optim.closest_to_centroid(pts)
}

// ---------------------------------------------------------------------------
// random_gen: random generation / 随机生成
// ---------------------------------------------------------------------------
///|
pub type Rng = @random_gen.Rng
///|
pub fn rng_new(seed : UInt) -> Rng {
  @random_gen.Rng::new(seed)
}
///|
pub fn rng_next_uint(r : Rng) -> UInt {
  @random_gen.Rng::next_uint(r)
}
///|
pub fn rng_next_double(r : Rng) -> Double {
  @random_gen.Rng::next_double(r)
}
///|
pub fn rng_point2d(r : Rng, xlo : Double, xhi : Double, ylo : Double, yhi : Double) -> Point2D {
  @random_gen.Rng::point2d(r, xlo, xhi, ylo, yhi)
}
///|
pub fn rng_random_points(r : Rng, n : Int, xlo : Double, xhi : Double, ylo : Double, yhi : Double) -> Array[Point2D] {
  @random_gen.Rng::random_points(r, n, xlo, xhi, ylo, yhi)
}
///|
pub fn rng_random_convex_polygon(r : Rng, n : Int, radius : Double) -> Array[Point2D] {
  @random_gen.Rng::random_convex_polygon(r, n, radius)
}

// ---------------------------------------------------------------------------
// sampling: geometric sampling / 几何采样
// ---------------------------------------------------------------------------
///|
pub fn grid_sample(xlo : Double, xhi : Double, ylo : Double, yhi : Double, nx : Int, ny : Int) -> Array[Point2D] {
  @sampling.grid_sample(xlo, xhi, ylo, yhi, nx, ny)
}
///|
pub fn circle_sample(c : Point2D, r : Double, n : Int) -> Array[Point2D] {
  @sampling.circle_sample(c, r, n)
}
///|
pub fn circle_interior_sample(c : Point2D, r : Double, n : Int) -> Array[Point2D] {
  @sampling.circle_interior_sample(c, r, n)
}
///|
pub fn poisson_disk_sample(xlo : Double, xhi : Double, ylo : Double, yhi : Double, md : Double) -> Array[Point2D] {
  @sampling.poisson_disk_sample(xlo, xhi, ylo, yhi, md)
}
///|
pub fn segment_sample(p1 : Point2D, p2 : Point2D, n : Int) -> Array[Point2D] {
  @sampling.segment_sample(p1, p2, n)
}
///|
pub fn halton_sample(bx : Int, by : Int, n : Int) -> Array[Point2D] {
  @sampling.halton_sample(bx, by, n)
}

// ---------------------------------------------------------------------------
// svg_out: SVG output / SVG 输出
// ---------------------------------------------------------------------------
///|
pub type SvgSettings = @svg_out.SvgSettings
///|
pub fn svg_settings_default() -> SvgSettings {
  @svg_out.SvgSettings::default()
}
///|
pub fn svg_header(s : SvgSettings) -> String {
  @svg_out.svg_header(s)
}
///|
pub fn svg_footer() -> String {
  @svg_out.svg_footer()
}
///|
pub fn svg_circle(c : Circle, s : SvgSettings) -> String {
  @svg_out.svg_circle(c, s)
}
///|
pub fn svg_polygon(pts : Array[Point2D], s : SvgSettings) -> String {
  @svg_out.svg_polygon(pts, s)
}
///|
pub fn svg_line(p1 : Point2D, p2 : Point2D, s : SvgSettings) -> String {
  @svg_out.svg_line(p1, p2, s)
}
///|
pub fn svg_document(polys : Array[Array[Point2D]], s : SvgSettings) -> String {
  @svg_out.svg_document(polys, s)
}

// ---------------------------------------------------------------------------
// json_out: JSON output / JSON 输出
// ---------------------------------------------------------------------------
///|
pub fn point2d_to_json(p : Point2D) -> String {
  @json_out.point2d_to_json(p)
}
///|
pub fn point3d_to_json(p : Point3D) -> String {
  @json_out.point3d_to_json(p)
}
///|
pub fn segment_to_json(s : Segment) -> String {
  @json_out.segment_to_json(s)
}
///|
pub fn circle_to_json(c : Circle) -> String {
  @json_out.circle_to_json(c)
}
///|
pub fn rectangle_to_json(r : Rectangle) -> String {
  @json_out.rectangle_to_json(r)
}
///|
pub fn polygon_to_json(p : Polygon) -> String {
  @json_out.polygon_to_json(p)
}
///|
pub fn points_to_json(pts : Array[Point2D]) -> String {
  @json_out.points_to_json(pts)
}
///|
pub fn triangle_to_json(t : Triangle) -> String {
  @json_out.triangle_to_json(t)
}
///|
pub fn scene_to_json(pts : Array[Point2D], segs : Array[Segment], circs : Array[Circle]) -> String {
  @json_out.scene_to_json(pts, segs, circs)
}
// ---------------------------------------------------------------------------
// convex_hull_approx: Approximate convex hull / 近似凸包
// ---------------------------------------------------------------------------
///|
pub fn approx_convex_hull(points : Array[Point2D], grid_size : Int) -> Array[Point2D] {
  @convex_hull_approx.approx_convex_hull(points, grid_size)
}
///|
pub fn approx_hull_area(points : Array[Point2D]) -> Double {
  @convex_hull_approx.approx_hull_area(points)
}
///|
pub fn approx_hull_perimeter(points : Array[Point2D]) -> Double {
  @convex_hull_approx.approx_hull_perimeter(points)
}
///|
pub fn approx_error_bound(points : Array[Point2D], grid_size : Int) -> Double {
  @convex_hull_approx.approx_error_bound(points, grid_size)
}

// ---------------------------------------------------------------------------
// convex_hull_dynamic: Dynamic convex hull / 动态凸包
// ---------------------------------------------------------------------------
///|
pub type DynamicHull = @convex_hull_dynamic.DynamicHull
///|
pub fn dynamic_hull_new() -> DynamicHull {
  @convex_hull_dynamic.DynamicHull::new()
}
///|
pub fn dynamic_hull_insert(dh : DynamicHull, p : Point2D) -> Unit {
  @convex_hull_dynamic.DynamicHull::insert(dh, p)
}
///|
pub fn dynamic_hull_get_hull(dh : DynamicHull) -> Array[Point2D] {
  @convex_hull_dynamic.DynamicHull::get_hull(dh)
}
///|
pub fn dynamic_hull_size(dh : DynamicHull) -> Int {
  @convex_hull_dynamic.DynamicHull::size(dh)
}
///|
pub fn dynamic_hull_contains(dh : DynamicHull, p : Point2D) -> Bool {
  @convex_hull_dynamic.DynamicHull::contains(dh, p)
}

// ---------------------------------------------------------------------------
// convex_layers: Convex layers (onion decomposition) / 凸包层次（洋葱分解）
// ---------------------------------------------------------------------------
///|
pub fn convex_layers(points : Array[Point2D]) -> Array[Array[Point2D]] {
  @convex_layers.convex_layers(points)
}
///|
pub fn layer_count(points : Array[Point2D]) -> Int {
  @convex_layers.layer_count(points)
}
///|
pub fn outermost_layer(points : Array[Point2D]) -> Array[Point2D] {
  @convex_layers.outermost_layer(points)
}

// ---------------------------------------------------------------------------
// concave_hull: Concave hull / 凹包
// ---------------------------------------------------------------------------
///|
pub fn concave_hull(points : Array[Point2D], k : Int) -> Array[Point2D] {
  @concave_hull.concave_hull(points, k)
}
///|
pub fn concave_hull_default(points : Array[Point2D]) -> Array[Point2D] {
  @concave_hull.concave_hull_default(points)
}

// ---------------------------------------------------------------------------
// convex_width: Convex polygon width / 凸多边形宽度
// ---------------------------------------------------------------------------
///|
pub fn convex_width(poly : Polygon) -> Double {
  @convex_width.convex_width(poly)
}
///|
pub fn convex_max_width(poly : Polygon) -> Double {
  @convex_width.convex_max_width(poly)
}
///|
pub fn convex_aspect_ratio(poly : Polygon) -> Double {
  @convex_width.convex_aspect_ratio(poly)
}

// ---------------------------------------------------------------------------
// convex_diameter: Convex polygon diameter / 凸多边形直径
// ---------------------------------------------------------------------------
///|
pub fn convex_diameter(poly : Polygon) -> Double {
  @convex_diameter.convex_diameter(poly)
}
///|
pub fn convex_diameter_pair(poly : Polygon) -> (Point2D, Point2D) {
  @convex_diameter.convex_diameter_pair(poly)
}
///|
pub fn convex_radius_lower_bound(poly : Polygon) -> Double {
  @convex_diameter.convex_radius_lower_bound(poly)
}
///|
pub fn antipodal_pairs(poly : Polygon) -> Array[(Int, Int)] {
  @convex_diameter.antipodal_pairs(poly)
}

// ---------------------------------------------------------------------------
// convex_center: Convex polygon centers / 凸多边形中心
// ---------------------------------------------------------------------------
///|
pub fn convex_centroid(poly : Polygon) -> Point2D {
  @convex_center.convex_centroid(poly)
}
///|
pub fn chebyshev_center(poly : Polygon) -> Point2D {
  @convex_center.chebyshev_center(poly)
}
///|
pub fn bbox_center(poly : Polygon) -> Point2D {
  @convex_center.bbox_center(poly)
}
///|
pub fn vertex_center(poly : Polygon) -> Point2D {
  @convex_center.vertex_center(poly)
}
///|
pub fn inradius(poly : Polygon) -> Double {
  @convex_center.inradius(poly)
}

// ---------------------------------------------------------------------------
// convex_intersection: Convex polygon intersection / 凸多边形交集
// ---------------------------------------------------------------------------
///|
pub fn convex_polygon_intersection(poly1 : Polygon, poly2 : Polygon) -> Array[Point2D] {
  @convex_intersection.convex_polygon_intersection(poly1, poly2)
}
///|
pub fn convex_intersects(poly1 : Polygon, poly2 : Polygon) -> Bool {
  @convex_intersection.convex_polygons_intersect(poly1, poly2)
}
///|
pub fn intersection_area(poly1 : Polygon, poly2 : Polygon) -> Double {
  @convex_intersection.intersection_area(poly1, poly2)
}
// ---------------------------------------------------------------------------
// polygon_skeleton: Straight skeleton / 直骨架
// ---------------------------------------------------------------------------
///|
pub fn straight_skeleton(poly : Polygon) -> Array[Segment] {
  @polygon_skeleton.straight_skeleton(poly)
}
///|
pub fn skeleton_faces(poly : Polygon) -> Array[Array[Point2D]] {
  @polygon_skeleton.skeleton_faces(poly)
}

// ---------------------------------------------------------------------------
// polygon_medial: Medial axis / 中轴线
// ---------------------------------------------------------------------------
///|
pub fn medial_axis(poly : Polygon, resolution : Int) -> Array[Segment] {
  @polygon_medial.medial_axis(poly, resolution)
}
///|
pub fn medial_axis_points(poly : Polygon, n_samples : Int) -> Array[Point2D] {
  @polygon_medial.medial_axis_points(poly, n_samples)
}

// ---------------------------------------------------------------------------
// polygon_simplify: Polygon simplification / 多边形简化
// ---------------------------------------------------------------------------
///|
pub fn simplify_topology_preserve(pts : Array[Point2D], eps : Double) -> Array[Point2D] {
  @polygon_simplify.simplify_topology_preserve(pts, eps)
}
///|
pub fn simplify_visvalingam(pts : Array[Point2D], target_count : Int) -> Array[Point2D] {
  @polygon_simplify.simplify_visvalingam(pts, target_count)
}
///|
pub fn douglas_peucker(pts : Array[Point2D], eps : Double) -> Array[Point2D] {
  @polygon_simplify.douglas_peucker(pts, eps)
}

// ---------------------------------------------------------------------------
// polygon_round: Polygon corner rounding / 多边形圆角化
// ---------------------------------------------------------------------------
///|
pub fn round_polygon(pts : Array[Point2D], radius : Double, segments : Int) -> Array[Point2D] {
  @polygon_round.round_polygon(pts, radius, segments)
}
///|
pub fn round_corner(p1 : Point2D, p2 : Point2D, p3 : Point2D, radius : Double, segments : Int) -> Array[Point2D] {
  @polygon_round.round_corner(p1, p2, p3, radius, segments)
}

// ---------------------------------------------------------------------------
// polygon_evolve: Curve shortening flow / 曲率流
// ---------------------------------------------------------------------------
///|
pub fn curve_shortening_flow(pts : Array[Point2D], steps : Int, dt : Double) -> Array[Array[Point2D]] {
  @polygon_evolve.curve_shortening_flow(pts, steps, dt)
}
///|
pub fn evolve_step(pts : Array[Point2D], dt : Double) -> Array[Point2D] {
  @polygon_evolve.evolve_step(pts, dt)
}
///|
pub fn flow_perimeters(pts : Array[Point2D], steps : Int, dt : Double) -> Array[Double] {
  @polygon_evolve.flow_perimeters(pts, steps, dt)
}
///|
pub fn flow_areas(pts : Array[Point2D], steps : Int, dt : Double) -> Array[Double] {
  @polygon_evolve.flow_areas(pts, steps, dt)
}

// ---------------------------------------------------------------------------
// polygon_morph: Polygon morphing / 多边形变形
// ---------------------------------------------------------------------------
///|
pub fn morph(pts1 : Array[Point2D], pts2 : Array[Point2D], t : Double) -> Array[Point2D] {
  @polygon_morph.morph(pts1, pts2, t)
}
///|
pub fn morph_sequence(pts1 : Array[Point2D], pts2 : Array[Point2D], n_steps : Int) -> Array[Array[Point2D]] {
  @polygon_morph.morph_sequence(pts1, pts2, n_steps)
}
///|
pub fn best_alignment(pts1 : Array[Point2D], pts2 : Array[Point2D]) -> Int {
  @polygon_morph.best_alignment(pts1, pts2)
}
///|
pub fn morph_aligned(pts1 : Array[Point2D], pts2 : Array[Point2D], t : Double) -> Array[Point2D] {
  @polygon_morph.morph_aligned(pts1, pts2, t)
}

// ---------------------------------------------------------------------------
// polygon_decomp_opt: Optimal convex decomposition / 最优凸分解
// ---------------------------------------------------------------------------
///|
pub fn optimal_convex_decomp(pts : Array[Point2D]) -> Array[Array[Point2D]] {
  @polygon_decomp_opt.optimal_convex_decomp(pts)
}
///|
pub fn decomp_count(pts : Array[Point2D]) -> Int {
  @polygon_decomp_opt.decomp_count(pts)
}
///|
pub fn is_convex_check(pts : Array[Point2D]) -> Bool {
  @polygon_decomp_opt.is_convex_polygon(pts)
}

// ---------------------------------------------------------------------------
// polygon_triangulate_fast: Fast triangulation / 快速三角剖分
// ---------------------------------------------------------------------------
///|
pub fn fast_triangulate(pts : Array[Point2D]) -> Array[(Int, Int, Int)] {
  @polygon_triangulate_fast.fast_triangulate(pts)
}
///|
pub fn fast_triangulate_points(pts : Array[Point2D]) -> Array[(Point2D, Point2D, Point2D)] {
  @polygon_triangulate_fast.fast_triangulate_points(pts)
}
///|
pub fn triangle_count(pts : Array[Point2D]) -> Int {
  @polygon_triangulate_fast.triangle_count(pts)
}
///|
pub fn total_triangle_area(pts : Array[Point2D]) -> Double {
  @polygon_triangulate_fast.total_triangle_area(pts)
}
// ---------------------------------------------------------------------------
// rtree: R-tree / R树
// ---------------------------------------------------------------------------
///|
pub type RTree = @rtree.RTree
///|
pub fn rtree_new(max_entries : Int) -> RTree {
  @rtree.rtree_new(max_entries)
}
///|
pub fn rtree_insert(tree : RTree, p : Point2D) -> Unit {
  @rtree.rtree_insert(tree, p)
}
///|
pub fn rtree_range_query(tree : RTree, min_x : Double, min_y : Double, max_x : Double, max_y : Double) -> Array[Point2D] {
  @rtree.rtree_range_query(tree, min_x, min_y, max_x, max_y)
}
///|
pub fn rtree_size(tree : RTree) -> Int {
  @rtree.rtree_size(tree)
}
///|
pub fn rtree_get_all(tree : RTree) -> Array[Point2D] {
  @rtree.rtree_get_all(tree)
}

// ---------------------------------------------------------------------------
// octree: Octree / 八叉树
// ---------------------------------------------------------------------------
///|
pub type OctreeNode = @octree.OctreeNode
///|
pub fn octree_new(cx : Double, cy : Double, cz : Double, size : Double, capacity : Int, max_depth : Int) -> OctreeNode {
  @octree.octree_new(cx, cy, cz, size, capacity, max_depth)
}
///|
pub fn octree_insert(node : OctreeNode, p : Point3D) -> Unit {
  @octree.octree_insert(node, p)
}
///|
pub fn octree_range_query(node : OctreeNode, min_x : Double, min_y : Double, min_z : Double, max_x : Double, max_y : Double, max_z : Double) -> Array[Point3D] {
  @octree.octree_range_query(node, min_x, min_y, min_z, max_x, max_y, max_z)
}
///|
pub fn octree_size(node : OctreeNode) -> Int {
  @octree.octree_size(node)
}

// ---------------------------------------------------------------------------
// ball_tree: Ball tree / 球树
// ---------------------------------------------------------------------------
///|
pub type BallNode = @ball_tree.BallNode
///|
pub fn ball_tree_build(points : Array[Point2D]) -> BallNode? {
  @ball_tree.ball_tree_build(points)
}
///|
pub fn ball_tree_knn(root : BallNode?, query : Point2D, k : Int) -> Array[Point2D] {
  @ball_tree.ball_tree_knn(root, query, k)
}
///|
pub fn ball_tree_count(root : BallNode?) -> Int {
  @ball_tree.ball_tree_count(root)
}

// ---------------------------------------------------------------------------
// vp_tree: Vantage point tree / 基点树
// ---------------------------------------------------------------------------
///|
pub type VPNode = @vp_tree.VPNode
///|
pub fn vp_tree_build(points : Array[Point2D]) -> VPNode? {
  @vp_tree.vp_tree_build(points)
}
///|
pub fn vp_tree_knn(root : VPNode?, query : Point2D, k : Int) -> Array[Point2D] {
  @vp_tree.vp_tree_knn(root, query, k)
}
///|
pub fn vp_tree_count(root : VPNode?) -> Int {
  @vp_tree.vp_tree_count(root)
}

// ---------------------------------------------------------------------------
// cover_tree: Cover tree / 覆盖树
// ---------------------------------------------------------------------------
///|
pub type CoverTree = @cover_tree.CoverTree
///|
pub fn cover_tree_build(points : Array[Point2D]) -> CoverTree {
  @cover_tree.cover_tree_build(points)
}
///|
pub fn cover_tree_radius_search(tree : CoverTree, query : Point2D, radius : Double) -> Array[Point2D] {
  @cover_tree.cover_tree_radius_search(tree, query, radius)
}
///|
pub fn cover_tree_count(tree : CoverTree) -> Int {
  @cover_tree.cover_tree_count(tree)
}

// ---------------------------------------------------------------------------
// interval_tree: Interval tree / 区间树
// ---------------------------------------------------------------------------
///|
pub type IntervalEntry = @interval_tree.Interval
///|
pub type IntervalNode = @interval_tree.IntervalNode
///|
pub fn interval_tree_build(intervals : Array[IntervalEntry]) -> IntervalNode? {
  @interval_tree.interval_tree_build(intervals)
}
///|
pub fn interval_tree_query(node : IntervalNode?, x : Double) -> Array[IntervalEntry] {
  @interval_tree.interval_tree_query(node, x)
}
///|
pub fn interval_tree_count(node : IntervalNode?) -> Int {
  @interval_tree.interval_tree_count(node)
}

// ---------------------------------------------------------------------------
// skip_quadtree: Skip quadtree / 跳跃四叉树
// ---------------------------------------------------------------------------
///|
pub type SkipQuadtree = @skip_quadtree.SkipQuadtree
///|
pub fn skip_quadtree_new(cx : Double, cy : Double, size : Double, max_level : Int) -> SkipQuadtree {
  @skip_quadtree.skip_quadtree_new(cx, cy, size, max_level)
}
///|
pub fn skip_quadtree_insert(tree : SkipQuadtree, p : Point2D) -> Unit {
  @skip_quadtree.skip_quadtree_insert(tree, p)
}
///|
pub fn skip_quadtree_query(tree : SkipQuadtree, min_x : Double, min_y : Double, max_x : Double, max_y : Double) -> Array[Point2D] {
  @skip_quadtree.skip_quadtree_query(tree, min_x, min_y, max_x, max_y)
}
///|
pub fn skip_quadtree_count(tree : SkipQuadtree) -> Int {
  @skip_quadtree.skip_quadtree_count(tree)
}

// ---------------------------------------------------------------------------
// loose_octree: Loose octree / 松散八叉树
// ---------------------------------------------------------------------------
///|
pub type LooseOctNode = @loose_octree.LooseOctNode
///|
pub fn loose_octree_new(cx : Double, cy : Double, cz : Double, size : Double, loose_factor : Double, max_depth : Int) -> LooseOctNode {
  @loose_octree.loose_octree_new(cx, cy, cz, size, loose_factor, max_depth)
}
///|
pub fn loose_octree_insert(node : LooseOctNode, p : Point3D) -> Unit {
  @loose_octree.loose_octree_insert(node, p)
}
///|
pub fn loose_octree_query(node : LooseOctNode, min_x : Double, min_y : Double, min_z : Double, max_x : Double, max_y : Double, max_z : Double) -> Array[Point3D] {
  @loose_octree.loose_octree_query(node, min_x, min_y, min_z, max_x, max_y, max_z)
}
///|
pub fn loose_octree_count(node : LooseOctNode) -> Int {
  @loose_octree.loose_octree_count(node)
}
// ---------------------------------------------------------------------------
// shortest_path: Dijkstra shortest path / Dijkstra 最短路径
// ---------------------------------------------------------------------------
///|
pub type GraphEdge = @shortest_path.GraphEdge
///|
pub fn dijkstra(n : Int, adj : Array[Array[GraphEdge]], src : Int) -> Array[Double] {
  @shortest_path.dijkstra(n, adj, src)
}
///|
pub fn shortest_path_dist(n : Int, adj : Array[Array[GraphEdge]], src : Int, dst : Int) -> Double {
  @shortest_path.shortest_path_dist(n, adj, src, dst)
}
///|
pub fn shortest_path_vertices(n : Int, adj : Array[Array[GraphEdge]], src : Int, dst : Int) -> Array[Int] {
  @shortest_path.shortest_path_vertices(n, adj, src, dst)
}

// ---------------------------------------------------------------------------
// visibility_graph: Visibility graph / 可见性图
// ---------------------------------------------------------------------------
///|
pub fn build_visibility_graph(obstacles : Array[Array[Point2D]], start : Point2D, goal : Point2D) -> Array[Array[(Int, Double)]] {
  @visibility_graph.build_visibility_graph(obstacles, start, goal)
}
///|
pub fn visibility_vertices(obstacles : Array[Array[Point2D]], start : Point2D, goal : Point2D) -> Array[Point2D] {
  @visibility_graph.visibility_vertices(obstacles, start, goal)
}
///|
pub fn visibility_edge_count(obstacles : Array[Array[Point2D]], start : Point2D, goal : Point2D) -> Int {
  @visibility_graph.visibility_edge_count(obstacles, start, goal)
}

// ---------------------------------------------------------------------------
// motion_plan: Motion planning / 运动规划
// ---------------------------------------------------------------------------
///|
pub fn plan_path(obstacles : Array[Array[Point2D]], start : Point2D, goal : Point2D) -> Array[Point2D] {
  @motion_plan.plan_path(obstacles, start, goal)
}
///|
pub fn path_length(path : Array[Point2D]) -> Double {
  @motion_plan.path_length(path)
}
///|
pub fn is_path_valid(path : Array[Point2D], obstacles : Array[Array[Point2D]]) -> Bool {
  @motion_plan.is_path_valid(path, obstacles)
}

// ---------------------------------------------------------------------------
// voronoi_adv: Advanced Voronoi / 高级 Voronoi
// ---------------------------------------------------------------------------
///|
pub fn voronoi_cell(sites : Array[Point2D], site_idx : Int, bounds : (Point2D, Point2D)) -> Array[Point2D] {
  @voronoi_adv.voronoi_cell(sites, site_idx, bounds)
}
///|
pub fn farthest_voronoi_cell(sites : Array[Point2D], site_idx : Int, bounds : (Point2D, Point2D)) -> Array[Point2D] {
  @voronoi_adv.farthest_voronoi_cell(sites, site_idx, bounds)
}
///|
pub fn voronoi_cell_area(sites : Array[Point2D], site_idx : Int, bounds : (Point2D, Point2D)) -> Double {
  @voronoi_adv.voronoi_cell_area(sites, site_idx, bounds)
}
///|
pub fn voronoi_cell_count(sites : Array[Point2D]) -> Int {
  @voronoi_adv.voronoi_cell_count(sites)
}

// ---------------------------------------------------------------------------
// delaunay_refine: Delaunay refinement / Delaunay 细化
// ---------------------------------------------------------------------------
///|
pub fn delaunay_refine(pts : Array[Point2D], min_angle : Double, max_iter : Int) -> Array[Point2D] {
  @delaunay_refine.delaunay_refine(pts, min_angle, max_iter)
}
///|
pub fn circumcenter(a : Point2D, b : Point2D, c : Point2D) -> Point2D {
  @delaunay_refine.circumcenter(a, b, c)
}
///|
pub fn min_triangle_angle(a : Point2D, b : Point2D, c : Point2D) -> Double {
  @delaunay_refine.min_triangle_angle(a, b, c)
}
///|
pub fn delaunay_triangle_count(pts : Array[Point2D]) -> Int {
  @delaunay_refine.triangle_count(pts)
}

// ---------------------------------------------------------------------------
// graph_color: Graph coloring / 图着色
// ---------------------------------------------------------------------------
///|
pub fn greedy_color(n : Int, adj : Array[Array[Int]]) -> Array[Int] {
  @graph_color.greedy_color(n, adj)
}
///|
pub fn chromatic_number_upper(n : Int, adj : Array[Array[Int]]) -> Int {
  @graph_color.chromatic_number_upper(n, adj)
}
///|
pub fn is_valid_coloring(n : Int, adj : Array[Array[Int]], colors : Array[Int]) -> Bool {
  @graph_color.is_valid_coloring(n, adj, colors)
}
///|
pub fn is_bipartite(n : Int, adj : Array[Array[Int]]) -> Bool {
  @graph_color.is_bipartite(n, adj)
}

// ---------------------------------------------------------------------------
// graph_cut: Graph cut / 图割
// ---------------------------------------------------------------------------
///|
pub fn max_flow(n : Int, capacity : Array[Array[Double]], src : Int, sink : Int) -> Double {
  @graph_cut.max_flow(n, capacity, src, sink)
}
///|
pub fn min_cut(n : Int, capacity : Array[Array[Double]], src : Int, sink : Int) -> Double {
  @graph_cut.min_cut(n, capacity, src, sink)
}
///|
pub fn min_cut_partition(n : Int, capacity : Array[Array[Double]], src : Int, sink : Int) -> Array[Int] {
  @graph_cut.min_cut_partition(n, capacity, src, sink)
}

// ---------------------------------------------------------------------------
// spanning_tree: Minimum spanning tree / 最小生成树
// ---------------------------------------------------------------------------
///|
pub type WEdge = @spanning_tree.WEdge
///|
pub fn kruskal_mst(n : Int, edges : Array[WEdge]) -> Array[WEdge] {
  @spanning_tree.kruskal_mst(n, edges)
}
///|
pub fn mst_weight(n : Int, edges : Array[WEdge]) -> Double {
  @spanning_tree.mst_weight(n, edges)
}
///|
pub fn mst_edge_count(n : Int, edges : Array[WEdge]) -> Int {
  @spanning_tree.mst_edge_count(n, edges)
}
///|
pub fn is_connected(n : Int, edges : Array[WEdge]) -> Bool {
  @spanning_tree.is_connected(n, edges)
}

// ---------------------------------------------------------------------------
// polynomial: Polynomial operations / 多项式运算
// ---------------------------------------------------------------------------
///|
pub fn poly_eval(coeffs : Array[Double], x : Double) -> Double {
  @polynomial.poly_eval(coeffs, x)
}
///|
pub fn poly_derivative(coeffs : Array[Double]) -> Array[Double] {
  @polynomial.poly_derivative(coeffs)
}
///|
pub fn poly_add(a : Array[Double], b : Array[Double]) -> Array[Double] {
  @polynomial.poly_add(a, b)
}
///|
pub fn poly_mul(a : Array[Double], b : Array[Double]) -> Array[Double] {
  @polynomial.poly_mul(a, b)
}
///|
pub fn poly_roots(coeffs : Array[Double]) -> Array[Double] {
  @polynomial.poly_roots(coeffs)
}

// ---------------------------------------------------------------------------
// root_find: Root finding / 求根
// ---------------------------------------------------------------------------
///|
pub fn bisection(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  max_iter : Int,
) -> Double {
  @root_find.bisection(f, lo, hi, max_iter)
}
///|
pub fn newton(
  f : (Double) -> Double,
  fp : (Double) -> Double,
  x0 : Double,
  max_iter : Int,
) -> Double {
  @root_find.newton(f, fp, x0, max_iter)
}
///|
pub fn secant(
  f : (Double) -> Double,
  x0 : Double,
  x1 : Double,
  max_iter : Int,
) -> Double {
  @root_find.secant(f, x0, x1, max_iter)
}
///|
pub fn find_all_roots(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n_samples : Int,
) -> Array[Double] {
  @root_find.find_all_roots(f, lo, hi, n_samples)
}

// ---------------------------------------------------------------------------
// integration: Numerical integration / 数值积分
// ---------------------------------------------------------------------------
///|
pub fn trapezoid(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n : Int,
) -> Double {
  @integration.trapezoid(f, lo, hi, n)
}
///|
pub fn simpson(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n : Int,
) -> Double {
  @integration.simpson(f, lo, hi, n)
}
///|
pub fn monte_carlo(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n_samples : Int,
  seed : Int,
) -> Double {
  @integration.monte_carlo(f, lo, hi, n_samples, seed)
}
///|
pub fn adaptive_simpson(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  eps : Double,
) -> Double {
  @integration.adaptive_simpson(f, lo, hi, eps)
}

// ---------------------------------------------------------------------------
// differentiation: Numerical differentiation / 数值微分
// ---------------------------------------------------------------------------
///|
pub fn forward_diff(f : (Double) -> Double, x : Double, h : Double) -> Double {
  @differentiation.forward_diff(f, x, h)
}
///|
pub fn central_diff(f : (Double) -> Double, x : Double, h : Double) -> Double {
  @differentiation.central_diff(f, x, h)
}
///|
pub fn second_diff(f : (Double) -> Double, x : Double, h : Double) -> Double {
  @differentiation.second_diff(f, x, h)
}
///|
pub fn gradient(
  f : (Double, Double) -> Double,
  x : Double,
  y : Double,
  h : Double,
) -> (Double, Double) {
  @differentiation.gradient(f, x, y, h)
}
///|
pub fn laplacian(
  f : (Double, Double) -> Double,
  x : Double,
  y : Double,
  h : Double,
) -> Double {
  @differentiation.laplacian(f, x, y, h)
}

// ---------------------------------------------------------------------------
// interpolation: Interpolation / 插值
// ---------------------------------------------------------------------------
///|
pub fn lagrange_interp(
  xs : Array[Double],
  ys : Array[Double],
  x : Double,
) -> Double {
  @interpolation.lagrange_interp(xs, ys, x)
}
///|
pub fn newton_divdiff(
  xs : Array[Double],
  ys : Array[Double],
) -> Array[Double] {
  @interpolation.newton_divdiff(xs, ys)
}
///|
pub fn newton_interp(
  xs : Array[Double],
  ys : Array[Double],
  x : Double,
) -> Double {
  @interpolation.newton_interp(xs, ys, x)
}
///|
pub fn linear_interp(
  x0 : Double,
  y0 : Double,
  x1 : Double,
  y1 : Double,
  x : Double,
) -> Double {
  @interpolation.linear_interp(x0, y0, x1, y1, x)
}
///|
pub fn bilinear_interp(
  x0 : Double,
  x1 : Double,
  y0 : Double,
  y1 : Double,
  f00 : Double,
  f10 : Double,
  f01 : Double,
  f11 : Double,
  x : Double,
  y : Double,
) -> Double {
  @interpolation.bilinear_interp(x0, x1, y0, y1, f00, f10, f01, f11, x, y)
}

// ---------------------------------------------------------------------------
// eigen: Eigenvalue computation / 特征值计算
// ---------------------------------------------------------------------------
///|
pub fn power_iteration(
  matrix : Array[Array[Double]],
  n : Int,
  max_iter : Int,
) -> Double {
  @eigen.power_iteration(matrix, n, max_iter)
}
///|
pub fn jacobi_eigenvalues(
  matrix : Array[Array[Double]],
  n : Int,
  max_iter : Int,
) -> Array[Double] {
  @eigen.jacobi_eigenvalues(matrix, n, max_iter)
}
///|
pub fn matrix_trace(matrix : Array[Array[Double]], n : Int) -> Double {
  @eigen.matrix_trace(matrix, n)
}

// ---------------------------------------------------------------------------
// linalg: Linear algebra / 线性代数
// ---------------------------------------------------------------------------
///|
pub fn solve_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int,
) -> Array[Double] {
  @linalg.solve_linear(a, b, n)
}
///|
pub fn determinant(a : Array[Array[Double]], n : Int) -> Double {
  @linalg.determinant(a, n)
}
///|
pub fn matrix_inverse(
  a : Array[Array[Double]],
  n : Int,
) -> Array[Array[Double]]? {
  @linalg.matrix_inverse(a, n)
}

// ---------------------------------------------------------------------------
// matrix3d: 3D matrix operations / 3D 矩阵运算
// ---------------------------------------------------------------------------
///|
pub fn identity4() -> Array[Array[Double]] {
  @matrix3d.identity4()
}
///|
pub fn translation(tx : Double, ty : Double, tz : Double) -> Array[Array[Double]] {
  @matrix3d.translation(tx, ty, tz)
}
///|
pub fn scaling(sx : Double, sy : Double, sz : Double) -> Array[Array[Double]] {
  @matrix3d.scaling(sx, sy, sz)
}
///|
pub fn rotation_x(angle : Double) -> Array[Array[Double]] {
  @matrix3d.rotation_x(angle)
}
///|
pub fn rotation_y(angle : Double) -> Array[Array[Double]] {
  @matrix3d.rotation_y(angle)
}
///|
pub fn rotation_z(angle : Double) -> Array[Array[Double]] {
  @matrix3d.rotation_z(angle)
}
///|
pub fn mat4_mul(
  a : Array[Array[Double]],
  b : Array[Array[Double]],
) -> Array[Array[Double]] {
  @matrix3d.mat4_mul(a, b)
}
///|
pub fn transform_point(
  m : Array[Array[Double]],
  x : Double,
  y : Double,
  z : Double,
) -> (Double, Double, Double) {
  @matrix3d.transform_point(m, x, y, z)
}
///|
pub fn transform_direction(
  m : Array[Array[Double]],
  x : Double,
  y : Double,
  z : Double,
) -> (Double, Double, Double) {
  @matrix3d.transform_direction(m, x, y, z)
}
///|
pub fn mat4_transpose(m : Array[Array[Double]]) -> Array[Array[Double]] {
  @matrix3d.mat4_transpose(m)
}
///|
pub fn mat4_determinant(m : Array[Array[Double]]) -> Double {
  @matrix3d.mat4_determinant(m)
}
///|
pub fn mat4_inverse(m : Array[Array[Double]]) -> Array[Array[Double]]? {
  @matrix3d.mat4_inverse(m)
}
///|
pub fn look_at(
  eye : (Double, Double, Double),
  target : (Double, Double, Double),
  up : (Double, Double, Double),
) -> Array[Array[Double]] {
  @matrix3d.look_at(eye, target, up)
}
///|
pub fn perspective(
  fovy : Double,
  aspect : Double,
  near : Double,
  far : Double,
) -> Array[Array[Double]] {
  @matrix3d.perspective(fovy, aspect, near, far)
}
///|
pub fn ortho(
  left : Double,
  right : Double,
  bottom : Double,
  top : Double,
  near : Double,
  far : Double,
) -> Array[Array[Double]] {
  @matrix3d.ortho(left, right, bottom, top, near, far)
}

// ---------------------------------------------------------------------------
// nurbs: NURBS curves and surfaces / NURBS 曲线与曲面
// ---------------------------------------------------------------------------
///|
pub fn nurbs_basis(
  i : Int,
  p : Int,
  u : Double,
  knots : Array[Double],
) -> Double {
  @nurbs.bspline_basis(i, p, u, knots)
}
///|
pub fn bspline_curve_point(
  control_pts : Array[(Double, Double, Double)],
  degree : Int,
  u : Double,
  knots : Array[Double],
) -> (Double, Double, Double) {
  @nurbs.bspline_curve_point(control_pts, degree, u, knots)
}
///|
pub fn nurbs_curve_point(
  control_pts : Array[(Double, Double, Double)],
  weights : Array[Double],
  degree : Int,
  u : Double,
  knots : Array[Double],
) -> (Double, Double, Double) {
  @nurbs.nurbs_curve_point(control_pts, weights, degree, u, knots)
}
///|
pub fn nurbs_surface_point(
  control_net : Array[Array[(Double, Double, Double)]],
  weights : Array[Array[Double]],
  degree_u : Int,
  degree_v : Int,
  u : Double,
  v : Double,
  knots_u : Array[Double],
  knots_v : Array[Double],
) -> (Double, Double, Double) {
  @nurbs.nurbs_surface_point(control_net, weights, degree_u, degree_v, u, v, knots_u, knots_v)
}
///|
pub fn find_span(
  n : Int,
  p : Int,
  u : Double,
  knots : Array[Double],
) -> Int {
  @nurbs.find_span(n, p, u, knots)
}
///|
pub fn nurbs_uniform_knots(num_ctrl : Int, degree : Int) -> Array[Double] {
  @nurbs.uniform_knots(num_ctrl, degree)
}

// ---------------------------------------------------------------------------
// surface_mesh: Surface mesh operations / 曲面网格操作
// ---------------------------------------------------------------------------
///|
pub fn surf_face_normal(
  vertices : Array[(Double, Double, Double)],
  face : (Int, Int, Int),
) -> (Double, Double, Double) {
  @surface_mesh.face_normal(vertices, face)
}
///|
pub fn surf_vertex_normal(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
  vidx : Int,
) -> (Double, Double, Double) {
  @surface_mesh.vertex_normal(vertices, faces, vidx)
}
///|
pub fn triangle_area(
  vertices : Array[(Double, Double, Double)],
  face : (Int, Int, Int),
) -> Double {
  @surface_mesh.triangle_area(vertices, face)
}
///|
pub fn mesh_area(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> Double {
  @surface_mesh.mesh_area(vertices, faces)
}
///|
pub fn midpoint_subdivide(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @surface_mesh.midpoint_subdivide(vertices, faces)
}
///|
pub fn surf_mesh_bounding_box(
  vertices : Array[(Double, Double, Double)],
) -> (Double, Double, Double, Double, Double, Double) {
  @surface_mesh.mesh_bounding_box(vertices)
}
///|
pub fn validate_mesh(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> Bool {
  @surface_mesh.validate_mesh(vertices, faces)
}

// ---------------------------------------------------------------------------
// surface_param: Parametric surfaces / 参数曲面
// ---------------------------------------------------------------------------
///|
pub fn eval_surface(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
) -> (Double, Double, Double) {
  @surface_param.eval_surface(s, u, v)
}
///|
pub fn surface_du(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  @surface_param.surface_du(s, u, v, h)
}
///|
pub fn surface_dv(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  @surface_param.surface_dv(s, u, v, h)
}
///|
pub fn surface_normal(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  @surface_param.surface_normal(s, u, v, h)
}
///|
pub fn first_fundamental_form(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  @surface_param.first_fundamental_form(s, u, v, h)
}
///|
pub fn second_fundamental_form(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> (Double, Double, Double) {
  @surface_param.second_fundamental_form(s, u, v, h)
}
///|
pub fn gaussian_curvature(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> Double {
  @surface_param.gaussian_curvature(s, u, v, h)
}
///|
pub fn mean_curvature(
  s : (Double, Double) -> (Double, Double, Double),
  u : Double,
  v : Double,
  h : Double,
) -> Double {
  @surface_param.mean_curvature(s, u, v, h)
}

// ---------------------------------------------------------------------------
// surface_revolve: Surface of revolution / 旋转曲面
// ---------------------------------------------------------------------------
///|
pub fn revolve_z(
  profile : Array[(Double, Double)],
  n_segments : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @surface_revolve.revolve_z(profile, n_segments)
}
///|
pub fn revolve_x(
  profile : Array[(Double, Double)],
  n_segments : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @surface_revolve.revolve_x(profile, n_segments)
}
///|
pub fn revolve_y(
  profile : Array[(Double, Double)],
  n_segments : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @surface_revolve.revolve_y(profile, n_segments)
}
///|
pub fn revolve_point_z(
  r : Double,
  z : Double,
  theta : Double,
) -> (Double, Double, Double) {
  @surface_revolve.revolve_point_z(r, z, theta)
}
///|
pub fn revolve_area_z(profile : Array[(Double, Double)]) -> Double {
  @surface_revolve.revolve_area_z(profile)
}

// ---------------------------------------------------------------------------
// surface_sweep: Sweep surfaces / 扫掠曲面
// ---------------------------------------------------------------------------
///|
pub fn sweep_surface(
  profile : Array[(Double, Double)],
  path : Array[(Double, Double, Double)],
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @surface_sweep.sweep_surface(profile, path)
}
///|
pub fn sweep_point(
  profile_fn : (Double) -> (Double, Double),
  path_fn : (Double) -> (Double, Double, Double),
  s : Double,
  t : Double,
) -> (Double, Double, Double) {
  @surface_sweep.sweep_point(profile_fn, path_fn, s, t)
}
///|
pub fn sweep_area(
  profile : Array[(Double, Double)],
  path : Array[(Double, Double, Double)],
) -> Double {
  @surface_sweep.sweep_area(profile, path)
}

// ---------------------------------------------------------------------------
// surface_loft: Lofted surfaces / 放样曲面
// ---------------------------------------------------------------------------
///|
pub fn loft_linear(
  c1 : Array[(Double, Double, Double)],
  c2 : Array[(Double, Double, Double)],
  t : Double,
) -> Array[(Double, Double, Double)] {
  @surface_loft.loft_linear(c1, c2, t)
}
///|
pub fn loft_cubic(
  c0 : Array[(Double, Double, Double)],
  c1 : Array[(Double, Double, Double)],
  c2 : Array[(Double, Double, Double)],
  c3 : Array[(Double, Double, Double)],
  t : Double,
) -> Array[(Double, Double, Double)] {
  @surface_loft.loft_cubic(c0, c1, c2, c3, t)
}
///|
pub fn loft_mesh(
  sections : Array[Array[(Double, Double, Double)]],
  n_subdiv : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @surface_loft.loft_mesh(sections, n_subdiv)
}
///|
pub fn loft_point(
  sections : Array[Array[(Double, Double, Double)]],
  s : Double,
  t : Double,
) -> (Double, Double, Double) {
  @surface_loft.loft_point(sections, s, t)
}

// ---------------------------------------------------------------------------
// surface_trim: Trimmed surfaces / 裁剪曲面
// ---------------------------------------------------------------------------
///|
pub fn is_inside_trim(
  u : Double,
  v : Double,
  trim_loop : Array[(Double, Double)],
) -> Bool {
  @surface_trim.is_inside_trim(u, v, trim_loop)
}
///|
pub fn is_in_valid_region(
  u : Double,
  v : Double,
  outer : Array[(Double, Double)],
  inner : Array[Array[(Double, Double)]],
) -> Bool {
  @surface_trim.is_in_valid_region(u, v, outer, inner)
}
///|
pub fn trimmed_mesh(
  surface : (Double, Double) -> (Double, Double, Double),
  outer : Array[(Double, Double)],
  inner : Array[Array[(Double, Double)]],
  n_u : Int,
  n_v : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @surface_trim.trimmed_mesh(surface, outer, inner, n_u, n_v)
}
///|
pub fn trimmed_area(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> Double {
  @surface_trim.trimmed_area(vertices, faces)
}
// ---------------------------------------------------------------------------
// bezier_surface: Bezier surfaces / 贝塞尔曲面
// ---------------------------------------------------------------------------
///|
pub fn bernstein(i : Int, n : Int, t : Double) -> Double {
  @bezier_surface.bernstein(i, n, t)
}
///|
pub fn bezier_curve(
  control_pts : Array[(Double, Double, Double)],
  t : Double,
) -> (Double, Double, Double) {
  @bezier_surface.bezier_curve(control_pts, t)
}
///|
pub fn bezier_surface(
  control_net : Array[Array[(Double, Double, Double)]],
  u : Double,
  v : Double,
) -> (Double, Double, Double) {
  @bezier_surface.bezier_surface(control_net, u, v)
}
///|
pub fn bezier_surface_decasteljau(
  control_net : Array[Array[(Double, Double, Double)]],
  u : Double,
  v : Double,
) -> (Double, Double, Double) {
  @bezier_surface.bezier_surface_decasteljau(control_net, u, v)
}
///|
pub fn bezier_curve_derivative(
  control_pts : Array[(Double, Double, Double)],
  t : Double,
) -> (Double, Double, Double) {
  @bezier_surface.bezier_curve_derivative(control_pts, t)
}
///|
pub fn bezier_degree_elevate(
  control_pts : Array[(Double, Double, Double)],
) -> Array[(Double, Double, Double)] {
  @bezier_surface.bezier_degree_elevate(control_pts)
}
// Batch Q: Application Algorithms / 应用算法

// packing / 装填
pub fn pack_circles(
  radii : Array[Double],
  container_size : Double,
) -> Array[(Double, Double)] {
  @packing.pack_circles(radii, container_size)
}

pub fn pack_rectangles(
  rects : Array[(Double, Double)],
  bin_w : Double,
  bin_h : Double,
) -> Array[(Double, Double)] {
  @packing.pack_rectangles(rects, bin_w, bin_h)
}

pub fn packing_density(
  radii : Array[Double],
  container_size : Double,
) -> Double {
  @packing.packing_density(radii, container_size)
}

// covering / 覆盖
pub fn min_enclosing_circle(
  pts : Array[(Double, Double)],
) -> (Double, Double, Double) {
  @covering.min_enclosing_circle(pts)
}

pub fn greedy_cover(
  pts : Array[(Double, Double)],
  radius : Double,
) -> Array[(Double, Double)] {
  @covering.greedy_cover(pts, radius)
}

pub fn covering_radius(
  pts : Array[(Double, Double)],
  k : Int,
) -> Double {
  @covering.covering_radius(pts, k)
}

// clustering / 聚类
pub fn kmeans(
  pts : Array[(Double, Double)],
  k : Int,
  max_iter : Int,
) -> Array[Int] {
  @clustering.kmeans(pts, k, max_iter)
}

pub fn dbscan(
  pts : Array[(Double, Double)],
  eps : Double,
  min_pts : Int,
) -> Array[Int] {
  @clustering.dbscan(pts, eps, min_pts)
}

pub fn cluster_centroids(
  pts : Array[(Double, Double)],
  labels : Array[Int],
  k : Int,
) -> Array[(Double, Double)] {
  @clustering.cluster_centroids(pts, labels, k)
}

// registration / 配准
pub fn centroid_3d(
  pts : Array[(Double, Double, Double)],
) -> (Double, Double, Double) {
  @registration.centroid_3d(pts)
}

pub fn translate_pts(
  pts : Array[(Double, Double, Double)],
  tx : Double,
  ty : Double,
  tz : Double,
) -> Array[(Double, Double, Double)] {
  @registration.translate_pts(pts, tx, ty, tz)
}

pub fn icp(
  source : Array[(Double, Double, Double)],
  target : Array[(Double, Double, Double)],
  max_iter : Int,
) -> (Array[(Double, Double, Double)], (Double, Double, Double)) {
  @registration.icp(source, target, max_iter)
}

pub fn rms_error(
  source : Array[(Double, Double, Double)],
  target : Array[(Double, Double, Double)],
) -> Double {
  @registration.rms_error(source, target)
}

// matching / 匹配
pub fn nearest_neighbor_match(
  source : Array[(Double, Double)],
  target : Array[(Double, Double)],
) -> Array[Int] {
  @matching.nearest_neighbor_match(source, target)
}

pub fn match_hausdorff_distance(
  a : Array[(Double, Double)],
  b : Array[(Double, Double)],
) -> Double {
  @matching.hausdorff_distance(a, b)
}

pub fn match_chamfer_distance(
  a : Array[(Double, Double)],
  b : Array[(Double, Double)],
) -> Double {
  @matching.chamfer_distance(a, b)
}

pub fn match_points(
  source : Array[(Double, Double)],
  target : Array[(Double, Double)],
  threshold : Double,
) -> Array[(Int, Int)] {
  @matching.match_points(source, target, threshold)
}

// reconstruction / 重建
pub fn estimate_normal(
  pts : Array[(Double, Double, Double)],
  idx : Int,
  k : Int,
) -> (Double, Double, Double) {
  @reconstruction.estimate_normal(pts, idx, k)
}

pub fn ball_pivot_reconstruct(
  pts : Array[(Double, Double, Double)],
  radius : Double,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  @reconstruction.ball_pivot_reconstruct(pts, radius)
}

pub fn distance_to_mesh(
  pt : (Double, Double, Double),
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> Double {
  @reconstruction.distance_to_mesh(pt, vertices, faces)
}

// hough_transform / 霍夫变换
pub type HoughLine = @hough_transform.HoughLine
pub type HoughCircle = @hough_transform.HoughCircle

pub fn hough_lines(
  pts : Array[Point2D],
  threshold : Int,
  theta_steps : Int,
) -> Array[HoughLine] {
  @hough_transform.hough_lines(pts, threshold, theta_steps)
}

pub fn hough_circles(
  pts : Array[Point2D],
  radius : Double,
  threshold : Int,
  resolution : Int,
) -> Array[HoughCircle] {
  @hough_transform.hough_circles(pts, radius, threshold, resolution)
}

pub fn hough_accumulator(
  pts : Array[Point2D],
  theta_steps : Int,
  rho_steps : Int,
) -> Array[Array[Int]] {
  @hough_transform.hough_accumulator(pts, theta_steps, rho_steps)
}

pub fn hough_peaks(
  accumulator : Array[Array[Int]],
  threshold : Int,
  window : Int,
) -> Array[(Int, Int, Int)] {
  @hough_transform.hough_peaks(accumulator, threshold, window)
}

pub fn hough_line_to_points(
  theta : Double,
  rho : Double,
  length : Double,
) -> (Point2D, Point2D) {
  @hough_transform.hough_line_to_points(theta, rho, length)
}

// ransac / RANSAC
pub type RansacLine = @ransac.RansacLine
pub type RansacCircle = @ransac.RansacCircle
pub type RansacPlane = @ransac.RansacPlane

pub fn ransac_line(
  pts : Array[Point2D],
  iterations : Int,
  threshold : Double,
) -> RansacLine {
  @ransac.ransac_line(pts, iterations, threshold)
}

pub fn ransac_circle(
  pts : Array[Point2D],
  iterations : Int,
  threshold : Double,
) -> RansacCircle {
  @ransac.ransac_circle(pts, iterations, threshold)
}

pub fn ransac_plane(
  pts : Array[Point3D],
  iterations : Int,
  threshold : Double,
) -> RansacPlane {
  @ransac.ransac_plane(pts, iterations, threshold)
}

pub fn ransac_refit_line(
  pts : Array[Point2D],
  inliers : Array[Int],
) -> (Double, Double) {
  @ransac.ransac_refit_line(pts, inliers)
}

pub fn count_line_inliers(
  pts : Array[Point2D],
  a : Double,
  b : Double,
  threshold : Double,
) -> Int {
  @ransac.count_line_inliers(pts, a, b, threshold)
}
///|
/// === Phase 1: 3D Geometry & Polyhedra ===

pub type AABB3D = @aabb3d.AABB3D
pub type BoundingSphere = @bounding_sphere.BoundingSphere
pub type OBB = @obb.OBB
pub type MeshQualityMetrics = @mesh_quality.MeshQualityMetrics
pub type Polyhedron = @polyhedron.Polyhedron
pub type MeshRepairResult = @mesh_repair.MeshRepairResult
pub type UV = @mesh_param.UV
pub type MeshParamResult = @mesh_param.MeshParamResult
pub type BoolOp = @mesh_boolean.BoolOp
pub type MeshBoolResult = @mesh_boolean.MeshBoolResult
pub type PolyBoolResult = @polyhedron_boolean.PolyBoolResult
pub type DynamicHull3D = @convex_hull_3d_dynamic.DynamicHull3D

pub fn min_bounding_sphere(points : Array[Point3D]) -> BoundingSphere {
  @bounding_sphere.min_bounding_sphere(points)
}

pub fn obb_from_points(points : Array[Point3D]) -> OBB {
  @obb.obb_from_points(points)
}

pub fn triangle_quality(p0 : Point3D, p1 : Point3D, p2 : Point3D) -> MeshQualityMetrics {
  @mesh_quality.triangle_quality(p0, p1, p2)
}

pub fn mesh_average_quality(
  vertices : Array[Point3D],
  faces : Array[(Int, Int, Int)],
) -> MeshQualityMetrics {
  @mesh_quality.mesh_average_quality(vertices, faces)
}

pub fn count_degenerate(
  vertices : Array[Point3D],
  faces : Array[(Int, Int, Int)],
  eps : Double,
) -> Int {
  @mesh_quality.count_degenerate(vertices, faces, eps)
}

pub fn remove_degenerate_faces(
  vertices : Array[Point3D],
  faces : Array[(Int, Int, Int)],
  eps : Double,
) -> (Array[(Int, Int, Int)], Int) {
  @mesh_repair.remove_degenerate_faces(vertices, faces, eps)
}

pub fn merge_duplicate_vertices(
  vertices : Array[Point3D],
  faces : Array[(Int, Int, Int)],
  eps : Double,
) -> (Array[Point3D], Array[(Int, Int, Int)], Int) {
  @mesh_repair.merge_duplicate_vertices(vertices, faces, eps)
}

pub fn find_boundary_edges(faces : Array[(Int, Int, Int)]) -> Array[(Int, Int)] {
  @mesh_repair.find_boundary_edges(faces)
}

pub fn fill_holes(
  vertices : Array[Point3D],
  faces : Array[(Int, Int, Int)],
) -> (Array[(Int, Int, Int)], Int) {
  @mesh_repair.fill_holes(vertices, faces)
}

pub fn repair_mesh(
  vertices : Array[Point3D],
  faces : Array[(Int, Int, Int)],
  eps : Double,
) -> MeshRepairResult {
  @mesh_repair.repair_mesh(vertices, faces, eps)
}

pub fn project_parametrize(vertices : Array[Point3D]) -> Array[UV] {
  @mesh_param.project_parametrize(vertices)
}

pub fn harmonic_parametrize(
  vertices : Array[Point3D],
  faces : Array[(Int, Int, Int)],
  boundary : Array[Int],
) -> MeshParamResult {
  @mesh_param.harmonic_parametrize(vertices, faces, boundary)
}

pub fn area_distortion(
  vertices : Array[Point3D],
  faces : Array[(Int, Int, Int)],
  uv : Array[UV],
) -> Double {
  @mesh_param.area_distortion(vertices, faces, uv)
}

pub fn mesh_union(
  verts_a : Array[Point3D],
  faces_a : Array[(Int, Int, Int)],
  verts_b : Array[Point3D],
  faces_b : Array[(Int, Int, Int)],
) -> MeshBoolResult {
  @mesh_boolean.mesh_union(verts_a, faces_a, verts_b, faces_b)
}

pub fn mesh_intersection(
  verts_a : Array[Point3D],
  faces_a : Array[(Int, Int, Int)],
  verts_b : Array[Point3D],
  faces_b : Array[(Int, Int, Int)],
) -> MeshBoolResult {
  @mesh_boolean.mesh_intersection(verts_a, faces_a, verts_b, faces_b)
}

pub fn mesh_difference(
  verts_a : Array[Point3D],
  faces_a : Array[(Int, Int, Int)],
  verts_b : Array[Point3D],
  faces_b : Array[(Int, Int, Int)],
) -> MeshBoolResult {
  @mesh_boolean.mesh_difference(verts_a, faces_a, verts_b, faces_b)
}

pub fn polyhedron_union(
  verts_a : Array[Point3D],
  faces_a : Array[Array[Int]],
  verts_b : Array[Point3D],
  faces_b : Array[Array[Int]],
) -> PolyBoolResult {
  @polyhedron_boolean.polyhedron_union(verts_a, faces_a, verts_b, faces_b)
}

pub fn polyhedron_intersection(
  verts_a : Array[Point3D],
  faces_a : Array[Array[Int]],
  verts_b : Array[Point3D],
  faces_b : Array[Array[Int]],
) -> PolyBoolResult {
  @polyhedron_boolean.polyhedron_intersection(verts_a, faces_a, verts_b, faces_b)
}

pub fn polyhedron_difference(
  verts_a : Array[Point3D],
  faces_a : Array[Array[Int]],
  verts_b : Array[Point3D],
  faces_b : Array[Array[Int]],
) -> PolyBoolResult {
  @polyhedron_boolean.polyhedron_difference(verts_a, faces_a, verts_b, faces_b)
}

pub fn compute_hull_3d(points : Array[Point3D]) -> Array[(Int, Int, Int)] {
  @convex_hull_3d_dynamic.compute_hull_3d(points)
}
// ---------------------------------------------------------------------------
// delaunay_3d: 3D Delaunay triangulation / 三维 Delaunay 三角剖分
// ---------------------------------------------------------------------------

///|
/// Tetrahedron in 3D Delaunay. / Delaunay 四面体。
pub type Tetrahedron = @delaunay_3d.Tetrahedron

///|
/// 3D Delaunay triangulation result. / 三维 Delaunay 三角剖分结果。
pub type Delaunay3D = @delaunay_3d.Delaunay3D

pub fn delaunay_3d_new() -> Delaunay3D {
  @delaunay_3d.Delaunay3D::new()
}

pub fn delaunay_3d_tetrahedron_count(d : Delaunay3D) -> Int {
  @delaunay_3d.Delaunay3D::tetrahedron_count(d)
}

pub fn delaunay_3d_vertex_count(d : Delaunay3D) -> Int {
  @delaunay_3d.Delaunay3D::vertex_count(d)
}

pub fn tetrahedron_volume(
  a : Point3D,
  b : Point3D,
  c : Point3D,
  d : Point3D,
) -> Double {
  @delaunay_3d.tetrahedron_volume(a, b, c, d)
}

pub fn circumsphere_center(
  a : Point3D,
  b : Point3D,
  c : Point3D,
  d : Point3D,
) -> Point3D {
  @delaunay_3d.circumsphere_center(a, b, c, d)
}

pub fn circumsphere_radius_sq(
  a : Point3D,
  b : Point3D,
  c : Point3D,
  d : Point3D,
) -> Double {
  @delaunay_3d.circumsphere_radius_sq(a, b, c, d)
}

pub fn in_circumsphere(
  p : Point3D,
  a : Point3D,
  b : Point3D,
  c : Point3D,
  d : Point3D,
) -> Bool {
  @delaunay_3d.in_circumsphere(p, a, b, c, d)
}

pub fn delaunay_3d(points : Array[Point3D]) -> Delaunay3D {
  @delaunay_3d.delaunay_3d(points)
}

pub fn is_delaunay(d : Delaunay3D) -> Bool {
  @delaunay_3d.is_delaunay(d)
}

// ---------------------------------------------------------------------------
// voronoi_3d: 3D Voronoi diagram / 三维 Voronoi 图
// ---------------------------------------------------------------------------

///|
/// 3D Voronoi cell. / 三维 Voronoi 单元。
pub type VoronoiCell3D = @voronoi_3d.VoronoiCell3D

///|
/// 3D Voronoi diagram. / 三维 Voronoi 图。
pub type Voronoi3D = @voronoi_3d.Voronoi3D

pub fn voronoi_3d_new() -> Voronoi3D {
  @voronoi_3d.Voronoi3D::new()
}

pub fn voronoi_3d_cell_count(v : Voronoi3D) -> Int {
  @voronoi_3d.Voronoi3D::cell_count(v)
}

pub fn voronoi_3d_vertex_count(v : Voronoi3D) -> Int {
  @voronoi_3d.Voronoi3D::vertex_count(v)
}

pub fn voronoi_3d(sites : Array[Point3D]) -> Voronoi3D {
  @voronoi_3d.voronoi_3d(sites)
}

pub fn voronoi_cell_3d(v : Voronoi3D, site_idx : Int) -> VoronoiCell3D {
  @voronoi_3d.voronoi_cell_3d(v, site_idx)
}

pub fn voronoi_3d_cell_count_from_sites(sites : Array[Point3D]) -> Int {
  @voronoi_3d.voronoi_cell_count(sites)
}

pub fn voronoi_3d_vertex_count_from_sites(sites : Array[Point3D]) -> Int {
  @voronoi_3d.voronoi_vertex_count(sites)
}

pub fn dual_delaunay(sites : Array[Point3D]) -> Delaunay3D {
  @voronoi_3d.dual_delaunay(sites)
}

// ---------------------------------------------------------------------------
// constrained_delaunay: Constrained Delaunay triangulation / 约束 Delaunay 三角剖分
// ---------------------------------------------------------------------------

///|
/// Constrained Delaunay triangulation. / 约束 Delaunay 三角剖分。
pub type ConstrainedDelaunay = @constrained_delaunay.ConstrainedDelaunay

pub fn constrained_delaunay_new() -> ConstrainedDelaunay {
  @constrained_delaunay.ConstrainedDelaunay::new()
}

pub fn constrained_delaunay_triangle_count(cd : ConstrainedDelaunay) -> Int {
  @constrained_delaunay.ConstrainedDelaunay::triangle_count(cd)
}

pub fn constrained_delaunay_constraint_count(cd : ConstrainedDelaunay) -> Int {
  @constrained_delaunay.ConstrainedDelaunay::constraint_count(cd)
}

pub fn is_constrained_edge(cd : ConstrainedDelaunay, a : Int, b : Int) -> Bool {
  @constrained_delaunay.is_constrained_edge(cd, a, b)
}

pub fn add_constraint(cd : ConstrainedDelaunay, a : Int, b : Int) -> Unit {
  @constrained_delaunay.add_constraint(cd, a, b)
}

pub fn constrained_delaunay(
  points : Array[Point2D],
  constraints : Array[(Int, Int)],
) -> ConstrainedDelaunay {
  @constrained_delaunay.constrained_delaunay(points, constraints)
}

pub fn constrained_triangle_count(cd : ConstrainedDelaunay) -> Int {
  @constrained_delaunay.constrained_triangle_count(cd)
}

// ---------------------------------------------------------------------------
// power_diagram: Power diagram / 幂图
// ---------------------------------------------------------------------------

///|
/// Weighted point for power diagram. / 幂图加权站点。
pub type WeightedPoint = @power_diagram.WeightedPoint

///|
/// Power cell. / 幂单元。
pub type PowerCell = @power_diagram.PowerCell

///|
/// Power diagram. / 幂图。
pub type PowerDiagram = @power_diagram.PowerDiagram

pub fn weighted_point_new(point : Point2D, weight : Double) -> WeightedPoint {
  @power_diagram.WeightedPoint::new(point, weight)
}

pub fn power_diagram_new() -> PowerDiagram {
  @power_diagram.PowerDiagram::new()
}

pub fn power_diagram_cell_count(pd : PowerDiagram) -> Int {
  @power_diagram.PowerDiagram::cell_count(pd)
}

pub fn power_distance(x : Point2D, site : WeightedPoint) -> Double {
  @power_diagram.power_distance(x, site)
}

pub fn power_diagram(
  sites : Array[WeightedPoint],
  bounds : (Point2D, Point2D),
) -> PowerDiagram {
  @power_diagram.power_diagram(sites, bounds)
}

pub fn power_cell(pd : PowerDiagram, site_idx : Int) -> PowerCell {
  @power_diagram.power_cell(pd, site_idx)
}

pub fn power_cell_area(pd : PowerDiagram, site_idx : Int) -> Double {
  @power_diagram.power_cell_area(pd, site_idx)
}

pub fn regular_triangulation(sites : Array[WeightedPoint]) -> Array[(Int, Int, Int)] {
  @power_diagram.regular_triangulation(sites)
}

// ---------------------------------------------------------------------------
// centroidal_voronoi: Centroidal Voronoi tessellation / 质心 Voronoi 镶嵌
// ---------------------------------------------------------------------------

///|
/// CVT result. / CVT 结果。
pub type CVTResult = @centroidal_voronoi.CVTResult

pub fn cvt_result_new() -> CVTResult {
  @centroidal_voronoi.CVTResult::new()
}

pub fn compute_centroid(poly : Array[Point2D]) -> Point2D {
  @centroidal_voronoi.compute_centroid(poly)
}

pub fn lloyd_energy(sites : Array[Point2D], bounds : (Point2D, Point2D)) -> Double {
  @centroidal_voronoi.lloyd_energy(sites, bounds)
}

pub fn lloyd_iteration(
  sites : Array[Point2D],
  bounds : (Point2D, Point2D),
  max_iter : Int,
) -> Array[Point2D] {
  @centroidal_voronoi.lloyd_iteration(sites, bounds, max_iter)
}

pub fn centroidal_voronoi(
  sites : Array[Point2D],
  bounds : (Point2D, Point2D),
  max_iter : Int,
) -> CVTResult {
  @centroidal_voronoi.centroidal_voronoi(sites, bounds, max_iter)
}

// ---------------------------------------------------------------------------
// alpha_complex: Alpha complex / Alpha 复形
// ---------------------------------------------------------------------------

///|
/// Alpha simplex. / Alpha 单纯形。
pub type AlphaSimplex = @alpha_complex.AlphaSimplex

///|
/// Alpha complex. / Alpha 复形。
pub type AlphaComplex = @alpha_complex.AlphaComplex

pub fn alpha_complex_new() -> AlphaComplex {
  @alpha_complex.AlphaComplex::new()
}

pub fn alpha_complex_simplex_count(ac : AlphaComplex) -> Int {
  @alpha_complex.AlphaComplex::simplex_count(ac)
}

pub fn is_alpha_exposed(simplex : AlphaSimplex, alpha : Double) -> Bool {
  @alpha_complex.is_alpha_exposed(simplex, alpha)
}

pub fn alpha_complex(points : Array[Point2D], alpha : Double) -> AlphaComplex {
  @alpha_complex.alpha_complex(points, alpha)
}

pub fn alpha_shape(points : Array[Point2D], alpha : Double) -> Array[(Int, Int)] {
  @alpha_complex.alpha_shape(points, alpha)
}

pub fn alpha_complex_count(ac : AlphaComplex) -> Int {
  @alpha_complex.alpha_complex_count(ac)
}

// ---------------------------------------------------------------------------
// persistent_homology: Persistent homology / 持久同调
// ---------------------------------------------------------------------------

///|
/// Persistence barcode. / 持久同调条形码。
pub type Barcode = @persistent_homology.Barcode

///|
/// Simplex with filtration value. / 带过滤值的单纯形。
pub type SimplexWithFiltration = @persistent_homology.SimplexWithFiltration

///|
/// Persistence diagram. / 持久同调图。
pub type PersistenceDiagram = @persistent_homology.PersistenceDiagram

pub fn barcode_new(birth : Double, death : Double, dimension : Int) -> Barcode {
  @persistent_homology.Barcode::new(birth, death, dimension)
}

pub fn barcode_is_infinite(b : Barcode) -> Bool {
  @persistent_homology.Barcode::is_infinite(b)
}

pub fn simplex_with_filtration_new(
  vertices : Array[Int],
  filtration : Double,
) -> SimplexWithFiltration {
  @persistent_homology.SimplexWithFiltration::new(vertices, filtration)
}

pub fn persistence_diagram_new() -> PersistenceDiagram {
  @persistent_homology.PersistenceDiagram::new()
}

pub fn persistence_diagram_barcode_count(pd : PersistenceDiagram) -> Int {
  @persistent_homology.PersistenceDiagram::barcode_count(pd)
}

pub fn persistence_pairs(
  simplices : Array[SimplexWithFiltration],
) -> Array[(Int, Int)] {
  @persistent_homology.persistence_pairs(simplices)
}

pub fn compute_barcode(
  simplices : Array[SimplexWithFiltration],
) -> Array[Barcode] {
  @persistent_homology.compute_barcode(simplices)
}

pub fn persistent_homology(
  simplices : Array[SimplexWithFiltration],
) -> PersistenceDiagram {
  @persistent_homology.persistent_homology(simplices)
}

pub fn betti_from_barcode(barcodes : Array[Barcode], threshold : Double) -> Array[Int] {
  @persistent_homology.betti_from_barcode(barcodes, threshold)
}

// ---------------------------------------------------------------------------
// betti_numbers: Betti numbers / Betti 数
// ---------------------------------------------------------------------------

///|
/// Betti numbers result. / Betti 数结果。
pub type BettiResult = @betti_numbers.BettiResult

pub fn betti_result_new(b0 : Int, b1 : Int, b2 : Int) -> BettiResult {
  @betti_numbers.BettiResult::new(b0, b1, b2)
}

pub fn betti_numbers_0(simplices : Array[Array[Int]]) -> Int {
  @betti_numbers.betti_0(simplices)
}

pub fn betti_1(simplices : Array[Array[Int]]) -> Int {
  @betti_numbers.betti_1(simplices)
}

pub fn betti_2(simplices : Array[Array[Int]]) -> Int {
  @betti_numbers.betti_2(simplices)
}

pub fn betti_numbers(simplices : Array[Array[Int]]) -> BettiResult {
  @betti_numbers.betti_numbers(simplices)
}

pub fn compute_euler(simplices : Array[Array[Int]]) -> Int {
  @betti_numbers.compute_euler(simplices)
}

// ---------------------------------------------------------------------------
// reeb_graph: Reeb graph / Reeb 图
// ---------------------------------------------------------------------------

///|
/// Critical point type. / 临界点类型。
pub type CriticalType = @reeb_graph.CriticalType

///|
/// Reeb graph node. / Reeb 图节点。
pub type ReebNode = @reeb_graph.ReebNode

///|
/// Reeb graph edge. / Reeb 图边。
pub type ReebEdge = @reeb_graph.ReebEdge

///|
/// Reeb graph. / Reeb 图。
pub type ReebGraph = @reeb_graph.ReebGraph

pub fn reeb_node_new(
  vertex_idx : Int,
  level : Double,
  crit_type : CriticalType,
) -> ReebNode {
  @reeb_graph.ReebNode::new(vertex_idx, level, crit_type)
}

pub fn reeb_edge_new(from : Int, to : Int) -> ReebEdge {
  @reeb_graph.ReebEdge::new(from, to)
}

pub fn reeb_graph_new() -> ReebGraph {
  @reeb_graph.ReebGraph::new()
}

pub fn reeb_graph_node_count(rg : ReebGraph) -> Int {
  @reeb_graph.ReebGraph::node_count(rg)
}

pub fn reeb_graph_edge_count(rg : ReebGraph) -> Int {
  @reeb_graph.ReebGraph::edge_count(rg)
}

pub fn critical_points(values : Array[Double], edges : Array[(Int, Int)]) -> Array[ReebNode] {
  @reeb_graph.critical_points(values, edges)
}

pub fn reeb_graph(values : Array[Double], edges : Array[(Int, Int)]) -> ReebGraph {
  @reeb_graph.reeb_graph(values, edges)
}

pub fn reeb_node_count(rg : ReebGraph) -> Int {
  @reeb_graph.reeb_node_count(rg)
}

pub fn reeb_edge_count(rg : ReebGraph) -> Int {
  @reeb_graph.reeb_edge_count(rg)
}

// ---------------------------------------------------------------------------
// morse_complex: Morse complex / Morse 复形
// ---------------------------------------------------------------------------

///|
/// Morse cell. / Morse 单元。
pub type MorseCell = @morse_complex.MorseCell

///|
/// Morse complex. / Morse 复形。
pub type MorseComplex = @morse_complex.MorseComplex

pub fn morse_cell_new(
  critical_idx : Int,
  dimension : Int,
  simplices : Array[Int],
) -> MorseCell {
  @morse_complex.MorseCell::new(critical_idx, dimension, simplices)
}

pub fn morse_cell_simplex_count(mc : MorseCell) -> Int {
  @morse_complex.MorseCell::simplex_count(mc)
}

pub fn morse_complex_new() -> MorseComplex {
  @morse_complex.MorseComplex::new()
}

pub fn morse_complex_critical_count(mc : MorseComplex) -> Int {
  @morse_complex.MorseComplex::critical_count(mc)
}

pub fn morse_complex(values : Array[Double], edges : Array[(Int, Int)]) -> MorseComplex {
  @morse_complex.morse_complex(values, edges)
}

pub fn stable_manifold(mc : MorseComplex, critical_idx : Int) -> MorseCell {
  @morse_complex.stable_manifold(mc, critical_idx)
}

pub fn unstable_manifold(mc : MorseComplex, critical_idx : Int) -> MorseCell {
  @morse_complex.unstable_manifold(mc, critical_idx)
}

pub fn critical_point_count(mc : MorseComplex) -> Int {
  @morse_complex.critical_point_count(mc)
}
// ---------------------------------------------------------------------------
// rrt: Rapidly-exploring Random Trees / 快速探索随机树
// ---------------------------------------------------------------------------

///|
/// RRT node. / RRT 节点。
pub type RRTNode = @rrt.RRTNode

///|
/// RRT configuration. / RRT 配置。
pub type RRTConfig = @rrt.RRTConfig

///|
/// RRT result. / RRT 结果。
pub type RRTResult = @rrt.RRTResult

///|
/// Construct an RRT node. / 构造 RRT 节点。
pub fn rrt_node_new(point : Point2D, parent : Int) -> RRTNode {
  @rrt.RRTNode::new(point, parent)
}

///|
/// Construct RRT configuration. / 构造 RRT 配置。
pub fn rrt_config_new(
  step_size : Double,
  max_iterations : Int,
  goal_bias : Double,
  goal_radius : Double,
  seed : UInt,
  x_min : Double,
  x_max : Double,
  y_min : Double,
  y_max : Double,
) -> RRTConfig {
  @rrt.RRTConfig::new(step_size, max_iterations, goal_bias, goal_radius, seed, x_min, x_max, y_min, y_max)
}

///|
/// Plan a path using basic RRT. / 使用基本 RRT 规划路径。
pub fn rrt_plan(
  config : RRTConfig,
  start : Point2D,
  goal : Point2D,
  obstacles : Array[Array[Point2D]],
) -> RRTResult {
  @rrt.rrt_plan(config, start, goal, obstacles)
}

///|
/// Plan a path using RRT*. / 使用 RRT* 规划路径。
pub fn rrt_star_plan(
  config : RRTConfig,
  start : Point2D,
  goal : Point2D,
  obstacles : Array[Array[Point2D]],
) -> RRTResult {
  @rrt.rrt_star_plan(config, start, goal, obstacles)
}

///|
/// Plan a path using bidirectional RRT. / 使用双向 RRT 规划路径。
pub fn rrt_connect_plan(
  config : RRTConfig,
  start : Point2D,
  goal : Point2D,
  obstacles : Array[Array[Point2D]],
) -> RRTResult {
  @rrt.rrt_connect_plan(config, start, goal, obstacles)
}

///|
/// Compute the total length of an RRT path. / 计算 RRT 路径总长度。
pub fn rrt_path_length(path : Array[Point2D]) -> Double {
  @rrt.rrt_path_length(path)
}

///|
/// Count nodes in an RRT tree. / 统计 RRT 树中节点数。
pub fn rrt_node_count(nodes : Array[RRTNode]) -> Int {
  @rrt.rrt_node_count(nodes)
}

// ---------------------------------------------------------------------------
// prm: Probabilistic Roadmap / 概率路线图
// ---------------------------------------------------------------------------

///|
/// PRM configuration. / PRM 配置。
pub type PRMConfig = @prm.PRMConfig

///|
/// PRM roadmap. / PRM 路线图。
pub type PRMRoadmap = @prm.PRMRoadmap

///|
/// PRM result. / PRM 结果。
pub type PRMResult = @prm.PRMResult

///|
/// Construct PRM configuration. / 构造 PRM 配置。
pub fn prm_config_new(
  num_samples : Int,
  connection_radius : Double,
  seed : UInt,
  x_min : Double,
  x_max : Double,
  y_min : Double,
  y_max : Double,
) -> PRMConfig {
  @prm.PRMConfig::new(num_samples, connection_radius, seed, x_min, x_max, y_min, y_max)
}

///|
/// Build a PRM roadmap. / 构建 PRM 路线图。
pub fn prm_build(
  config : PRMConfig,
  obstacles : Array[Array[Point2D]],
) -> PRMRoadmap {
  @prm.prm_build(config, obstacles)
}

///|
/// Query shortest path on a PRM roadmap. / 在 PRM 路线图上查询最短路径。
pub fn prm_query(
  roadmap : PRMRoadmap,
  start : Point2D,
  goal : Point2D,
  obstacles : Array[Array[Point2D]],
) -> PRMResult {
  @prm.prm_query(roadmap, start, goal, obstacles)
}

///|
/// Count nodes in a PRM roadmap. / 统计 PRM 路线图节点数。
pub fn prm_node_count(roadmap : PRMRoadmap) -> Int {
  @prm.prm_node_count(roadmap)
}

///|
/// Count edges in a PRM roadmap. / 统计 PRM 路线图边数。
pub fn prm_edge_count(roadmap : PRMRoadmap) -> Int {
  @prm.prm_edge_count(roadmap)
}

// ---------------------------------------------------------------------------
// a_star: A* path planning / A* 路径规划
// ---------------------------------------------------------------------------

///|
/// A* grid. / A* 网格。
pub type AStarGrid = @a_star.AStarGrid

///|
/// A* result. / A* 结果。
pub type AStarResult = @a_star.AStarResult

///|
/// A* heuristic type. / A* 启发式类型。
pub type AStarHeuristic = @a_star.AStarHeuristic

///|
/// A* graph node. / A* 图节点。
pub type AStarGraphNode = @a_star.AStarGraphNode

///|
/// Construct an A* grid. / 构造 A* 网格。
pub fn astar_grid_new(width : Int, height : Int) -> AStarGrid {
  @a_star.AStarGrid::new(width, height)
}

///|
/// Mark a cell as blocked. / 标记格子为障碍。
pub fn astar_grid_set_blocked(grid : AStarGrid, x : Int, y : Int) -> Unit {
  @a_star.AStarGrid::set_blocked(grid, x, y)
}

///|
/// Check if a cell is blocked. / 检查格子是否为障碍。
pub fn astar_grid_is_blocked(grid : AStarGrid, x : Int, y : Int) -> Bool {
  @a_star.AStarGrid::is_blocked(grid, x, y)
}

///|
/// Construct an A* graph node. / 构造 A* 图节点。
pub fn astar_graph_node_new(id : Int, x : Double, y : Double) -> AStarGraphNode {
  @a_star.AStarGraphNode::new(id, x, y)
}

///|
/// Plan path on a grid using A*. / 使用 A* 在网格上规划路径。
pub fn astar_grid(
  grid : AStarGrid,
  start : (Int, Int),
  goal : (Int, Int),
  heuristic : AStarHeuristic,
  allow_diagonal : Bool,
) -> AStarResult {
  @a_star.astar_grid(grid, start, goal, heuristic, allow_diagonal)
}

///|
/// Plan path on a graph using A*. / 使用 A* 在图上规划路径。
pub fn astar_graph(
  nodes : Array[AStarGraphNode],
  adj : Array[Array[(Int, Double)]],
  start : Int,
  goal : Int,
) -> AStarResult {
  @a_star.astar_graph(nodes, adj, start, goal)
}

///|
/// Compute path cost on a grid. / 计算网格路径代价。
pub fn astar_path_cost(path : Array[(Int, Int)]) -> Double {
  @a_star.astar_path_cost(path)
}

// ---------------------------------------------------------------------------
// dubins: Dubins curves / Dubins 曲线
// ---------------------------------------------------------------------------

///|
/// Dubins path segment type. / Dubins 路径段类型。
pub type DubinsSegmentType = @dubins.DubinsSegmentType

///|
/// Dubins path segment. / Dubins 路径段。
pub type DubinsSegment = @dubins.DubinsSegment

///|
/// Dubins path. / Dubins 路径。
pub type DubinsPath = @dubins.DubinsPath

///|
/// Dubins pose. / Dubins 位姿。
pub type DubinsPose = @dubins.DubinsPose

///|
/// Construct a Dubins pose. / 构造 Dubins 位姿。
pub fn dubins_pose_new(x : Double, y : Double, theta : Double) -> DubinsPose {
  @dubins.DubinsPose::new(x, y, theta)
}

///|
/// Compute the shortest Dubins path. / 计算最短 Dubins 路径。
pub fn dubins_shortest_path(
  start : DubinsPose,
  goal : DubinsPose,
  radius : Double,
) -> DubinsPath {
  @dubins.dubins_shortest_path(start, goal, radius)
}

///|
/// Sample points along a Dubins path. / 沿 Dubins 路径采样点。
pub fn dubins_sample(
  path : DubinsPath,
  start : DubinsPose,
  num_samples : Int,
) -> Array[Point2D] {
  @dubins.dubins_sample(path, start, num_samples)
}

///|
/// Get the total length of a Dubins path. / 获取 Dubins 路径总长度。
pub fn dubins_path_length(path : DubinsPath) -> Double {
  @dubins.dubins_path_length(path)
}

///|
/// Count segments in a Dubins path. / 统计 Dubins 路径段数。
pub fn dubins_segment_count(path : DubinsPath) -> Int {
  @dubins.dubins_segment_count(path)
}

// ---------------------------------------------------------------------------
// reed_shepp: Reeds-Shepp curves / Reeds-Shepp 曲线
// ---------------------------------------------------------------------------

///|
/// Reeds-Shepp path segment type. / Reeds-Shepp 路径段类型。
pub type RSSegmentType = @reed_shepp.RSSegmentType

///|
/// Reeds-Shepp path segment. / Reeds-Shepp 路径段。
pub type RSSegment = @reed_shepp.RSSegment

///|
/// Reeds-Shepp path. / Reeds-Shepp 路径。
pub type RSPath = @reed_shepp.RSPath

///|
/// Reeds-Shepp pose. / Reeds-Shepp 位姿。
pub type RSPose = @reed_shepp.RSPose

///|
/// Construct a Reeds-Shepp pose. / 构造 Reeds-Shepp 位姿。
pub fn rs_pose_new(x : Double, y : Double, theta : Double) -> RSPose {
  @reed_shepp.RSPose::new(x, y, theta)
}

///|
/// Compute the shortest Reeds-Shepp path. / 计算最短 Reeds-Shepp 路径。
pub fn reed_shepp_shortest_path(
  start : RSPose,
  goal : RSPose,
  radius : Double,
) -> RSPath {
  @reed_shepp.reed_shepp_shortest_path(start, goal, radius)
}

///|
/// Sample points along a Reeds-Shepp path. / 沿 Reeds-Shepp 路径采样点。
pub fn reed_shepp_sample(
  path : RSPath,
  start : RSPose,
  num_samples : Int,
) -> Array[Point2D] {
  @reed_shepp.reed_shepp_sample(path, start, num_samples)
}

///|
/// Get the total length of a Reeds-Shepp path. / 获取 Reeds-Shepp 路径总长度。
pub fn reed_shepp_path_length(path : RSPath) -> Double {
  @reed_shepp.reed_shepp_path_length(path)
}

///|
/// Count segments in a Reeds-Shepp path. / 统计 Reeds-Shepp 路径段数。
pub fn reed_shepp_segment_count(path : RSPath) -> Int {
  @reed_shepp.reed_shepp_segment_count(path)
}

///|
/// Check if a Reeds-Shepp path contains backward motion. / 检查 Reeds-Shepp 路径是否包含后退运动。
pub fn reed_shepp_has_backward(path : RSPath) -> Bool {
  @reed_shepp.reed_shepp_has_backward(path)
}

// ---------------------------------------------------------------------------
// collision_detect: Collision detection / 碰撞检测
// ---------------------------------------------------------------------------

///|
/// AABB. / 轴对齐包围盒。
pub type AABB = @collision_detect.AABB

///|
/// Collision pair. / 碰撞对。
pub type CollisionPair = @collision_detect.CollisionPair

///|
/// Construct an AABB. / 构造 AABB。
pub fn aabb_new(min_x : Double, min_y : Double, max_x : Double, max_y : Double) -> AABB {
  @collision_detect.AABB::new(min_x, min_y, max_x, max_y)
}

///|
/// Construct an AABB from center and half-extents. / 从中心和半边长构造 AABB。
pub fn aabb_from_center(cx : Double, cy : Double, hx : Double, hy : Double) -> AABB {
  @collision_detect.AABB::from_center(cx, cy, hx, hy)
}

///|
/// Check if two AABBs overlap. / 检查两个 AABB 是否重叠。
pub fn aabb_overlap(a : AABB, b : AABB) -> Bool {
  @collision_detect.aabb_overlap(a, b)
}

///|
/// Check if a point is inside an AABB. / 检查点是否在 AABB 内。
pub fn aabb_contains(box : AABB, x : Double, y : Double) -> Bool {
  @collision_detect.aabb_contains(box, x, y)
}

///|
/// Compute the AABB of a polygon. / 计算多边形的 AABB。
pub fn aabb_from_polygon(poly : Array[Point2D]) -> AABB {
  @collision_detect.aabb_from_polygon(poly)
}

///|
/// Broad phase collision detection. / 宽相碰撞检测。
pub fn broad_phase_aabb(boxes : Array[AABB]) -> Array[CollisionPair] {
  @collision_detect.broad_phase_aabb(boxes)
}

///|
/// Segment-segment collision. / 线段-线段碰撞。
pub fn segment_segment_collide(
  a1 : Point2D,
  a2 : Point2D,
  b1 : Point2D,
  b2 : Point2D,
) -> Bool {
  @collision_detect.segment_segment_collide(a1, a2, b1, b2)
}

///|
/// Point in polygon test. / 点在多边形内测试。
pub fn point_in_polygon_arr(p : Point2D, poly : Array[Point2D]) -> Bool {
  @collision_detect.point_in_polygon(p, poly)
}

///|
/// Circle-circle collision. / 圆-圆碰撞。
pub fn circle_circle_collide(
  c1 : Point2D,
  r1 : Double,
  c2 : Point2D,
  r2 : Double,
) -> Bool {
  @collision_detect.circle_circle_collide(c1, r1, c2, r2)
}

///|
/// Segment-polygon collision. / 线段-多边形碰撞。
pub fn segment_polygon_collide(
  a : Point2D,
  b : Point2D,
  poly : Array[Point2D],
) -> Bool {
  @collision_detect.segment_polygon_collide(a, b, poly)
}

///|
/// Polygon-polygon collision. / 多边形-多边形碰撞。
pub fn polygon_polygon_collide(
  poly1 : Array[Point2D],
  poly2 : Array[Point2D],
) -> Bool {
  @collision_detect.polygon_polygon_collide(poly1, poly2)
}

///|
/// Circle-polygon collision. / 圆-多边形碰撞。
pub fn circle_polygon_collide(
  center : Point2D,
  radius : Double,
  poly : Array[Point2D],
) -> Bool {
  @collision_detect.circle_polygon_collide(center, radius, poly)
}

///|
/// AABB-polygon collision. / AABB-多边形碰撞。
pub fn aabb_polygon_collide(box : AABB, poly : Array[Point2D]) -> Bool {
  @collision_detect.aabb_polygon_collide(box, poly)
}

///|
/// Compute AABB intersection. / 计算 AABB 交集。
pub fn aabb_intersection(a : AABB, b : AABB) -> AABB? {
  @collision_detect.aabb_intersection(a, b)
}

///|
/// Compute AABB union. / 计算 AABB 并集。
pub fn aabb_union(a : AABB, b : AABB) -> AABB {
  @collision_detect.aabb_union(a, b)
}

///|
/// Compute AABB area. / 计算 AABB 面积。
pub fn aabb_area(box : AABB) -> Double {
  @collision_detect.aabb_area(box)
}

// ---------------------------------------------------------------------------
// gjk: GJK collision detection / GJK 碰撞检测
// ---------------------------------------------------------------------------

///|
/// GJK result. / GJK 结果。
pub type GJKResult = @gjk.GJKResult

///|
/// Polygon support function. / 多边形支撑函数。
pub fn polygon_support(poly : Array[Point2D], dx : Double, dy : Double) -> Point2D {
  @gjk.polygon_support(poly, dx, dy)
}

///|
/// Circle support function. / 圆支撑函数。
pub fn circle_support(center : Point2D, radius : Double, dx : Double, dy : Double) -> Point2D {
  @gjk.circle_support(center, radius, dx, dy)
}

///|
/// Check collision between two convex polygons using GJK. / 使用 GJK 检测两凸多边形碰撞。
pub fn gjk_collide_polygons(
  poly1 : Array[Point2D],
  poly2 : Array[Point2D],
) -> GJKResult {
  @gjk.gjk_collide_polygons(poly1, poly2)
}

///|
/// Check collision between two circles using GJK. / 使用 GJK 检测两圆碰撞。
pub fn gjk_collide_circles(
  c1 : Point2D,
  r1 : Double,
  c2 : Point2D,
  r2 : Double,
) -> GJKResult {
  @gjk.gjk_collide_circles(c1, r1, c2, r2)
}

///|
/// Check collision between a polygon and a circle using GJK. / 使用 GJK 检测多边形与圆碰撞。
pub fn gjk_collide_polygon_circle(
  poly : Array[Point2D],
  center : Point2D,
  radius : Double,
) -> GJKResult {
  @gjk.gjk_collide_polygon_circle(poly, center, radius)
}

///|
/// Check if a point is inside a convex polygon using GJK. / 使用 GJK 检测点是否在凸多边形内。
pub fn gjk_point_in_polygon(p : Point2D, poly : Array[Point2D]) -> GJKResult {
  @gjk.gjk_point_in_polygon(p, poly)
}

// ---------------------------------------------------------------------------
// sat: SAT collision detection / SAT 碰撞检测
// ---------------------------------------------------------------------------

///|
/// SAT collision result. / SAT 碰撞结果。
pub type SATResult = @sat.SATResult

///|
/// Check collision between two convex polygons using SAT. / 使用 SAT 检测两凸多边形碰撞。
pub fn sat_collide_polygons(
  poly1 : Array[Point2D],
  poly2 : Array[Point2D],
) -> SATResult {
  @sat.sat_collide_polygons(poly1, poly2)
}

///|
/// Check if a convex polygon contains a point using SAT. / 使用 SAT 检测凸多边形是否包含点。
pub fn sat_contains_point(poly : Array[Point2D], p : Point2D) -> Bool {
  @sat.sat_contains_point(poly, p)
}

///|
/// Check collision between two circles using SAT. / 使用 SAT 检测两圆碰撞。
pub fn sat_collide_circles(
  c1 : Point2D,
  r1 : Double,
  c2 : Point2D,
  r2 : Double,
) -> SATResult {
  @sat.sat_collide_circles(c1, r1, c2, r2)
}

///|
/// Check collision between a polygon and a circle using SAT. / 使用 SAT 检测多边形与圆碰撞。
pub fn sat_collide_polygon_circle(
  poly : Array[Point2D],
  center : Point2D,
  radius : Double,
) -> SATResult {
  @sat.sat_collide_polygon_circle(poly, center, radius)
}

///|
/// Get the minimum translation vector. / 获取最小平移向量。
pub fn sat_mtv(result : SATResult) -> Point2D {
  @sat.sat_mtv(result)
}

///|
/// Get the separating axis direction. / 获取分离轴方向。
pub fn sat_separating_axis(result : SATResult) -> Point2D {
  @sat.sat_separating_axis(result)
}

// ---------------------------------------------------------------------------
// config_space: Configuration space / 配置空间
// ---------------------------------------------------------------------------

///|
/// C-space obstacle. / 配置空间障碍物。
pub type CSpaceObstacle = @config_space.CSpaceObstacle

///|
/// Construct a C-space obstacle. / 构造配置空间障碍物。
pub fn cspace_obstacle_new(vertices : Array[Point2D]) -> CSpaceObstacle {
  @config_space.CSpaceObstacle::new(vertices)
}

///|
/// Expand a polygonal obstacle by a circular robot radius. / 用圆形机器人半径膨胀多边形障碍物。
pub fn cspace_expand_circle(
  obstacle : Array[Point2D],
  radius : Double,
  num_arc_samples : Int,
) -> CSpaceObstacle {
  @config_space.cspace_expand_circle(obstacle, radius, num_arc_samples)
}

///|
/// Expand a polygonal obstacle by a polygonal robot. / 用多边形机器人膨胀多边形障碍物。
pub fn cspace_expand_polygon(
  obstacle : Array[Point2D],
  robot : Array[Point2D],
) -> CSpaceObstacle {
  @config_space.cspace_expand_polygon(obstacle, robot)
}

///|
/// Check if a configuration point is valid. / 检查配置点是否有效。
pub fn cspace_point_valid(
  q : Point2D,
  cspace_obstacles : Array[CSpaceObstacle],
) -> Bool {
  @config_space.cspace_point_valid(q, cspace_obstacles)
}

///|
/// Check if a configuration space segment is valid. / 检查配置空间线段是否有效。
pub fn cspace_segment_valid(
  q1 : Point2D,
  q2 : Point2D,
  cspace_obstacles : Array[CSpaceObstacle],
) -> Bool {
  @config_space.cspace_segment_valid(q1, q2, cspace_obstacles)
}

///|
/// Build C-space obstacles. / 构建配置空间障碍物。
pub fn cspace_build(
  obstacles : Array[Array[Point2D]],
  robot_radius : Double,
  num_arc_samples : Int,
) -> Array[CSpaceObstacle] {
  @config_space.cspace_build(obstacles, robot_radius, num_arc_samples)
}

// ---------------------------------------------------------------------------
// path_smooth: Path smoothing / 路径平滑
// ---------------------------------------------------------------------------

///|
/// Smoothing configuration. / 平滑配置。
pub type SmoothConfig = @path_smooth.SmoothConfig

///|
/// Construct smoothing configuration. / 构造平滑配置。
pub fn smooth_config_new(
  num_samples : Int,
  tension : Double,
  preserve_endpoints : Bool,
) -> SmoothConfig {
  @path_smooth.SmoothConfig::new(num_samples, tension, preserve_endpoints)
}

///|
/// Smooth a path using Catmull-Rom spline. / 使用 Catmull-Rom 样条平滑路径。
pub fn smooth_path(path : Array[Point2D], config : SmoothConfig) -> Array[Point2D] {
  @path_smooth.smooth_path(path, config)
}

///|
/// Smooth a path using uniform cubic B-spline. / 使用均匀三次 B 样条平滑路径。
pub fn bspline_smooth(path : Array[Point2D], num_samples : Int) -> Array[Point2D] {
  @path_smooth.bspline_smooth(path, num_samples)
}

///|
/// Smooth a path while preserving specified keypoint indices. / 平滑路径同时保留指定关键点索引。
pub fn smooth_preserve_keypoints(
  path : Array[Point2D],
  keypoints : Array[Int],
  num_samples : Int,
) -> Array[Point2D] {
  @path_smooth.smooth_preserve_keypoints(path, keypoints, num_samples)
}

///|
/// Compute the total length of a path. / 计算路径总长度。
pub fn path_smooth_length(path : Array[Point2D]) -> Double {
  @path_smooth.path_length(path)
}

///|
/// Reduce path to key points. / 将路径简化为关键点。
pub fn simplify_path(path : Array[Point2D], eps : Double) -> Array[Point2D] {
  @path_smooth.simplify_path(path, eps)
}

///|
/// Compute the maximum deviation between original and smoothed path. / 计算原始路径与平滑路径间的最大偏差。
pub fn path_max_deviation(
  original : Array[Point2D],
  smoothed : Array[Point2D],
) -> Double {
  @path_smooth.path_max_deviation(original, smoothed)
}
// ---------------------------------------------------------------------------
// conic_section: Conic sections / 圆锥曲线
// ---------------------------------------------------------------------------

///|
/// Conic section type. / 圆锥曲线类型。
pub type ConicType = @conic_section.ConicType

///|
/// Conic section. / 圆锥曲线。
pub type Conic = @conic_section.Conic

pub fn conic_new(a : Double, b : Double, c : Double, d : Double, e : Double, f : Double) -> Conic {
  @conic_section.Conic::new(a, b, c, d, e, f)
}

pub fn conic_eval(conic : Conic, p : Point2D) -> Double {
  @conic_section.Conic::eval(conic, p)
}

pub fn conic_on_curve(conic : Conic, p : Point2D, eps : Double) -> Bool {
  @conic_section.Conic::on_curve(conic, p, eps)
}

pub fn conic_discriminant(conic : Conic) -> Double {
  @conic_section.Conic::discriminant(conic)
}

pub fn conic_classify(conic : Conic) -> ConicType {
  @conic_section.Conic::classify(conic)
}

pub fn conic_center(conic : Conic) -> Point2D? {
  @conic_section.Conic::center(conic)
}

pub fn conic_tangent_at(conic : Conic, p : Point2D) -> (Double, Double, Double) {
  @conic_section.Conic::tangent_at(conic, p)
}

pub fn conic_asymptotes(conic : Conic) -> ((Double, Double, Double), (Double, Double, Double))? {
  @conic_section.Conic::asymptotes(conic)
}

pub fn conic_eccentricity(conic : Conic) -> Double? {
  @conic_section.Conic::eccentricity(conic)
}

pub fn conic_axis_aligned(conic : Conic) -> (Conic, Double) {
  @conic_section.Conic::axis_aligned(conic)
}

// ---------------------------------------------------------------------------
// quadric_surface: Quadric surfaces / 二次曲面
// ---------------------------------------------------------------------------

///|
/// Quadric surface type. / 二次曲面类型。
pub type QuadricType = @quadric_surface.QuadricType

///|
/// Quadric surface. / 二次曲面。
pub type Quadric = @quadric_surface.Quadric

pub fn quadric_new(
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double,
  g : Double,
  h : Double,
  i : Double,
  j : Double,
) -> Quadric {
  @quadric_surface.Quadric::new(a, b, c, d, e, f, g, h, i, j)
}

pub fn quadric_eval(q : Quadric, p : Point3D) -> Double {
  @quadric_surface.Quadric::eval(q, p)
}

pub fn quadric_on_surface(q : Quadric, p : Point3D, eps : Double) -> Bool {
  @quadric_surface.Quadric::on_surface(q, p, eps)
}

pub fn quadric_gradient(q : Quadric, p : Point3D) -> Point3D {
  @quadric_surface.Quadric::gradient(q, p)
}

pub fn quadric_normal(q : Quadric, p : Point3D) -> Point3D {
  @quadric_surface.Quadric::normal(q, p)
}

pub fn quadric_center(q : Quadric) -> Point3D? {
  @quadric_surface.Quadric::center(q)
}

pub fn quadric_classify(q : Quadric) -> QuadricType {
  @quadric_surface.Quadric::classify(q)
}

// ---------------------------------------------------------------------------
// resultant: Resultant computation / 结式计算
// ---------------------------------------------------------------------------

pub fn sylvester_matrix(p : Array[Double], q : Array[Double]) -> Array[Array[Double]] {
  @resultant.sylvester_matrix(p, q)
}

pub fn matrix_determinant(mat : Array[Array[Double]]) -> Double {
  @resultant.matrix_determinant(mat)
}

pub fn resultant(p : Array[Double], q : Array[Double]) -> Double {
  @resultant.resultant(p, q)
}

pub fn discriminant(coeffs : Array[Double]) -> Double {
  @resultant.discriminant(coeffs)
}

pub fn poly_degree(coeffs : Array[Double]) -> Int {
  @resultant.poly_degree(coeffs)
}

pub fn poly_sub(a : Array[Double], b : Array[Double]) -> Array[Double] {
  @resultant.poly_sub(a, b)
}

pub fn poly_gcd(a : Array[Double], b : Array[Double]) -> Array[Double] {
  @resultant.poly_gcd(a, b)
}

pub fn have_common_root(p : Array[Double], q : Array[Double], eps : Double) -> Bool {
  @resultant.have_common_root(p, q, eps)
}

// ---------------------------------------------------------------------------
// bezier_clipping: Bezier clipping / 贝塞尔裁剪
// ---------------------------------------------------------------------------

///|
/// Cubic Bezier for clipping. / 裁剪用三次贝塞尔曲线。
pub type BezierClip = @bezier_clipping.BezierClip

pub fn bezier_clip_new(p0 : Point2D, p1 : Point2D, p2 : Point2D, p3 : Point2D) -> BezierClip {
  @bezier_clipping.BezierClip::new(p0, p1, p2, p3)
}

pub fn bezier_clip_eval(b : BezierClip, t : Double) -> Point2D {
  @bezier_clipping.BezierClip::eval(b, t)
}

pub fn bezier_clip_derivative(b : BezierClip, t : Double) -> Point2D {
  @bezier_clipping.BezierClip::derivative(b, t)
}

pub fn bezier_clip_bbox(b : BezierClip) -> (Double, Double, Double, Double) {
  @bezier_clipping.BezierClip::bbox(b)
}

pub fn bezier_clip_subdivide(b : BezierClip, t : Double) -> (BezierClip, BezierClip) {
  @bezier_clipping.BezierClip::subdivide(b, t)
}

pub fn bezier_clip_intersect(
  b1 : BezierClip,
  b2 : BezierClip,
  eps : Double,
  max_depth : Int,
) -> Array[(Double, Double, Point2D)] {
  @bezier_clipping.bezier_clip_intersect(b1, b2, eps, max_depth)
}

pub fn bezier_clip_length(b : BezierClip) -> Double {
  @bezier_clipping.BezierClip::length(b)
}

// ---------------------------------------------------------------------------
// implicit_curve: Implicit curve tracing / 隐式曲线追踪
// ---------------------------------------------------------------------------

pub fn trace_curve(
  f : (Double, Double) -> Double,
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  seed : Point2D,
  step : Double,
  n_steps : Int,
) -> Array[Point2D] {
  @implicit_curve.trace_curve(f, fx, fy, seed, step, n_steps)
}

pub fn newton_correct(
  f : (Double, Double) -> Double,
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : Point2D,
  max_iter : Int,
) -> Point2D {
  @implicit_curve.newton_correct(f, fx, fy, p, max_iter)
}

pub fn implicit_curve_tangent(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : Point2D,
) -> Point2D {
  @implicit_curve.tangent(fx, fy, p)
}

pub fn implicit_curve_normal(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : Point2D,
) -> Point2D {
  @implicit_curve.normal(fx, fy, p)
}

pub fn implicit_curve_curvature(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  fxx : (Double, Double) -> Double,
  fxy : (Double, Double) -> Double,
  fyy : (Double, Double) -> Double,
  p : Point2D,
) -> Double {
  @implicit_curve.curvature(fx, fy, fxx, fxy, fyy, p)
}

pub fn find_seed(
  f : (Double, Double) -> Double,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  n_samples : Int,
) -> Point2D? {
  @implicit_curve.find_seed(f, x_lo, x_hi, y_lo, y_hi, n_samples)
}

// ---------------------------------------------------------------------------
// implicit_surface: Implicit surface / 隐式曲面
// ---------------------------------------------------------------------------

pub fn implicit_surface_normal(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  p : Point3D,
) -> Point3D {
  @implicit_surface.surface_normal(fx, fy, fz, p)
}

pub fn surface_gradient(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  p : Point3D,
) -> Point3D {
  @implicit_surface.surface_gradient(fx, fy, fz, p)
}

pub fn implicit_gaussian_curvature(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  fxx : (Double, Double, Double) -> Double,
  fxy : (Double, Double, Double) -> Double,
  fxz : (Double, Double, Double) -> Double,
  fyy : (Double, Double, Double) -> Double,
  fyz : (Double, Double, Double) -> Double,
  fzz : (Double, Double, Double) -> Double,
  p : Point3D,
) -> Double {
  @implicit_surface.gaussian_curvature(fx, fy, fz, fxx, fxy, fxz, fyy, fyz, fzz, p)
}

pub fn implicit_mean_curvature(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  fxx : (Double, Double, Double) -> Double,
  fyy : (Double, Double, Double) -> Double,
  fzz : (Double, Double, Double) -> Double,
  p : Point3D,
) -> Double {
  @implicit_surface.mean_curvature(fx, fy, fz, fxx, fyy, fzz, p)
}

pub fn principal_curvatures(k_gauss : Double, k_mean : Double) -> (Double, Double) {
  @implicit_surface.principal_curvatures(k_gauss, k_mean)
}

pub fn project_to_surface(
  f : (Double, Double, Double) -> Double,
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  p : Point3D,
  max_iter : Int,
) -> Point3D {
  @implicit_surface.project_to_surface(f, fx, fy, fz, p, max_iter)
}

pub fn tangent_plane(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  p : Point3D,
) -> (Double, Double, Double, Double) {
  @implicit_surface.tangent_plane(fx, fy, fz, p)
}

// ---------------------------------------------------------------------------
// ifs: Iterated Function Systems / 迭代函数系统
// ---------------------------------------------------------------------------

///|
/// Affine map. / 仿射映射。
pub type AffineMap = @ifs.AffineMap

///|
/// IFS. / 迭代函数系统。
pub type IFS = @ifs.IFS

pub fn affine_map_new(a : Double, b : Double, e : Double, c : Double, d : Double, f : Double) -> AffineMap {
  @ifs.AffineMap::new(a, b, e, c, d, f)
}

pub fn affine_map_apply(m : AffineMap, p : Point2D) -> Point2D {
  @ifs.AffineMap::apply(m, p)
}

pub fn affine_map_contraction_factor(m : AffineMap) -> Double {
  @ifs.AffineMap::contraction_factor(m)
}

pub fn affine_map_is_contraction(m : AffineMap) -> Bool {
  @ifs.AffineMap::is_contraction(m)
}

pub fn affine_map_fixed_point(m : AffineMap) -> Point2D? {
  @ifs.AffineMap::fixed_point(m)
}

pub fn ifs_new(maps : Array[AffineMap]) -> IFS {
  @ifs.IFS::new(maps)
}

pub fn ifs_size(ifs : IFS) -> Int {
  @ifs.IFS::size(ifs)
}

pub fn ifs_max_contraction(ifs : IFS) -> Double {
  @ifs.IFS::max_contraction(ifs)
}

pub fn ifs_is_contractive(ifs : IFS) -> Bool {
  @ifs.IFS::is_contractive(ifs)
}

pub fn chaos_game(
  ifs : IFS,
  seed : Point2D,
  n_iter : Int,
  skip : Int,
  rng : (Int) -> Int,
) -> Array[Point2D] {
  @ifs.chaos_game(ifs, seed, n_iter, skip, rng)
}

pub fn ifs_iterate(ifs : IFS, points : Array[Point2D]) -> Array[Point2D] {
  @ifs.ifs_iterate(ifs, points)
}

pub fn ifs_attractor(ifs : IFS, seed : Point2D, n_steps : Int) -> Array[Point2D] {
  @ifs.ifs_attractor(ifs, seed, n_steps)
}

// ---------------------------------------------------------------------------
// l_system: L-systems / L 系统
// ---------------------------------------------------------------------------

///|
/// L-system rule. / L 系统规则。
pub type LRule = @l_system.LRule

///|
/// L-system. / L 系统。
pub type LSystem = @l_system.LSystem

pub fn lrule_new(symbol : String, replacement : String) -> LRule {
  @l_system.LRule::new(symbol, replacement)
}

pub fn lsystem_new(axiom : String, rules : Array[LRule]) -> LSystem {
  @l_system.LSystem::new(axiom, rules)
}

pub fn lsystem_step(system : LSystem, current : String) -> String {
  @l_system.lsystem_step(system, current)
}

pub fn lsystem_iterate(system : LSystem, n : Int) -> String {
  @l_system.lsystem_iterate(system, n)
}

pub fn turtle_interpret(s : String, angle : Double, step : Double) -> Array[Point2D] {
  @l_system.turtle_interpret(s, angle, step)
}

pub fn koch_snowflake(n_iter : Int, side : Double) -> Array[Point2D] {
  @l_system.koch_snowflake(n_iter, side)
}

pub fn sierpinski_arrowhead(n_iter : Int, step : Double) -> Array[Point2D] {
  @l_system.sierpinski_arrowhead(n_iter, step)
}

pub fn fractal_plant(n_iter : Int, step : Double) -> Array[Point2D] {
  @l_system.fractal_plant(n_iter, step)
}

pub fn dragon_curve(n_iter : Int, step : Double) -> Array[Point2D] {
  @l_system.dragon_curve(n_iter, step)
}

pub fn count_segments(s : String) -> Int {
  @l_system.count_segments(s)
}

// ---------------------------------------------------------------------------
// fractal_dimension: Fractal dimension / 分形维数
// ---------------------------------------------------------------------------

pub fn box_counting_dimension(points : Array[Point2D], scales : Array[Double]) -> Double {
  @fractal_dimension.box_counting_dimension(points, scales)
}

pub fn correlation_dimension(points : Array[Point2D], radii : Array[Double]) -> Double {
  @fractal_dimension.correlation_dimension(points, radii)
}

pub fn linear_fit_slope(xs : Array[Double], ys : Array[Double]) -> Double {
  @fractal_dimension.linear_fit_slope(xs, ys)
}

pub fn information_dimension(points : Array[Point2D], scales : Array[Double]) -> Double {
  @fractal_dimension.information_dimension(points, scales)
}

pub fn box_count(points : Array[Point2D], eps : Double) -> Int {
  @fractal_dimension.box_count(points, eps)
}

pub fn geometric_scales(eps_min : Double, eps_max : Double, n : Int) -> Array[Double] {
  @fractal_dimension.geometric_scales(eps_min, eps_max, n)
}

// ---------------------------------------------------------------------------
// hausdorff_dimension: Hausdorff dimension / Hausdorff 维数
// ---------------------------------------------------------------------------

pub fn self_similar_dimension(n : Int, r : Double) -> Double {
  @hausdorff_dimension.self_similar_dimension(n, r)
}

pub fn moran_dimension(ratios : Array[Double]) -> Double {
  @hausdorff_dimension.moran_dimension(ratios)
}

pub fn cantor_set_dimension() -> Double {
  @hausdorff_dimension.cantor_set_dimension()
}

pub fn sierpinski_triangle_dimension() -> Double {
  @hausdorff_dimension.sierpinski_triangle_dimension()
}

pub fn sierpinski_carpet_dimension() -> Double {
  @hausdorff_dimension.sierpinski_carpet_dimension()
}

pub fn koch_curve_dimension() -> Double {
  @hausdorff_dimension.koch_curve_dimension()
}

pub fn menger_sponge_dimension() -> Double {
  @hausdorff_dimension.menger_sponge_dimension()
}

pub fn verify_moran(ratios : Array[Double], d : Double) -> Double {
  @hausdorff_dimension.verify_moran(ratios, d)
}

pub fn self_affine_dimension(n : Int, rx : Double, ry : Double) -> Double {
  @hausdorff_dimension.self_affine_dimension(n, rx, ry)
}

pub fn estimate_from_points(
  points : Array[Point2D],
  eps_min : Double,
  eps_max : Double,
  n_scales : Int,
) -> Double {
  @hausdorff_dimension.estimate_from_points(points, eps_min, eps_max, n_scales)
}
// ---------------------------------------------------------------------------
// gis_projection: Map projections / 地图投影
// ---------------------------------------------------------------------------

///|
/// Projected coordinate pair. / 投影坐标对。
pub type ProjXY = @gis_projection.ProjXY

pub fn proj_xy_new(x : Double, y : Double) -> ProjXY {
  @gis_projection.ProjXY::new(x, y)
}

pub fn mercator_forward(lat : Double, lon : Double) -> ProjXY {
  @gis_projection.mercator_forward(lat, lon)
}

pub fn mercator_inverse(x : Double, y : Double) -> (Double, Double) {
  @gis_projection.mercator_inverse(x, y)
}

pub fn web_mercator_forward(lat : Double, lon : Double) -> ProjXY {
  @gis_projection.web_mercator_forward(lat, lon)
}

pub fn web_mercator_inverse(x : Double, y : Double) -> (Double, Double) {
  @gis_projection.web_mercator_inverse(x, y)
}

pub fn utm_zone_from_lon(lon : Double) -> Int {
  @gis_projection.utm_zone_from_lon(lon)
}

pub fn utm_central_meridian(zone : Int) -> Double {
  @gis_projection.utm_central_meridian(zone)
}

pub fn utm_forward(lat : Double, lon : Double) -> ProjXY {
  @gis_projection.utm_forward(lat, lon)
}

pub fn utm_forward_zone(lat : Double, lon : Double, zone : Int) -> ProjXY {
  @gis_projection.utm_forward_zone(lat, lon, zone)
}

pub fn lambert_conformal_forward(
  lat : Double,
  lon : Double,
  lat1 : Double,
  lat2 : Double,
  lat0 : Double,
  lon0 : Double,
) -> ProjXY {
  @gis_projection.lambert_conformal_forward(lat, lon, lat1, lat2, lat0, lon0)
}

pub fn albers_equal_area_forward(
  lat : Double,
  lon : Double,
  lat1 : Double,
  lat2 : Double,
  lat0 : Double,
  lon0 : Double,
) -> ProjXY {
  @gis_projection.albers_equal_area_forward(lat, lon, lat1, lat2, lat0, lon0)
}

pub fn mercator_scale(lat : Double) -> Double {
  @gis_projection.mercator_scale(lat)
}

// ---------------------------------------------------------------------------
// geodesic: Geodesic distance / 测地距离
// ---------------------------------------------------------------------------

pub fn haversine_distance(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  @geodesic.haversine_distance(lat1, lon1, lat2, lon2)
}

pub fn spherical_distance(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  @geodesic.spherical_distance(lat1, lon1, lat2, lon2)
}

pub fn initial_bearing(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  @geodesic.initial_bearing(lat1, lon1, lat2, lon2)
}

pub fn destination_point(
  lat1 : Double,
  lon1 : Double,
  bearing : Double,
  distance : Double,
) -> (Double, Double) {
  @geodesic.destination_point(lat1, lon1, bearing, distance)
}

pub fn vincenty_distance(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Double {
  @geodesic.vincenty_distance(lat1, lon1, lat2, lon2)
}

pub fn is_antipodal(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Bool {
  @geodesic.is_antipodal(lat1, lon1, lat2, lon2)
}

// ---------------------------------------------------------------------------
// gis_buffer: Buffer operations / 缓冲操作
// ---------------------------------------------------------------------------

pub fn point_buffer(center : Point2D, radius : Double, n : Int) -> Polygon {
  @gis_buffer.point_buffer(center, radius, n)
}

pub fn segment_buffer(
  a : Point2D,
  b : Point2D,
  radius : Double,
  cap_segments : Int,
) -> Polygon {
  @gis_buffer.segment_buffer(a, b, radius, cap_segments)
}

pub fn polyline_buffer(
  points : Array[Point2D],
  radius : Double,
  cap_segments : Int,
) -> Polygon {
  @gis_buffer.polyline_buffer(points, radius, cap_segments)
}

pub fn gis_minkowski_sum_convex(poly_a : Polygon, poly_b : Polygon) -> Polygon {
  @gis_buffer.minkowski_sum_convex(poly_a, poly_b)
}

pub fn convex_polygon_buffer(poly : Polygon, radius : Double, n : Int) -> Polygon {
  @gis_buffer.convex_polygon_buffer(poly, radius, n)
}

pub fn polygon_offset_buffer(poly : Polygon, radius : Double) -> Polygon {
  @gis_buffer.polygon_offset_buffer(poly, radius)
}

// ---------------------------------------------------------------------------
// tin: Triangulated Irregular Network / 不规则三角网
// ---------------------------------------------------------------------------

///|
/// TIN (Triangulated Irregular Network). / 不规则三角网。
pub type TIN = @tin.TIN

pub fn build_tin(points : Array[Point3D]) -> TIN {
  @tin.build_tin(points)
}

pub fn tin_point_count(t : TIN) -> Int {
  @tin.TIN::point_count(t)
}

pub fn tin_triangle_count(t : TIN) -> Int {
  @tin.TIN::triangle_count(t)
}

pub fn tin_interpolate(t : TIN, p : Point2D) -> Double? {
  @tin.TIN::interpolate(t, p)
}

pub fn tin_volume(t : TIN) -> Double {
  @tin.TIN::volume(t)
}

pub fn tin_slope_at(t : TIN, p : Point2D) -> Double? {
  @tin.TIN::slope_at(t, p)
}

pub fn tin_aspect_at(t : TIN, p : Point2D) -> Double? {
  @tin.TIN::aspect_at(t, p)
}

pub fn tin_elevation_range(t : TIN) -> (Double, Double) {
  @tin.TIN::elevation_range(t)
}

// ---------------------------------------------------------------------------
// coordinate_convert: Coordinate conversion / 坐标转换
// ---------------------------------------------------------------------------

///|
/// ECEF coordinate. / 地心地固坐标。
pub type ECEF = @coordinate_convert.ECEF

///|
/// Geodetic coordinate. / 大地坐标。
pub type Geodetic = @coordinate_convert.Geodetic

pub fn ecef_new(x : Double, y : Double, z : Double) -> ECEF {
  @coordinate_convert.ECEF::new(x, y, z)
}

pub fn geodetic_new(lat : Double, lon : Double, h : Double) -> Geodetic {
  @coordinate_convert.Geodetic::new(lat, lon, h)
}

pub fn wgs84_to_ecef(g : Geodetic) -> ECEF {
  @coordinate_convert.wgs84_to_ecef(g)
}

pub fn ecef_to_wgs84(e : ECEF) -> Geodetic {
  @coordinate_convert.ecef_to_wgs84(e)
}

pub fn cgcs2000_to_ecef(g : Geodetic) -> ECEF {
  @coordinate_convert.cgcs2000_to_ecef(g)
}

pub fn ecef_to_cgcs2000(e : ECEF) -> Geodetic {
  @coordinate_convert.ecef_to_cgcs2000(e)
}

pub fn wgs84_to_cgcs2000(g : Geodetic) -> Geodetic {
  @coordinate_convert.wgs84_to_cgcs2000(g)
}

pub fn cgcs2000_to_wgs84(g : Geodetic) -> Geodetic {
  @coordinate_convert.cgcs2000_to_wgs84(g)
}

pub fn ecef_distance(e1 : ECEF, e2 : ECEF) -> Double {
  @coordinate_convert.ecef_distance(e1, e2)
}

// ---------------------------------------------------------------------------
// datum_transform: Datum transformation / 基准转换
// ---------------------------------------------------------------------------

///|
/// 7-parameter Helmert transform. / 七参数 Helmert 变换。
pub type Helmert7 = @datum_transform.Helmert7

///|
/// 3-parameter transform. / 三参数变换。
pub type Helmert3 = @datum_transform.Helmert3

pub fn helmert7_new(
  tx : Double,
  ty : Double,
  tz : Double,
  rx : Double,
  ry : Double,
  rz : Double,
  scale : Double,
) -> Helmert7 {
  @datum_transform.Helmert7::new(tx, ty, tz, rx, ry, rz, scale)
}

pub fn helmert3_new(tx : Double, ty : Double, tz : Double) -> Helmert3 {
  @datum_transform.Helmert3::new(tx, ty, tz)
}

pub fn apply_helmert7(h : Helmert7, x : Double, y : Double, z : Double) -> (Double, Double, Double) {
  @datum_transform.apply_helmert7(h, x, y, z)
}

pub fn apply_helmert3(h : Helmert3, x : Double, y : Double, z : Double) -> (Double, Double, Double) {
  @datum_transform.apply_helmert3(h, x, y, z)
}

pub fn inverse_helmert7(h : Helmert7) -> Helmert7 {
  @datum_transform.inverse_helmert7(h)
}

pub fn inverse_helmert3(h : Helmert3) -> Helmert3 {
  @datum_transform.inverse_helmert3(h)
}

pub fn helmert7_identity() -> Helmert7 {
  @datum_transform.helmert7_identity()
}

pub fn compose_helmert7(a : Helmert7, b : Helmert7) -> Helmert7 {
  @datum_transform.compose_helmert7(a, b)
}

// ---------------------------------------------------------------------------
// raster_ops: Raster operations / 栅格操作
// ---------------------------------------------------------------------------

///|
/// Raster grid. / 栅格网格。
pub type Raster = @raster_ops.Raster

pub fn raster_new(cols : Int, rows : Int, fill : Double, nodata : Double) -> Raster {
  @raster_ops.Raster::new(cols, rows, fill, nodata)
}

pub fn raster_from_data(
  cols : Int,
  rows : Int,
  data : Array[Double],
  nodata : Double,
) -> Raster {
  @raster_ops.Raster::from_data(cols, rows, data, nodata)
}

pub fn raster_get(r : Raster, col : Int, row : Int) -> Double {
  @raster_ops.Raster::get(r, col, row)
}

pub fn raster_set(r : Raster, col : Int, row : Int, val : Double) -> Unit {
  @raster_ops.Raster::set(r, col, row, val)
}

pub fn raster_cols(r : Raster) -> Int {
  @raster_ops.Raster::cols(r)
}

pub fn raster_rows(r : Raster) -> Int {
  @raster_ops.Raster::rows(r)
}

pub fn resample_nearest(r : Raster, new_cols : Int, new_rows : Int) -> Raster {
  @raster_ops.resample_nearest(r, new_cols, new_rows)
}

pub fn resample_bilinear(r : Raster, new_cols : Int, new_rows : Int) -> Raster {
  @raster_ops.resample_bilinear(r, new_cols, new_rows)
}

pub fn raster_mosaic(r1 : Raster, r2 : Raster) -> Raster {
  @raster_ops.mosaic(r1, r2)
}

pub fn raster_add(r1 : Raster, r2 : Raster) -> Raster {
  @raster_ops.raster_add(r1, r2)
}

pub fn raster_subtract(r1 : Raster, r2 : Raster) -> Raster {
  @raster_ops.raster_subtract(r1, r2)
}

pub fn raster_multiply(r1 : Raster, r2 : Raster) -> Raster {
  @raster_ops.raster_multiply(r1, r2)
}

pub fn raster_add_scalar(r : Raster, c : Double) -> Raster {
  @raster_ops.raster_add_scalar(r, c)
}

pub fn raster_min(r : Raster) -> Double {
  @raster_ops.raster_min(r)
}

pub fn raster_max(r : Raster) -> Double {
  @raster_ops.raster_max(r)
}

// ---------------------------------------------------------------------------
// contour_line: Contour line extraction / 等值线提取
// ---------------------------------------------------------------------------

///|
/// Contour line segment. / 等值线段。
pub type ContourSegment = @contour_line.ContourSegment

///|
/// Contour grid. / 等值线栅格。
pub type ContourGrid = @contour_line.ContourGrid

pub fn contour_segment_new(
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
) -> ContourSegment {
  @contour_line.ContourSegment::new(x1, y1, x2, y2)
}

pub fn contour_grid_new(
  cols : Int,
  rows : Int,
  data : Array[Double],
  cell_size : Double,
  x_origin : Double,
  y_origin : Double,
) -> ContourGrid {
  @contour_line.ContourGrid::new(cols, rows, data, cell_size, x_origin, y_origin)
}

pub fn marching_squares(g : ContourGrid, level : Double) -> Array[ContourSegment] {
  @contour_line.marching_squares(g, level)
}

pub fn extract_contours(
  g : ContourGrid,
  levels : Array[Double],
) -> Array[(Double, Array[ContourSegment])] {
  @contour_line.extract_contours(g, levels)
}

pub fn label_cell(g : ContourGrid, col : Int, row : Int, level : Double) -> Int {
  @contour_line.label_cell(g, col, row, level)
}

pub fn count_contour_segments(g : ContourGrid, level : Double) -> Int {
  @contour_line.count_contour_segments(g, level)
}

// ---------------------------------------------------------------------------
// watershed: Watershed algorithm / 分水岭算法
// ---------------------------------------------------------------------------

///|
/// Watershed result. / 分水岭结果。
pub type WatershedResult = @watershed.WatershedResult

pub fn marker_watershed(
  cols : Int,
  rows : Int,
  dem : Array[Double],
  markers : Array[Int],
) -> WatershedResult {
  @watershed.marker_watershed(cols, rows, dem, markers)
}

pub fn d8_flow_directions(
  cols : Int,
  rows : Int,
  dem : Array[Double],
) -> Array[Int] {
  @watershed.d8_flow_directions(cols, rows, dem)
}

pub fn basin_cell_counts(r : WatershedResult) -> Array[(Int, Int)] {
  @watershed.basin_cell_counts(r)
}

pub fn fill_depressions(
  cols : Int,
  rows : Int,
  dem : Array[Double],
) -> Array[Double] {
  @watershed.fill_depressions(cols, rows, dem)
}

pub fn watershed_result_cols(r : WatershedResult) -> Int {
  @watershed.WatershedResult::cols(r)
}

pub fn watershed_result_rows(r : WatershedResult) -> Int {
  @watershed.WatershedResult::rows(r)
}

pub fn watershed_result_get(r : WatershedResult, col : Int, row : Int) -> Int {
  @watershed.WatershedResult::get(r, col, row)
}

// ---------------------------------------------------------------------------
// delaunay_terrain: Terrain Delaunay / 地形 Delaunay
// ---------------------------------------------------------------------------

///|
/// Terrain from Delaunay triangulation. / Delaunay 三角剖分地形。
pub type Terrain = @delaunay_terrain.Terrain

pub fn build_terrain(points : Array[Point3D]) -> Terrain {
  @delaunay_terrain.build_terrain(points)
}

pub fn build_constrained_terrain(
  points : Array[Point3D],
  constraints : Array[(Int, Int)],
) -> Terrain {
  @delaunay_terrain.build_constrained_terrain(points, constraints)
}

pub fn terrain_point_count(t : Terrain) -> Int {
  @delaunay_terrain.Terrain::point_count(t)
}

pub fn terrain_triangle_count(t : Terrain) -> Int {
  @delaunay_terrain.Terrain::triangle_count(t)
}

pub fn terrain_average_slope(t : Terrain) -> Double {
  @delaunay_terrain.Terrain::average_slope(t)
}

pub fn terrain_aspect_at(t : Terrain, p : Point2D) -> Double? {
  @delaunay_terrain.Terrain::aspect_at(t, p)
}

pub fn terrain_slope_at(t : Terrain, p : Point2D) -> Double? {
  @delaunay_terrain.Terrain::slope_at(t, p)
}

pub fn terrain_surface_area(t : Terrain) -> Double {
  @delaunay_terrain.Terrain::surface_area(t)
}

pub fn terrain_constraint_count(t : Terrain) -> Int {
  @delaunay_terrain.Terrain::constraint_count(t)
}

// ---------------------------------------------------------------------------
// Phase 4: Shape Analysis & Descriptors / 形状分析与描述子
// ---------------------------------------------------------------------------

///|
/// === Phase 4: Shape Analysis & Descriptors ===

// --- shape_context ---

pub fn shape_context(
  points : Array[Point2D],
  n_r_bins : Int,
  n_theta_bins : Int,
) -> Array[Array[Double]] {
  @shape_context.shape_context(points, n_r_bins, n_theta_bins)
}

pub fn shape_context_distance(
  h1 : Array[Double],
  h2 : Array[Double],
) -> Double {
  @shape_context.shape_context_distance(h1, h2)
}

pub fn shape_context_cost(
  sc1 : Array[Array[Double]],
  sc2 : Array[Array[Double]],
) -> Array[Array[Double]] {
  @shape_context.shape_context_cost(sc1, sc2)
}

pub fn shape_context_match(
  source : Array[Point2D],
  target : Array[Point2D],
  n_r_bins : Int,
  n_theta_bins : Int,
) -> Array[Int] {
  @shape_context.shape_context_match(source, target, n_r_bins, n_theta_bins)
}

// --- fourier_descriptor ---

pub fn fourier_descriptors(points : Array[Point2D]) -> Array[(Double, Double)] {
  @fourier_descriptor.fourier_descriptors(points)
}

pub fn fourier_invariant(points : Array[Point2D]) -> Array[Double] {
  @fourier_descriptor.fourier_invariant(points)
}

pub fn fourier_reconstruct(
  coeffs : Array[(Double, Double)],
  n : Int,
) -> Array[Point2D] {
  @fourier_descriptor.fourier_reconstruct(coeffs, n)
}

pub fn fourier_truncate(
  coeffs : Array[(Double, Double)],
  k : Int,
) -> Array[(Double, Double)] {
  @fourier_descriptor.fourier_truncate(coeffs, k)
}

// --- moment_invariants ---

pub fn raw_moment(points : Array[Point2D], p : Int, q : Int) -> Double {
  @moment_invariants.raw_moment(points, p, q)
}

pub fn moment_centroid(points : Array[Point2D]) -> (Point2D, Double) {
  @moment_invariants.centroid(points)
}

pub fn central_moment(points : Array[Point2D], p : Int, q : Int) -> Double {
  @moment_invariants.central_moment(points, p, q)
}

pub fn normalized_moment(points : Array[Point2D], p : Int, q : Int) -> Double {
  @moment_invariants.normalized_moment(points, p, q)
}

pub fn hu_moments(points : Array[Point2D]) -> Array[Double] {
  @moment_invariants.hu_moments(points)
}

pub fn zernike_moment(
  points : Array[Point2D],
  n : Int,
  m : Int,
) -> (Double, Double) {
  @moment_invariants.zernike_moment(points, n, m)
}

pub fn zernike_magnitude(points : Array[Point2D], n : Int, m : Int) -> Double {
  @moment_invariants.zernike_magnitude(points, n, m)
}

// --- skeleton_3d ---

pub fn voxel_index(x : Int, y : Int, z : Int, nx : Int, ny : Int) -> Int {
  @skeleton_3d.voxel_index(x, y, z, nx, ny)
}

pub fn count_6_neighbors(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  @skeleton_3d.count_6_neighbors(voxels, x, y, z, nx, ny, nz)
}

pub fn count_26_neighbors(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  @skeleton_3d.count_26_neighbors(voxels, x, y, z, nx, ny, nz)
}

pub fn is_boundary_voxel(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Bool {
  @skeleton_3d.is_boundary(voxels, x, y, z, nx, ny, nz)
}

pub fn skeleton_3d(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Array[Bool] {
  @skeleton_3d.skeleton_3d(voxels, nx, ny, nz)
}

pub fn skeleton_volume(voxels : Array[Bool]) -> Int {
  @skeleton_3d.skeleton_volume(voxels)
}

pub fn skeleton_endpoints(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  @skeleton_3d.skeleton_endpoints(voxels, nx, ny, nz)
}

pub fn skeleton_field(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Array[Bool] {
  @skeleton_3d.skeleton_field(voxels, nx, ny, nz)
}

// --- medial_axis_3d ---

///|
/// Medial ball in 3D. / 三维中轴球。
pub type MedialBall3D = @medial_axis_3d.MedialBall3D

pub fn medial_ball_3d_new(center : Point3D, radius : Double) -> MedialBall3D {
  @medial_axis_3d.MedialBall3D::new(center, radius)
}

pub fn medial_ball_3d_center(ball : MedialBall3D) -> Point3D {
  @medial_axis_3d.MedialBall3D::center(ball)
}

pub fn medial_ball_3d_radius(ball : MedialBall3D) -> Double {
  @medial_axis_3d.MedialBall3D::radius(ball)
}

pub fn medial_axis_from_pairs(points : Array[Point3D]) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_from_pairs(points)
}

pub fn medial_axis_from_triples(points : Array[Point3D]) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_from_triples(points)
}

pub fn medial_axis_3d(points : Array[Point3D]) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_3d(points)
}

pub fn medial_axis_filter(
  balls : Array[MedialBall3D],
  r_min : Double,
  r_max : Double,
) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_filter(balls, r_min, r_max)
}

pub fn medial_axis_sort(balls : Array[MedialBall3D]) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_sort(balls)
}

// --- shape_matching ---

pub fn hungarian(cost : Array[Array[Double]]) -> Array[Int] {
  @shape_matching.hungarian(cost)
}

pub fn shape_matching_icp(
  source : Array[Point2D],
  target : Array[Point2D],
  max_iter : Int,
) -> Array[Int] {
  @shape_matching.shape_matching_icp(source, target, max_iter)
}

pub fn shape_matching_hungarian(
  source : Array[Point2D],
  target : Array[Point2D],
) -> Array[Int] {
  @shape_matching.shape_matching_hungarian(source, target)
}

pub fn shape_matching_score(
  source : Array[Point2D],
  target : Array[Point2D],
) -> Double {
  @shape_matching.shape_matching_score(source, target)
}

// --- curvature_scale ---

pub fn gaussian_smooth(points : Array[Point2D], sigma : Double) -> Array[Point2D] {
  @curvature_scale.gaussian_smooth(points, sigma)
}

pub fn css_curvature(points : Array[Point2D], sigma : Double) -> Array[Double] {
  @curvature_scale.css_curvature(points, sigma)
}

pub fn css_inflection_points(
  points : Array[Point2D],
  sigma : Double,
) -> Array[Int] {
  @curvature_scale.css_inflection_points(points, sigma)
}

pub fn css_image(
  points : Array[Point2D],
  n_sigmas : Int,
) -> Array[(Double, Int)] {
  @curvature_scale.css_image(points, n_sigmas)
}

pub fn css_maxima(points : Array[Point2D], n_sigmas : Int) -> Array[Double] {
  @curvature_scale.css_maxima(points, n_sigmas)
}

// --- bend_energy ---

pub fn bend_energy(points : Array[Point2D]) -> Double {
  @bend_energy.bend_energy(points)
}

pub fn bend_energy_open(points : Array[Point2D]) -> Double {
  @bend_energy.bend_energy_open(points)
}

pub fn total_curvature_energy(points : Array[Point2D]) -> Double {
  @bend_energy.total_curvature_energy(points)
}

pub fn elastic_energy(points : Array[Point2D], tension : Double) -> Double {
  @bend_energy.elastic_energy(points, tension)
}

pub fn curve_length(points : Array[Point2D]) -> Double {
  @bend_energy.curve_length(points)
}

pub fn normalized_bend_energy(points : Array[Point2D]) -> Double {
  @bend_energy.normalized_bend_energy(points)
}

// --- procrustes ---

///|
/// Procrustes alignment result. / Procrustes 对齐结果。
pub type ProcrustesResult = @procrustes.ProcrustesResult

pub fn procrustes_result_new(
  rotation : Double,
  tx : Double,
  ty : Double,
  scale : Double,
  error : Double,
) -> ProcrustesResult {
  @procrustes.ProcrustesResult::new(rotation, tx, ty, scale, error)
}

pub fn procrustes_result_rotation(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::rotation(r)
}

pub fn procrustes_result_tx(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::tx(r)
}

pub fn procrustes_result_ty(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::ty(r)
}

pub fn procrustes_result_scale(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::scale(r)
}

pub fn procrustes_result_error(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::error(r)
}

pub fn procrustes(src : Array[Point2D], tgt : Array[Point2D]) -> ProcrustesResult {
  @procrustes.procrustes(src, tgt)
}

pub fn procrustes_apply(
  src : Array[Point2D],
  result : ProcrustesResult,
) -> Array[Point2D] {
  @procrustes.procrustes_apply(src, result)
}

pub fn procrustes_error(src : Array[Point2D], tgt : Array[Point2D]) -> Double {
  @procrustes.procrustes_error(src, tgt)
}

pub fn procrustes_analyze(
  shapes : Array[Array[Point2D]],
  max_iter : Int,
) -> Array[Array[Point2D]] {
  @procrustes.procrustes_analyze(shapes, max_iter)
}

// --- icp ---

///|
/// ICP registration result. / ICP 配准结果。
pub type IcpResult = @icp.IcpResult

pub fn icp_result_new(
  rotation : Array[Double],
  translation : Point3D,
  error : Double,
  iterations : Int,
) -> IcpResult {
  @icp.IcpResult::new(rotation, translation, error, iterations)
}

pub fn icp_result_rotation(r : IcpResult) -> Array[Double] {
  @icp.IcpResult::rotation(r)
}

pub fn icp_result_translation(r : IcpResult) -> Point3D {
  @icp.IcpResult::translation(r)
}

pub fn icp_result_error(r : IcpResult) -> Double {
  @icp.IcpResult::error(r)
}

pub fn icp_result_iterations(r : IcpResult) -> Int {
  @icp.IcpResult::iterations(r)
}

pub fn icp_point_to_point(
  source : Array[Point3D],
  target : Array[Point3D],
  max_iter : Int,
) -> IcpResult {
  @icp.icp_point_to_point(source, target, max_iter)
}

pub fn icp_point_to_plane(
  source : Array[Point3D],
  target : Array[Point3D],
  normals : Array[Point3D],
  max_iter : Int,
) -> IcpResult {
  @icp.icp_point_to_plane(source, target, normals, max_iter)
}

pub fn icp_apply(points : Array[Point3D], result : IcpResult) -> Array[Point3D] {
  @icp.icp_apply(points, result)
}

pub fn icp_rms_error(
  source : Array[Point3D],
  target : Array[Point3D],
) -> Double {
  @icp.icp_rms_error(source, target)
}
// ---------------------------------------------------------------------------
// quadratic_prog: Quadratic programming / 二次规划
// ---------------------------------------------------------------------------
///|
pub type QPResult = @quadratic_prog.QPResult
///|
pub fn qp_result_new(x : Array[Double], value : Double, success : Bool) -> QPResult {
  @quadratic_prog.QPResult::new(x, value, success)
}
///|
pub fn qp_solve_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int,
) -> Array[Double]? {
  @quadratic_prog.solve_linear(a, b, n)
}
///|
pub fn solve_unconstrained_qp(
  q : Array[Array[Double]],
  c : Array[Double],
  n : Int,
) -> Array[Double]? {
  @quadratic_prog.solve_unconstrained_qp(q, c, n)
}
///|
pub fn active_set_qp(
  q : Array[Array[Double]],
  c : Array[Double],
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int,
  max_iter : Int,
) -> QPResult {
  @quadratic_prog.active_set_qp(q, c, a, b, n, max_iter)
}
///|
pub fn qp_2d_box(
  q11 : Double,
  q12 : Double,
  q22 : Double,
  c1 : Double,
  c2 : Double,
  lo1 : Double,
  hi1 : Double,
  lo2 : Double,
  hi2 : Double,
) -> Point2D {
  @quadratic_prog.qp_2d_box(q11, q12, q22, c1, c2, lo1, hi1, lo2, hi2)
}
///|
pub fn qp_objective(
  q : Array[Array[Double]],
  c : Array[Double],
  x : Array[Double],
  n : Int,
) -> Double {
  @quadratic_prog.qp_objective(q, c, x, n)
}

// ---------------------------------------------------------------------------
// gradient_descent: Gradient descent / 梯度下降
// ---------------------------------------------------------------------------
///|
pub fn gradient_descent(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.gradient_descent(grad, x0, lr, max_iter)
}
///|
pub fn momentum_gd(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  momentum : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.momentum_gd(grad, x0, lr, momentum, max_iter)
}
///|
pub fn nesterov_gd(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  momentum : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.nesterov_gd(grad, x0, lr, momentum, max_iter)
}
///|
pub fn adam(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  beta1 : Double,
  beta2 : Double,
  eps : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.adam(grad, x0, lr, beta1, beta2, eps, max_iter)
}
///|
pub fn gd_2d(
  grad : (Double, Double) -> (Double, Double),
  x0 : Double,
  y0 : Double,
  lr : Double,
  max_iter : Int,
) -> Point2D {
  @gradient_descent.gd_2d(grad, x0, y0, lr, max_iter)
}
///|
pub fn rmsprop(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  decay : Double,
  eps : Double,
  max_iter : Int,
) -> Array[Double] {
  @gradient_descent.rmsprop(grad, x0, lr, decay, eps, max_iter)
}

// ---------------------------------------------------------------------------
// newton_method: Newton's method / 牛顿法
// ---------------------------------------------------------------------------
///|
pub fn newton_1d(
  f : (Double) -> Double,
  fp : (Double) -> Double,
  x0 : Double,
  tol : Double,
  max_iter : Int,
) -> Double {
  @newton_method.newton_1d(f, fp, x0, tol, max_iter)
}
///|
pub fn newton_multi(
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  tol : Double,
  max_iter : Int,
) -> Array[Double] {
  @newton_method.newton_multi(grad, hess, x0, tol, max_iter)
}
///|
pub fn newton_line_search(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_iter : Int,
) -> Array[Double] {
  @newton_method.newton_line_search(f, grad, hess, x0, max_iter)
}
///|
pub fn newton_trust_region(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_delta : Double,
  max_iter : Int,
) -> Array[Double] {
  @newton_method.newton_trust_region(f, grad, hess, x0, max_delta, max_iter)
}
///|
pub fn newton_2d(
  grad : (Double, Double) -> (Double, Double),
  hess : (Double, Double) -> ((Double, Double), (Double, Double)),
  x0 : Double,
  y0 : Double,
  max_iter : Int,
) -> Point2D {
  @newton_method.newton_2d(grad, hess, x0, y0, max_iter)
}

// ---------------------------------------------------------------------------
// levenberg_marquardt: Levenberg-Marquardt / 非线性最小二乘
// ---------------------------------------------------------------------------
///|
pub type LMResult = @levenberg_marquardt.LMResult
///|
pub fn lm_result_new(
  x : Array[Double],
  residual : Double,
  iterations : Int,
  success : Bool,
) -> LMResult {
  @levenberg_marquardt.LMResult::new(x, residual, iterations, success)
}
///|
pub fn levenberg_marquardt(
  residual : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> LMResult {
  @levenberg_marquardt.levenberg_marquardt(residual, x0, max_iter)
}
///|
pub fn levenberg_marquardt_jac(
  residual : (Array[Double]) -> Array[Double],
  jacobian : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_iter : Int,
) -> LMResult {
  @levenberg_marquardt.levenberg_marquardt_jac(residual, jacobian, x0, max_iter)
}
///|
pub fn lm_line_fit(xs : Array[Double], ys : Array[Double]) -> (Double, Double) {
  @levenberg_marquardt.lm_line_fit(xs, ys)
}
///|
pub fn lm_rms_error(residual_sq : Double, n : Int) -> Double {
  @levenberg_marquardt.lm_rms_error(residual_sq, n)
}
///|
pub fn lm_log_residual(residual_sq : Double) -> Double {
  @levenberg_marquardt.lm_log_residual(residual_sq)
}

// ---------------------------------------------------------------------------
// conjugate_gradient: Conjugate gradient / 共轭梯度
// ---------------------------------------------------------------------------
///|
pub fn cg_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> Array[Double] {
  @conjugate_gradient.cg_linear(a, b, x0, max_iter)
}
///|
pub fn pcg_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  m_inv : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> Array[Double] {
  @conjugate_gradient.pcg_linear(a, b, m_inv, x0, max_iter)
}
///|
pub fn nonlinear_cg(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> Array[Double] {
  @conjugate_gradient.nonlinear_cg(f, grad, x0, max_iter)
}
///|
pub fn nonlinear_cg_2d(
  f : (Double, Double) -> Double,
  grad : (Double, Double) -> (Double, Double),
  x0 : Double,
  y0 : Double,
  max_iter : Int,
) -> Point2D {
  @conjugate_gradient.nonlinear_cg_2d(f, grad, x0, y0, max_iter)
}
///|
pub fn jacobi_preconditioner(
  a : Array[Array[Double]],
  n : Int,
) -> (Array[Double]) -> Array[Double] {
  @conjugate_gradient.jacobi_preconditioner(a, n)
}

// ---------------------------------------------------------------------------
// simplex_method: Simplex method / 单纯形法
// ---------------------------------------------------------------------------
///|
pub type SimplexResult = @simplex_method.SimplexResult
///|
pub fn simplex_result_new(
  x : Array[Double],
  value : Double,
  success : Bool,
) -> SimplexResult {
  @simplex_method.SimplexResult::new(x, value, success)
}
///|
pub fn simplex(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> SimplexResult {
  @simplex_method.simplex(a, b, c, max_iter)
}
///|
pub fn simplex_max(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> SimplexResult {
  @simplex_method.simplex_max(a, b, c, max_iter)
}

// ---------------------------------------------------------------------------
// interior_point: Interior point method / 内点法
// ---------------------------------------------------------------------------
///|
pub type IPResult = @interior_point.IPResult
///|
pub fn ip_result_new(x : Array[Double], value : Double, success : Bool) -> IPResult {
  @interior_point.IPResult::new(x, value, success)
}
///|
pub fn interior_point(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> IPResult {
  @interior_point.interior_point(a, b, c, max_iter)
}
///|
pub fn interior_point_max(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> IPResult {
  @interior_point.interior_point_max(a, b, c, max_iter)
}
///|
pub fn duality_gap(x : Array[Double], s : Array[Double], n : Int) -> Double {
  @interior_point.duality_gap(x, s, n)
}

// ---------------------------------------------------------------------------
// simulated_annealing: Simulated annealing / 模拟退火
// ---------------------------------------------------------------------------
///|
pub type CoolingSchedule = @simulated_annealing.CoolingSchedule
///|
pub type SAResult = @simulated_annealing.SAResult
///|
pub type SA_rng = @simulated_annealing.SA_rng
///|
pub fn sa_rng_new(seed : UInt) -> SA_rng {
  @simulated_annealing.SA_rng::new(seed)
}
///|
pub fn sa_rng_next(r : SA_rng) -> Double {
  @simulated_annealing.SA_rng::next(r)
}
///|
pub fn simulated_annealing(
  f : (Array[Double]) -> Double,
  x0 : Array[Double],
  neighbor : (Array[Double], SA_rng) -> Array[Double],
  t0 : Double,
  schedule : CoolingSchedule,
  min_temp : Double,
  max_iter : Int,
  seed : UInt,
) -> SAResult {
  @simulated_annealing.simulated_annealing(f, x0, neighbor, t0, schedule, min_temp, max_iter, seed)
}
///|
pub fn uniform_neighbor(
  x : Array[Double],
  step : Double,
  rng : SA_rng,
) -> Array[Double] {
  @simulated_annealing.uniform_neighbor(x, step, rng)
}
///|
pub fn sa_1d(
  f : (Double) -> Double,
  x0 : Double,
  step : Double,
  t0 : Double,
  cooling_rate : Double,
  max_iter : Int,
  seed : UInt,
) -> Double {
  @simulated_annealing.sa_1d(f, x0, step, t0, cooling_rate, max_iter, seed)
}
///|
pub fn sa_reheat(
  f : (Array[Double]) -> Double,
  x0 : Array[Double],
  neighbor : (Array[Double], SA_rng) -> Array[Double],
  t0 : Double,
  cooling_rate : Double,
  max_iter : Int,
  n_reheats : Int,
  seed : UInt,
) -> SAResult {
  @simulated_annealing.sa_reheat(f, x0, neighbor, t0, cooling_rate, max_iter, n_reheats, seed)
}

// ---------------------------------------------------------------------------
// genetic_algorithm: Genetic algorithm / 遗传算法
// ---------------------------------------------------------------------------
///|
pub type GAConfig = @genetic_algorithm.GAConfig
///|
pub type GAResult = @genetic_algorithm.GAResult
///|
pub fn ga_config_new(
  pop_size : Int,
  n_genes : Int,
  crossover_rate : Double,
  mutation_rate : Double,
  elite_count : Int,
  lo : Array[Double],
  hi : Array[Double],
) -> GAConfig {
  @genetic_algorithm.GAConfig::new(pop_size, n_genes, crossover_rate, mutation_rate, elite_count, lo, hi)
}
///|
pub fn ga_result_new(
  x : Array[Double],
  fitness : Double,
  generations : Int,
) -> GAResult {
  @genetic_algorithm.GAResult::new(x, fitness, generations)
}
///|
pub fn genetic_algorithm(
  fitness : (Array[Double]) -> Double,
  config : GAConfig,
  max_generations : Int,
  seed : UInt,
) -> GAResult {
  @genetic_algorithm.genetic_algorithm(fitness, config, max_generations, seed)
}
///|
pub fn ga_minimize(
  f : (Array[Double]) -> Double,
  config : GAConfig,
  max_generations : Int,
  seed : UInt,
) -> GAResult {
  @genetic_algorithm.ga_minimize(f, config, max_generations, seed)
}
///|
pub fn ga_1d(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  pop_size : Int,
  max_generations : Int,
  seed : UInt,
) -> Double {
  @genetic_algorithm.ga_1d(f, lo, hi, pop_size, max_generations, seed)
}

pub fn ga_population_std(fitness : Array[Double]) -> Double {
  @genetic_algorithm.ga_population_std(fitness)
}

pub fn ga_mutation_schedule(
  initial_rate : Double,
  decay : Double,
  generation : Int,
) -> Double {
  @genetic_algorithm.ga_mutation_schedule(initial_rate, decay, generation)
}

// ---------------------------------------------------------------------------
// pso: Particle swarm optimization / 粒子群优化
// ---------------------------------------------------------------------------
///|
pub type PSOConfig = @pso.PSOConfig
///|
pub type PSOResult = @pso.PSOResult
///|
pub type PSOTopology = @pso.PSOTopology
///|
pub fn pso_config_new(
  n_particles : Int,
  n_dims : Int,
  w : Double,
  c1 : Double,
  c2 : Double,
  lo : Array[Double],
  hi : Array[Double],
  v_max : Double,
) -> PSOConfig {
  @pso.PSOConfig::new(n_particles, n_dims, w, c1, c2, lo, hi, v_max)
}
///|
pub fn pso_result_new(
  x : Array[Double],
  value : Double,
  iterations : Int,
) -> PSOResult {
  @pso.PSOResult::new(x, value, iterations)
}
///|
pub fn pso(
  f : (Array[Double]) -> Double,
  config : PSOConfig,
  topology : PSOTopology,
  max_iter : Int,
  seed : UInt,
) -> PSOResult {
  @pso.pso(f, config, topology, max_iter, seed)
}
///|
pub fn pso_decreasing_w(
  f : (Array[Double]) -> Double,
  config : PSOConfig,
  w_max : Double,
  w_min : Double,
  topology : PSOTopology,
  max_iter : Int,
  seed : UInt,
) -> PSOResult {
  @pso.pso_decreasing_w(f, config, w_max, w_min, topology, max_iter, seed)
}
///|
pub fn pso_1d(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n_particles : Int,
  max_iter : Int,
  seed : UInt,
) -> Double {
  @pso.pso_1d(f, lo, hi, n_particles, max_iter, seed)
}

pub fn pso_swarm_radius(positions : Array[Double]) -> Double {
  @pso.pso_swarm_radius(positions)
}

pub fn pso_inertia_schedule(
  w_max : Double,
  decay : Double,
  iteration : Int,
) -> Double {
  @pso.pso_inertia_schedule(w_max, decay, iteration)
}// ---------------------------------------------------------------------------
// obj_io: OBJ file I/O / OBJ 文件读写
// ---------------------------------------------------------------------------
///|
pub type ObjFaceVertex = @obj_io.ObjFaceVertex
///|
pub type ObjFace = @obj_io.ObjFace
///|
pub type ObjMesh = @obj_io.ObjMesh

pub fn obj_face_vertex_new(v : Int, vt : Int, vn : Int) -> ObjFaceVertex {
  @obj_io.ObjFaceVertex::new(v, vt, vn)
}

pub fn obj_face_new(verts : Array[ObjFaceVertex]) -> ObjFace {
  @obj_io.ObjFace::new(verts)
}

pub fn obj_mesh_new() -> ObjMesh {
  @obj_io.ObjMesh::new()
}

pub fn obj_mesh_vertex_count(m : ObjMesh) -> Int {
  @obj_io.ObjMesh::vertex_count(m)
}

pub fn obj_mesh_face_count(m : ObjMesh) -> Int {
  @obj_io.ObjMesh::face_count(m)
}

pub fn obj_write(mesh : ObjMesh) -> String {
  @obj_io.obj_write(mesh)
}

pub fn obj_parse(text : String) -> ObjMesh {
  @obj_io.obj_parse(text)
}
// ---------------------------------------------------------------------------
// stl_io: STL file I/O / STL 文件读写
// ---------------------------------------------------------------------------
///|
pub type StlTriangle = @stl_io.StlTriangle
///|
pub type StlMesh = @stl_io.StlMesh

pub fn stl_triangle_new(
  normal : Point3D,
  v0 : Point3D,
  v1 : Point3D,
  v2 : Point3D,
) -> StlTriangle {
  @stl_io.StlTriangle::new(normal, v0, v1, v2)
}

pub fn stl_mesh_new(name : String) -> StlMesh {
  @stl_io.StlMesh::new(name)
}

pub fn stl_mesh_triangle_count(m : StlMesh) -> Int {
  @stl_io.StlMesh::triangle_count(m)
}

pub fn stl_write_ascii(mesh : StlMesh) -> String {
  @stl_io.stl_write_ascii(mesh)
}

pub fn stl_parse_ascii(text : String) -> StlMesh {
  @stl_io.stl_parse_ascii(text)
}

pub fn stl_write_binary(mesh : StlMesh) -> Bytes {
  @stl_io.stl_write_binary(mesh)
}

pub fn stl_parse_binary(data : Bytes) -> StlMesh {
  @stl_io.stl_parse_binary(data)
}
// ---------------------------------------------------------------------------
// ply_io: PLY file I/O / PLY 文件读写
// ---------------------------------------------------------------------------
///|
pub type PlyMesh = @ply_io.PlyMesh

pub fn ply_mesh_new() -> PlyMesh {
  @ply_io.PlyMesh::new()
}

pub fn ply_mesh_vertex_count(m : PlyMesh) -> Int {
  @ply_io.PlyMesh::vertex_count(m)
}

pub fn ply_mesh_face_count(m : PlyMesh) -> Int {
  @ply_io.PlyMesh::face_count(m)
}

pub fn ply_write_ascii(mesh : PlyMesh) -> String {
  @ply_io.ply_write_ascii(mesh)
}

pub fn ply_parse_ascii(text : String) -> PlyMesh {
  @ply_io.ply_parse_ascii(text)
}

pub fn ply_write_binary(mesh : PlyMesh) -> Bytes {
  @ply_io.ply_write_binary(mesh)
}

pub fn ply_parse_binary(data : Bytes) -> PlyMesh {
  @ply_io.ply_parse_binary(data)
}
// ---------------------------------------------------------------------------
// gltf_io: glTF file I/O / glTF 文件读写
// ---------------------------------------------------------------------------
///|
pub type GltfMesh = @gltf_io.GltfMesh

pub fn gltf_mesh_new() -> GltfMesh {
  @gltf_io.GltfMesh::new()
}

pub fn gltf_mesh_vertex_count(m : GltfMesh) -> Int {
  @gltf_io.GltfMesh::vertex_count(m)
}

pub fn gltf_mesh_index_count(m : GltfMesh) -> Int {
  @gltf_io.GltfMesh::index_count(m)
}

pub fn gltf_write_json(mesh : GltfMesh) -> String {
  @gltf_io.gltf_write_json(mesh)
}

pub fn gltf_parse_json(text : String) -> GltfMesh {
  @gltf_io.gltf_parse_json(text)
}

pub fn gltf_write_binary(mesh : GltfMesh) -> Bytes {
  @gltf_io.gltf_write_binary(mesh)
}

pub fn gltf_parse_binary(data : Bytes) -> GltfMesh {
  @gltf_io.gltf_parse_binary(data)
}
// ---------------------------------------------------------------------------
// geojson_io: GeoJSON I/O / GeoJSON 读写
// ---------------------------------------------------------------------------
///|
pub type GeoJsonGeometry = @geojson_io.GeoJsonGeometry

pub fn geojson_point(p : Point2D) -> String {
  @geojson_io.geojson_point(p)
}

pub fn geojson_linestring(points : Array[Point2D]) -> String {
  @geojson_io.geojson_linestring(points)
}

pub fn geojson_polygon(rings : Array[Array[Point2D]]) -> String {
  @geojson_io.geojson_polygon(rings)
}

pub fn geojson_multipoint(points : Array[Point2D]) -> String {
  @geojson_io.geojson_multipoint(points)
}

pub fn geojson_multilinestring(lines : Array[Array[Point2D]]) -> String {
  @geojson_io.geojson_multilinestring(lines)
}

pub fn geojson_multipolygon(polygons : Array[Array[Array[Point2D]]]) -> String {
  @geojson_io.geojson_multipolygon(polygons)
}

pub fn geojson_write(geom : GeoJsonGeometry) -> String {
  @geojson_io.geojson_write(geom)
}

pub fn geojson_parse(text : String) -> GeoJsonGeometry? {
  @geojson_io.geojson_parse(text)
}
// ---------------------------------------------------------------------------
// dxf_io: DXF file I/O / DXF 文件读写
// ---------------------------------------------------------------------------
///|
pub type DxfEntity = @dxf_io.DxfEntity
///|
pub type DxfDocument = @dxf_io.DxfDocument

pub fn dxf_document_new() -> DxfDocument {
  @dxf_io.DxfDocument::new()
}

pub fn dxf_document_entity_count(d : DxfDocument) -> Int {
  @dxf_io.DxfDocument::entity_count(d)
}

pub fn dxf_write(doc : DxfDocument) -> String {
  @dxf_io.dxf_write(doc)
}

pub fn dxf_parse(text : String) -> DxfDocument {
  @dxf_io.dxf_parse(text)
}
// ---------------------------------------------------------------------------
// ray_tracing: Ray tracing / 光线追踪
// ---------------------------------------------------------------------------
///|
pub type Ray3 = @ray_tracing.Ray3

pub fn ray3_new(origin : Point3D, dir : Point3D) -> Ray3 {
  @ray_tracing.Ray3::new(origin, dir)
}

pub fn ray3_eval(r : Ray3, t : Double) -> Point3D {
  @ray_tracing.ray_eval(r, t)
}

pub fn ray_triangle_intersect(
  r : Ray3,
  v0 : Point3D,
  v1 : Point3D,
  v2 : Point3D,
) -> Double? {
  @ray_tracing.ray_triangle_intersect(r, v0, v1, v2)
}

pub fn ray_sphere_intersect(
  r : Ray3,
  center : Point3D,
  radius : Double,
) -> Double? {
  @ray_tracing.ray_sphere_intersect(r, center, radius)
}

pub fn ray_plane_intersect(
  r : Ray3,
  point : Point3D,
  normal : Point3D,
) -> Double? {
  @ray_tracing.ray_plane_intersect(r, point, normal)
}

pub fn point_in_shadow(
  point : Point3D,
  light : Point3D,
  triangles : Array[(Point3D, Point3D, Point3D)],
) -> Bool {
  @ray_tracing.point_in_shadow(point, light, triangles)
}

pub fn ray_nearest_triangle(
  r : Ray3,
  triangles : Array[(Point3D, Point3D, Point3D)],
) -> (Double, Int)? {
  @ray_tracing.ray_nearest_triangle(r, triangles)
}
// ---------------------------------------------------------------------------
// marching_cubes: Marching Cubes / 移动立方体
// ---------------------------------------------------------------------------
///|
pub type McGrid = @marching_cubes.McGrid

pub fn mc_grid_new(
  values : Array[Double],
  nx : Int,
  ny : Int,
  nz : Int,
) -> McGrid {
  @marching_cubes.McGrid::new(values, nx, ny, nz)
}

pub fn mc_grid_get(g : McGrid, i : Int, j : Int, k : Int) -> Double {
  @marching_cubes.McGrid::get(g, i, j, k)
}

pub fn marching_cubes(
  grid : McGrid,
  isolevel : Double,
) -> Array[(Point3D, Point3D, Point3D)] {
  @marching_cubes.marching_cubes(grid, isolevel)
}

pub fn marching_cubes_count(grid : McGrid, isolevel : Double) -> Int {
  @marching_cubes.marching_cubes_count(grid, isolevel)
}

pub fn cube_config_class(cube_idx : Int) -> Int {
  @marching_cubes.cube_config_class(cube_idx)
}

pub fn count_active_configs(grid : McGrid, isolevel : Double) -> Int {
  @marching_cubes.count_active_configs(grid, isolevel)
}
// ---------------------------------------------------------------------------
// hidden_line: Hidden line removal / 隐藏线消除
// ---------------------------------------------------------------------------
///|
pub type LineSeg3D = @hidden_line.LineSeg3D

pub fn line_seg_3d_new(start : Point3D, end : Point3D) -> LineSeg3D {
  @hidden_line.LineSeg3D::new(start, end)
}

pub fn project_to_2d(p : Point3D) -> Point2D {
  @hidden_line.project_to_2d(p)
}

pub fn project_segment(s : LineSeg3D) -> (Point2D, Point2D) {
  @hidden_line.project_segment(s)
}

pub fn point_in_triangle_2d(
  p : Point2D,
  a : Point2D,
  b : Point2D,
  c : Point2D,
) -> Bool {
  @hidden_line.point_in_triangle_2d(p, a, b, c)
}

pub fn triangle_z_at(
  tri : (Point3D, Point3D, Point3D),
  x : Double,
  y : Double,
) -> Double? {
  @hidden_line.triangle_z_at(tri, x, y)
}

pub fn hidden_line_remove(
  segments : Array[LineSeg3D],
  triangles : Array[(Point3D, Point3D, Point3D)],
) -> Array[(Point2D, Point2D)] {
  @hidden_line.hidden_line_remove(segments, triangles)
}

pub fn count_visible(
  segments : Array[LineSeg3D],
  triangles : Array[(Point3D, Point3D, Point3D)],
) -> Int {
  @hidden_line.count_visible(segments, triangles)
}

pub fn back_face_cull(
  triangles : Array[(Point3D, Point3D, Point3D)],
  view_dir : Point3D,
) -> Array[(Point3D, Point3D, Point3D)] {
  @hidden_line.back_face_cull(triangles, view_dir)
}
// ---------------------------------------------------------------------------
// rasterization: Rasterization / 光栅化
// ---------------------------------------------------------------------------
///|
pub type RasterBuffer = @rasterization.RasterBuffer

pub fn raster_buffer_new(width : Int, height : Int) -> RasterBuffer {
  @rasterization.RasterBuffer::new(width, height)
}

pub fn clear_buffer(buf : RasterBuffer, color : Int, depth : Double) -> Unit {
  @rasterization.clear_buffer(buf, color, depth)
}

pub fn set_pixel(buf : RasterBuffer, x : Int, y : Int, color : Int) -> Unit {
  @rasterization.set_pixel(buf, x, y, color)
}

pub fn set_pixel_depth(
  buf : RasterBuffer,
  x : Int,
  y : Int,
  color : Int,
  depth : Double,
) -> Unit {
  @rasterization.set_pixel_depth(buf, x, y, color, depth)
}

pub fn get_pixel(buf : RasterBuffer, x : Int, y : Int) -> Int {
  @rasterization.get_pixel(buf, x, y)
}

pub fn get_depth(buf : RasterBuffer, x : Int, y : Int) -> Double {
  @rasterization.get_depth(buf, x, y)
}

pub fn raster_line(
  buf : RasterBuffer,
  x0 : Int,
  y0 : Int,
  x1 : Int,
  y1 : Int,
  color : Int,
) -> Unit {
  @rasterization.raster_line(buf, x0, y0, x1, y1, color)
}

pub fn raster_triangle(
  buf : RasterBuffer,
  v0 : Point3D,
  v1 : Point3D,
  v2 : Point3D,
  color : Int,
) -> Unit {
  @rasterization.raster_triangle(buf, v0, v1, v2, color)
}

pub fn count_filled(buf : RasterBuffer, bg : Int) -> Int {
  @rasterization.count_filled(buf, bg)
}

// ========== point_cloud ==========
pub fn point_cloud_centroid(points : Array[@core.Point3D]) -> @core.Point3D {
  @point_cloud.point_cloud_centroid(points)
}
pub fn point_cloud_aabb(points : Array[@core.Point3D]) -> (@core.Point3D, @core.Point3D) {
  @point_cloud.point_cloud_aabb(points)
}
pub fn voxel_downsample(points : Array[@core.Point3D], voxel_size : Double) -> Array[@core.Point3D] {
  @point_cloud.voxel_downsample(points, voxel_size)
}
pub fn avg_nearest_neighbor_dist(points : Array[@core.Point3D]) -> Double {
  @point_cloud.avg_nearest_neighbor_dist(points)
}
pub fn point_cloud_size(points : Array[@core.Point3D]) -> Int {
  @point_cloud.point_cloud_size(points)
}

// ========== surface_recon ==========
pub fn greedy_triangulation(points : Array[@core.Point3D], max_edge : Double) -> Array[(Int, Int, Int)] {
  @surface_recon.greedy_triangulation(points, max_edge)
}
pub fn estimate_tangent_plane(center : @core.Point3D, neighbors : Array[@core.Point3D]) -> @core.Point3D {
  @surface_recon.estimate_tangent_plane(center, neighbors)
}
pub fn recon_triangle_count(triangles : Array[(Int, Int, Int)]) -> Int {
  @surface_recon.recon_triangle_count(triangles)
}
pub fn recon_completeness(reconstructed : Int, expected : Int) -> Double {
  @surface_recon.recon_completeness(reconstructed, expected)
}

// ========== voxel_grid ==========
pub type VoxelGrid = @voxel_grid.VoxelGrid
pub fn vg_voxel_index(grid : VoxelGrid, p : @core.Point3D) -> Int {
  @voxel_grid.voxel_index(grid, p)
}
pub fn voxel_set(grid : VoxelGrid, p : @core.Point3D) -> VoxelGrid {
  @voxel_grid.voxel_set(grid, p)
}
pub fn voxel_occupied(grid : VoxelGrid, p : @core.Point3D) -> Bool {
  @voxel_grid.voxel_occupied(grid, p)
}
pub fn voxel_count_occupied(grid : VoxelGrid) -> Int {
  @voxel_grid.voxel_count_occupied(grid)
}

// ========== normal_est ==========
pub fn pc_estimate_normal(center : @core.Point3D, neighbors : Array[@core.Point3D]) -> @core.Point3D {
  @normal_est.estimate_normal(center, neighbors)
}
pub fn normalize_normal(n : @core.Point3D) -> @core.Point3D {
  @normal_est.normalize_normal(n)
}
pub fn orient_normal(normal : @core.Point3D, ref_dir : @core.Point3D) -> @core.Point3D {
  @normal_est.orient_normal(normal, ref_dir)
}

// ========== curvature_est ==========
pub fn estimate_mean_curvature(center : @core.Point3D, neighbors : Array[@core.Point3D], normals : Array[@core.Point3D], center_normal : @core.Point3D) -> Double {
  @curvature_est.estimate_mean_curvature(center, neighbors, normals, center_normal)
}
pub fn estimate_gaussian_curvature(center : @core.Point3D, neighbors : Array[@core.Point3D]) -> Double {
  @curvature_est.estimate_gaussian_curvature(center, neighbors)
}
pub fn pc_principal_curvatures(k_gaussian : Double, k_mean : Double) -> (Double, Double) {
  @curvature_est.principal_curvatures(k_gaussian, k_mean)
}

// ========== pc_segment ==========
pub fn segment_by_height(points : Array[@core.Point3D], threshold : Double) -> (Array[Int], Array[Int]) {
  @pc_segment.segment_by_height(points, threshold)
}
pub fn segment_by_distance(points : Array[@core.Point3D], max_dist : Double) -> Array[Array[Int]] {
  @pc_segment.segment_by_distance(points, max_dist)
}
pub fn segment_count(clusters : Array[Array[Int]]) -> Int {
  @pc_segment.segment_count(clusters)
}

// ========== pc_feature ==========
pub fn local_density(points : Array[@core.Point3D], center : @core.Point3D, radius : Double) -> Int {
  @pc_feature.local_density(points, center, radius)
}
pub fn curvature_feature(eigenvalues : Array[Double]) -> Double {
  @pc_feature.curvature_feature(eigenvalues)
}
pub fn planarity_feature(eigenvalues : Array[Double]) -> Double {
  @pc_feature.planarity_feature(eigenvalues)
}
pub fn scattering_feature(eigenvalues : Array[Double]) -> Double {
  @pc_feature.scattering_feature(eigenvalues)
}

// ========== ground_detect ==========
pub fn detect_ground_height(points : Array[@core.Point3D], threshold : Double) -> Array[Bool] {
  @ground_detect.detect_ground_height(points, threshold)
}
pub fn detect_ground_progressive(points : Array[@core.Point3D], base_height : Double, slope : Double) -> Array[Bool] {
  @ground_detect.detect_ground_progressive(points, base_height, slope)
}
pub fn ground_point_count(labels : Array[Bool]) -> Int {
  @ground_detect.ground_point_count(labels)
}
pub fn ground_ratio(labels : Array[Bool]) -> Double {
  @ground_detect.ground_ratio(labels)
}

// ========== pc_filter ==========
pub fn statistical_filter(points : Array[@core.Point3D], k : Int, threshold : Double) -> Array[Int] {
  @pc_filter.statistical_filter(points, k, threshold)
}
pub fn radius_filter(points : Array[@core.Point3D], radius : Double, min_neighbors : Int) -> Array[Int] {
  @pc_filter.radius_filter(points, radius, min_neighbors)
}
pub fn removed_count(original : Int, kept : Int) -> Int {
  @pc_filter.removed_count(original, kept)
}

// ========== pc_transform ==========
pub fn translate_cloud(points : Array[@core.Point3D], dx : Double, dy : Double, dz : Double) -> Array[@core.Point3D] {
  @pc_transform.translate_cloud(points, dx, dy, dz)
}
pub fn scale_cloud(points : Array[@core.Point3D], factor : Double) -> Array[@core.Point3D] {
  @pc_transform.scale_cloud(points, factor)
}
pub fn rotate_z_cloud(points : Array[@core.Point3D], angle : Double) -> Array[@core.Point3D] {
  @pc_transform.rotate_z_cloud(points, angle)
}
pub fn center_cloud(points : Array[@core.Point3D]) -> Array[@core.Point3D] {
  @pc_transform.center_cloud(points)
}

// ========== simplicial_complex ==========
pub type SimplicialComplex = @simplicial_complex.SimplicialComplex
pub fn simplex_count(sc : SimplicialComplex) -> Int {
  @simplicial_complex.simplex_count(sc)
}
pub fn complex_dimension(sc : SimplicialComplex) -> Int {
  @simplicial_complex.complex_dimension(sc)
}
pub fn is_valid_complex(sc : SimplicialComplex) -> Bool {
  @simplicial_complex.is_valid_complex(sc)
}
pub fn add_simplex(sc : SimplicialComplex, vertices : Array[Int]) -> SimplicialComplex {
  @simplicial_complex.add_simplex(sc, vertices)
}

// ========== chain_complex ==========
pub type ChainComplex = @chain_complex.ChainComplex
pub fn chain_rank(cc : ChainComplex, dim : Int) -> Int {
  @chain_complex.chain_rank(cc, dim)
}
pub fn chain_length(cc : ChainComplex) -> Int {
  @chain_complex.chain_length(cc)
}
pub fn chain_total_rank(cc : ChainComplex) -> Int {
  @chain_complex.chain_total_rank(cc)
}

// ========== boundary_operator ==========
pub fn boundary_of_simplex(simplex : Array[Int]) -> Array[(Array[Int], Int)] {
  @boundary_operator.boundary_of_simplex(simplex)
}
pub fn boundary_squared_zero(simplex : Array[Int]) -> Bool {
  @boundary_operator.boundary_squared_zero(simplex)
}
pub fn boundary_count(simplex : Array[Int]) -> Int {
  @boundary_operator.boundary_count(simplex)
}

// ========== homology_group ==========
pub type HomologyGroup = @homology_group.HomologyGroup
pub fn betti_number(hg : HomologyGroup) -> Int {
  @homology_group.betti_number(hg)
}
pub fn is_trivial(hg : HomologyGroup) -> Bool {
  @homology_group.is_trivial(hg)
}
pub fn homology_euler_characteristic(groups : Array[HomologyGroup]) -> Int {
  @homology_group.euler_characteristic(groups)
}
pub fn has_torsion(hg : HomologyGroup) -> Bool {
  @homology_group.has_torsion(hg)
}

// ========== cohomology ==========
pub type CohomologyClass = @cohomology.CohomologyClass
pub fn cohomology_rank(dim : Int, betti : Int) -> Int {
  @cohomology.cohomology_rank(dim, betti)
}
pub fn cup_product_degree(a : CohomologyClass, b : CohomologyClass) -> Int {
  @cohomology.cup_product_degree(a, b)
}
pub fn cohomology_dimension(c : CohomologyClass) -> Int {
  @cohomology.cohomology_dimension(c)
}

// ========== discrete_morse ==========
pub type MorseFunction = @discrete_morse.MorseFunction
pub fn discrete_morse_critical_points(mf : MorseFunction) -> Array[Int] {
  @discrete_morse.critical_points(mf)
}
pub fn morse_inequality_lower(mf : MorseFunction, dim : Int) -> Int {
  @discrete_morse.morse_inequality_lower(mf, dim)
}
pub fn is_morse(mf : MorseFunction) -> Bool {
  @discrete_morse.is_morse(mf)
}

// ========== witness_complex ==========
pub fn witness_complex_landmarks(n_points : Int, n_landmarks : Int) -> Array[Array[Int]] {
  @witness_complex.witness_complex_landmarks(n_points, n_landmarks)
}
pub fn witness_skeleton(max_dim : Int, n_landmarks : Int) -> Int {
  @witness_complex.witness_skeleton(max_dim, n_landmarks)
}
pub fn landmark_count(n_points : Int, ratio : Double) -> Int {
  @witness_complex.landmark_count(n_points, ratio)
}

// ========== cech_complex ==========
pub fn cech_complex_simplices(n_points : Int, max_dim : Int) -> Array[Array[Int]] {
  @cech_complex.cech_complex_simplices(n_points, max_dim)
}
pub fn cech_nerve(balls : Int) -> Array[Array[Int]] {
  @cech_complex.cech_nerve(balls)
}
pub fn cech_dimension(max_dim : Int) -> Int {
  @cech_complex.cech_dimension(max_dim)
}

// ========== nerve_theorem ==========
pub fn nerve_of_cover(n_sets : Int, intersections : Array[(Int, Int)]) -> Array[Array[Int]] {
  @nerve_theorem.nerve_of_cover(n_sets, intersections)
}
pub fn nerve_homology(nerve : Array[Array[Int]]) -> Array[Int] {
  @nerve_theorem.nerve_homology(nerve)
}
pub fn is_good_cover(intersections : Array[(Int, Int)]) -> Bool {
  @nerve_theorem.is_good_cover(intersections)
}

// ========== filtration ==========
pub type Filtration = @filtration.Filtration
pub fn sublevel_set(f : Filtration, threshold : Double) -> Array[Array[Int]] {
  @filtration.sublevel_set(f, threshold)
}
pub fn filtration_length(f : Filtration) -> Int {
  @filtration.filtration_length(f)
}
pub fn critical_values(f : Filtration) -> Array[Double] {
  @filtration.critical_values(f)
}

// ========== exact_predicates ==========
pub fn exact_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Int {
  @exact_predicates.exact_orientation(a, b, c)
}
pub fn exact_incircle(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> Int {
  @exact_predicates.exact_incircle(a, b, c, d)
}
pub fn exact_left_turn(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Bool {
  @exact_predicates.exact_left_turn(a, b, c)
}
pub fn exact_collinear(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Bool {
  @exact_predicates.exact_collinear(a, b, c)
}

// ========== interval_arithmetic ==========
pub type IAInterval = @interval_arithmetic.Interval
pub fn interval_add(a : IAInterval, b : IAInterval) -> IAInterval {
  @interval_arithmetic.interval_add(a, b)
}
pub fn interval_sub(a : IAInterval, b : IAInterval) -> IAInterval {
  @interval_arithmetic.interval_sub(a, b)
}
pub fn interval_mul(a : IAInterval, b : IAInterval) -> IAInterval {
  @interval_arithmetic.interval_mul(a, b)
}
pub fn ia_interval_contains(i : IAInterval, x : Double) -> Bool {
  @interval_arithmetic.interval_contains(i, x)
}
pub fn interval_width(i : IAInterval) -> Double {
  @interval_arithmetic.interval_width(i)
}
pub fn ia_interval_midpoint(i : IAInterval) -> Double {
  @interval_arithmetic.interval_midpoint(i)
}

// ========== filtered_predicates ==========
pub fn filtered_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Int {
  @filtered_predicates.filtered_orientation(a, b, c)
}
pub fn filtered_incircle(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> Int {
  @filtered_predicates.filtered_incircle(a, b, c, d)
}
pub fn perturbation_orientation(det : Double, eps : Double) -> Int {
  @filtered_predicates.perturbation_orientation(det, eps)
}

// ========== perturbation ==========
pub fn sos_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, ia : Int, ib : Int, ic : Int) -> Int {
  @perturbation.sos_orientation(a, b, c, ia, ib, ic)
}
pub fn sos_sign(det : Double, perturbation_order : Int) -> Int {
  @perturbation.sos_sign(det, perturbation_order)
}
pub fn sos_compare(a : Double, b : Double, ia : Int, ib : Int) -> Int {
  @perturbation.sos_compare(a, b, ia, ib)
}

// ========== robust_construction ==========
pub fn robust_circumcenter(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> @core.Point2D {
  @robust_construction.robust_circumcenter(a, b, c)
}
pub fn robust_intersection(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> @core.Point2D {
  @robust_construction.robust_intersection(a, b, c, d)
}
pub fn robust_midpoint(a : @core.Point2D, b : @core.Point2D) -> @core.Point2D {
  @robust_construction.robust_midpoint(a, b)
}

// ========== big_rational ==========
pub type Rational = @big_rational.Rational
pub fn rational_add(a : Rational, b : Rational) -> Rational {
  @big_rational.rational_add(a, b)
}
pub fn rational_mul(a : Rational, b : Rational) -> Rational {
  @big_rational.rational_mul(a, b)
}
pub fn rational_to_double(r : Rational) -> Double {
  @big_rational.rational_to_double(r)
}
pub fn rational_equal(a : Rational, b : Rational) -> Bool {
  @big_rational.rational_equal(a, b)
}
pub fn rational_sub(a : Rational, b : Rational) -> Rational {
  @big_rational.rational_sub(a, b)
}

// ========== de9im ==========
pub fn de9im_intersects(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_intersects(a_bounds, b_bounds)
}
pub fn de9im_contains(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_contains(a_bounds, b_bounds)
}
pub fn de9im_disjoint(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_disjoint(a_bounds, b_bounds)
}
pub fn de9im_touches(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_touches(a_bounds, b_bounds)
}
pub fn de9im_within(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_within(a_bounds, b_bounds)
}

// ========== lazy_exact ==========
pub type LazyExact = @lazy_exact.LazyExact
pub fn lazy_value(le : LazyExact) -> Double {
  @lazy_exact.lazy_value(le)
}
pub fn lazy_approx(le : LazyExact) -> Double {
  @lazy_exact.lazy_approx(le)
}
pub fn lazy_error(le : LazyExact) -> Double {
  @lazy_exact.lazy_error(le)
}

// ========== rounded_geometry ==========
pub fn round_double(x : Double, precision : Int) -> Double {
  @rounded_geometry.round_double(x, precision)
}
pub fn rounded_area(points : Array[@core.Point2D], precision : Int) -> Double {
  @rounded_geometry.rounded_area(points, precision)
}
pub fn rounded_length(a : @core.Point2D, b : @core.Point2D, precision : Int) -> Double {
  @rounded_geometry.rounded_length(a, b, precision)
}

// ========== affine_arithmetic ==========
pub type AffineForm = @affine_arithmetic.AffineForm
pub fn affine_add(a : AffineForm, b : AffineForm) -> AffineForm {
  @affine_arithmetic.affine_add(a, b)
}
pub fn affine_to_interval(a : AffineForm) -> (Double, Double) {
  @affine_arithmetic.affine_to_interval(a)
}
pub fn affine_scale(a : AffineForm, s : Double) -> AffineForm {
  @affine_arithmetic.affine_scale(a, s)
}

// ========== nsga2 ==========
pub type Nsga2Config = @nsga2.Nsga2Config
pub fn non_dominated_sort(objectives : Array[Array[Double]]) -> Array[Array[Int]] {
  @nsga2.non_dominated_sort(objectives)
}
pub fn crowding_distance(objectives : Array[Array[Double]], front : Array[Int]) -> Array[Double] {
  @nsga2.crowding_distance(objectives, front)
}
pub fn pareto_rank(fronts : Array[Array[Int]]) -> Array[Int] {
  @nsga2.pareto_rank(fronts)
}

// ========== pareto_front ==========
pub fn dominates(a : Array[Double], b : Array[Double]) -> Bool {
  @pareto_front.dominates(a, b)
}
pub fn pareto_front_points(objectives : Array[Array[Double]]) -> Array[Int] {
  @pareto_front.pareto_front_points(objectives)
}
pub fn hypervolume_2d(points : Array[(Double, Double)], ref_pt : (Double, Double)) -> Double {
  @pareto_front.hypervolume_2d(points, ref_pt)
}

// ========== bayesian_opt ==========
pub type BOConfig = @bayesian_opt.BOConfig
pub fn expected_improvement(best : Double, mean : Double, std : Double) -> Double {
  @bayesian_opt.expected_improvement(best, mean, std)
}
pub fn gaussian_kernel(x : Double, y : Double, length_scale : Double) -> Double {
  @bayesian_opt.gaussian_kernel(x, y, length_scale)
}
pub fn bo_suggest_next(observed_x : Array[Double], observed_y : Array[Double], bounds : (Double, Double)) -> Double {
  @bayesian_opt.bo_suggest_next(observed_x, observed_y, bounds)
}

// ========== cmaes ==========
pub type CmaesConfig = @cmaes.CmaesConfig
pub fn update_sigma(sigma : Double, ps_norm : Double, dim : Int) -> Double {
  @cmaes.update_sigma(sigma, ps_norm, dim)
}
pub fn cmaes_adapt_factor(gen : Int, dim : Int) -> Double {
  @cmaes.cmaes_adapt_factor(gen, dim)
}
pub fn cmaes_convergence_check(sigma : Double, threshold : Double) -> Bool {
  @cmaes.cmaes_convergence_check(sigma, threshold)
}

// ========== trust_region ==========
pub type TrustRegionConfig = @trust_region.TrustRegionConfig
pub fn trust_region_ratio(actual : Double, predicted : Double) -> Double {
  @trust_region.trust_region_ratio(actual, predicted)
}
pub fn update_radius(radius : Double, ratio : Double, max_radius : Double) -> Double {
  @trust_region.update_radius(radius, ratio, max_radius)
}
pub fn trust_region_converged(gradient_norm : Double, threshold : Double) -> Bool {
  @trust_region.trust_region_converged(gradient_norm, threshold)
}

// ========== sqp ==========
pub type SqpConfig = @sqp.SqpConfig
pub fn lagrangian(f : Double, lambda : Array[Double], constraints : Array[Double]) -> Double {
  @sqp.lagrangian(f, lambda, constraints)
}
pub fn kkt_residual(grad_f : Array[Double], jacobian : Array[Array[Double]], lambda : Array[Double]) -> Double {
  @sqp.kkt_residual(grad_f, jacobian, lambda)
}
pub fn sqp_converged(residual : Double, tol : Double) -> Bool {
  @sqp.sqp_converged(residual, tol)
}

// ========== augmented_lagrangian ==========
pub type AugLagConfig = @augmented_lagrangian.AugLagConfig
pub fn aug_lagrangian(f : Double, lambda : Array[Double], constraints : Array[Double], rho : Double) -> Double {
  @augmented_lagrangian.aug_lagrangian(f, lambda, constraints, rho)
}
pub fn update_rho(rho : Double, rho_factor : Double, constraint_violation : Double, prev_violation : Double) -> Double {
  @augmented_lagrangian.update_rho(rho, rho_factor, constraint_violation, prev_violation)
}
pub fn constraint_violation(constraints : Array[Double]) -> Double {
  @augmented_lagrangian.constraint_violation(constraints)
}

// ========== branch_bound ==========
pub type BranchBoundConfig = @branch_bound.BranchBoundConfig
pub fn bb_lower_bound(f : (Double) -> Double, lo : Double, hi : Double) -> Double {
  @branch_bound.lower_bound(f, lo, hi)
}
pub fn branch_interval(lo : Double, hi : Double) -> ((Double, Double), (Double, Double)) {
  @branch_bound.branch_interval(lo, hi)
}
pub fn bb_converged(lo : Double, hi : Double, tol : Double) -> Bool {
  @branch_bound.bb_converged(lo, hi, tol)
}

// ========== sdp ==========
pub type SdpConfig = @sdp.SdpConfig
pub fn is_psd(eigenvalues : Array[Double]) -> Bool {
  @sdp.is_psd(eigenvalues)
}
pub fn sdp_matrix_trace(m : Array[Array[Double]]) -> Double {
  @sdp.matrix_trace(m)
}
pub fn frobenius_norm(m : Array[Array[Double]]) -> Double {
  @sdp.frobenius_norm(m)
}

// ========== socp ==========
pub type SocpConfig = @socp.SocpConfig
pub fn soc_constraint(x : Array[Double], t : Double) -> Bool {
  @socp.soc_constraint(x, t)
}
pub fn soc_dual(y : Array[Double], s : Double) -> Bool {
  @socp.soc_dual(y, s)
}
pub fn soc_slack(x : Array[Double], t : Double) -> Double {
  @socp.soc_slack(x, t)
}

// ========== grobner_basis ==========
pub type Polynomial = @grobner_basis.Polynomial
pub fn gb_poly_degree(p : Polynomial) -> Int {
  @grobner_basis.poly_degree(p)
}
pub fn poly_lead_coeff(p : Polynomial) -> Double {
  @grobner_basis.poly_lead_coeff(p)
}
pub fn poly_s_divide(a : Polynomial, b : Polynomial) -> Polynomial {
  @grobner_basis.poly_s_divide(a, b)
}
pub fn gb_poly_sub(a : Polynomial, b : Polynomial) -> Polynomial {
  @grobner_basis.poly_sub(a, b)
}
pub fn poly_is_reduced(p : Polynomial) -> Bool {
  @grobner_basis.poly_is_reduced(p)
}

// ========== polynomial_ideal ==========
pub fn ideal_membership(p : @grobner_basis.Polynomial, generators : Array[@grobner_basis.Polynomial]) -> Bool {
  @polynomial_ideal.ideal_membership(p, generators)
}
pub fn ideal_dimension(generators : Array[@grobner_basis.Polynomial]) -> Int {
  @polynomial_ideal.ideal_dimension(generators)
}
pub fn ideal_is_zero(generators : Array[@grobner_basis.Polynomial]) -> Bool {
  @polynomial_ideal.ideal_is_zero(generators)
}
pub fn ideal_generator_count(generators : Array[@grobner_basis.Polynomial]) -> Int {
  @polynomial_ideal.ideal_generator_count(generators)
}

// ========== algebraic_variety ==========
pub fn variety_dimension(n_vars : Int, n_equations : Int) -> Int {
  @algebraic_variety.variety_dimension(n_vars, n_equations)
}
pub fn variety_is_empty(n_solutions : Int) -> Bool {
  @algebraic_variety.variety_is_empty(n_solutions)
}
pub fn variety_is_finite(dimension : Int) -> Bool {
  @algebraic_variety.variety_is_finite(dimension)
}
pub fn variety_degree(n_vars : Int, degrees : Array[Int]) -> Int {
  @algebraic_variety.variety_degree(n_vars, degrees)
}
pub fn variety_count_real_roots(approx_roots : Array[Double], tol : Double) -> Int {
  @algebraic_variety.variety_count_real_roots(approx_roots, tol)
}

// ========== rational_map ==========
pub type RationalMap = @rational_map.RationalMap
pub fn rational_eval(m : RationalMap, x : Double) -> Double {
  @rational_map.rational_eval(m, x)
}
pub fn rational_degree(m : RationalMap) -> Int {
  @rational_map.rational_degree(m)
}
pub fn rational_is_defined(m : RationalMap, x : Double) -> Bool {
  @rational_map.rational_is_defined(m, x)
}

// ========== intersection_theory ==========
pub fn intersection_number(degrees : Array[Int]) -> Int {
  @intersection_theory.intersection_number(degrees)
}
pub fn self_intersection(degree : Int, n : Int) -> Int {
  @intersection_theory.self_intersection(degree, n)
}
pub fn bezout_bound(d1 : Int, d2 : Int) -> Int {
  @intersection_theory.bezout_bound(d1, d2)
}
pub fn excess_intersection(expected : Int, actual : Int) -> Int {
  @intersection_theory.excess_intersection(expected, actual)
}
pub fn is_transverse(codim_sum : Int, ambient_dim : Int) -> Bool {
  @intersection_theory.is_transverse(codim_sum, ambient_dim)
}

// ========== chow_ring ==========
pub fn chow_ring_dim(n : Int) -> Int {
  @chow_ring.chow_ring_dim(n)
}
pub fn chow_product(a_deg : Int, b_deg : Int, n : Int) -> Int {
  @chow_ring.chow_product(a_deg, b_deg, n)
}
pub fn chow_class_degree(k : Int, n : Int) -> Int {
  @chow_ring.chow_class_degree(k, n)
}
pub fn chow_top_class(n : Int) -> Int {
  @chow_ring.chow_top_class(n)
}
pub fn chow_integral(degree : Int, n : Int) -> Int {
  @chow_ring.chow_integral(degree, n)
}

// ========== hilbert_function ==========
pub fn hilbert_function_pn(degree : Int, n : Int) -> Int {
  @hilbert_function.hilbert_function_pn(degree, n)
}
pub fn hilbert_series_coeff(degree : Int, n : Int) -> Int {
  @hilbert_function.hilbert_series_coeff(degree, n)
}
pub fn hilbert_polynomial_eval(t : Int, degree : Int, n : Int) -> Int {
  @hilbert_function.hilbert_polynomial_eval(t, degree, n)
}
pub fn hilbert_regularity(n : Int) -> Int {
  @hilbert_function.hilbert_regularity(n)
}
pub fn hilbert_multiplicity(degree : Int, n : Int) -> Int {
  @hilbert_function.hilbert_multiplicity(degree, n)
}

// ========== bezout_theorem ==========
pub fn bezout_count(d1 : Int, d2 : Int) -> Int {
  @bezout_theorem.bezout_count(d1, d2)
}
pub fn bezout_with_multiplicities(degrees : Array[Int]) -> Int {
  @bezout_theorem.bezout_with_multiplicities(degrees)
}
pub fn bezout_excess(expected : Int, found : Int) -> Int {
  @bezout_theorem.bezout_excess(expected, found)
}
pub fn bezout_in_pn(degrees : Array[Int], n : Int) -> Int {
  @bezout_theorem.bezout_in_pn(degrees, n)
}
pub fn is_bezout_satisfied(expected : Int, actual : Int) -> Bool {
  @bezout_theorem.is_bezout_satisfied(expected, actual)
}

// ========== multiplicity ==========
pub fn intersection_multiplicity(order_a : Int, order_b : Int) -> Int {
  @multiplicity.intersection_multiplicity(order_a, order_b)
}
pub fn tangency_multiplicity(contact_order : Int) -> Int {
  @multiplicity.tangency_multiplicity(contact_order)
}
pub fn total_multiplicity(local_mults : Array[Int]) -> Int {
  @multiplicity.total_multiplicity(local_mults)
}
pub fn is_simple_intersection(mult : Int) -> Bool {
  @multiplicity.is_simple_intersection(mult)
}
pub fn multiplicity_from_tangent(tangent_dot : Double, tol : Double) -> Int {
  @multiplicity.multiplicity_from_tangent(tangent_dot, tol)
}

// ========== elimination_ideal ==========
pub fn eliminate_variable(n_vars : Int, var_index : Int) -> Int {
  @elimination_ideal.eliminate_variable(n_vars, var_index)
}
pub fn elimination_order(n_vars : Int, eliminate_count : Int) -> Int {
  @elimination_ideal.elimination_order(n_vars, eliminate_count)
}
pub fn projection_dimension(variety_dim : Int, eliminate_count : Int) -> Int {
  @elimination_ideal.projection_dimension(variety_dim, eliminate_count)
}
pub fn closure_is_proper(fiber_dim : Int) -> Bool {
  @elimination_ideal.closure_is_proper(fiber_dim)
}
pub fn extension_exists(generic_fiber_nonempty : Bool) -> Bool {
  @elimination_ideal.extension_exists(generic_fiber_nonempty)
}

// ========== discrete_curvature ==========
pub fn discrete_gaussian_curvature(angle_defect : Double) -> Double {
  @discrete_curvature.discrete_gaussian_curvature(angle_defect)
}
pub fn discrete_mean_curvature(area : Double, edge_lengths : Array[Double], dihedral_angles : Array[Double]) -> Double {
  @discrete_curvature.discrete_mean_curvature(area, edge_lengths, dihedral_angles)
}
pub fn angle_defect(angles : Array[Double]) -> Double {
  @discrete_curvature.angle_defect(angles)
}
pub fn voronoi_area(edge_len : Double) -> Double {
  @discrete_curvature.voronoi_area(edge_len)
}
pub fn mixed_area(a1 : Double, a2 : Double) -> Double {
  @discrete_curvature.mixed_area(a1, a2)
}

// ========== gauss_bonnet ==========
pub fn gauss_bonnet_check(total_curvature : Double, euler_char : Int) -> Bool {
  @gauss_bonnet.gauss_bonnet_check(total_curvature, euler_char)
}
pub fn euler_from_curvature(total_curvature : Double) -> Int {
  @gauss_bonnet.euler_from_curvature(total_curvature)
}
pub fn total_gaussian_curvature(angle_defects : Array[Double]) -> Double {
  @gauss_bonnet.total_gaussian_curvature(angle_defects)
}
pub fn boundary_correction(boundary_angles : Array[Double]) -> Double {
  @gauss_bonnet.boundary_correction(boundary_angles)
}
pub fn gauss_bonnet_with_boundary(interior_curv : Double, boundary_corr : Double, euler_char : Int) -> Bool {
  @gauss_bonnet.gauss_bonnet_with_boundary(interior_curv, boundary_corr, euler_char)
}

// ========== geodesic_dist ==========
pub fn euclidean_fallback(a : @core.Point3D, b : @core.Point3D) -> Double {
  @geodesic_dist.euclidean_fallback(a, b)
}
pub fn dijkstra_geodesic(n : Int, adj : Array[(Int, Int, Double)], source : Int, target : Int) -> Double {
  @geodesic_dist.dijkstra_geodesic(n, adj, source, target)
}
pub fn geodesic_lower_bound(a : @core.Point3D, b : @core.Point3D) -> Double {
  @geodesic_dist.geodesic_lower_bound(a, b)
}
pub fn heat_method_step(dist : Array[Double], t : Double) -> Double {
  @geodesic_dist.heat_method_step(dist, t)
}

// ========== discrete_laplacian ==========
pub fn uniform_laplacian(values : Array[Double], neighbors : Array[Double]) -> Double {
  @discrete_laplacian.uniform_laplacian(values, neighbors)
}
pub fn cotangent_weight(cot_a : Double, cot_b : Double) -> Double {
  @discrete_laplacian.cotangent_weight(cot_a, cot_b)
}
pub fn cotangent_laplacian(center_val : Double, neighbor_vals : Array[Double], weights : Array[Double]) -> Double {
  @discrete_laplacian.cotangent_laplacian(center_val, neighbor_vals, weights)
}
pub fn laplacian_eigenvalue(mode : Int, area : Double) -> Double {
  @discrete_laplacian.laplacian_eigenvalue(mode, area)
}
pub fn is_harmonic(laplacian_val : Double, tol : Double) -> Bool {
  @discrete_laplacian.is_harmonic(laplacian_val, tol)
}

// ========== harmonic_map ==========
pub fn dirichlet_energy(values : Array[Double], neighbors : Array[Array[Double]]) -> Double {
  @harmonic_map.dirichlet_energy(values, neighbors)
}
pub fn harmonic_residual(laplacian_values : Array[Double]) -> Double {
  @harmonic_map.harmonic_residual(laplacian_values)
}
pub fn is_harmonic_map(residual : Double, tol : Double) -> Bool {
  @harmonic_map.is_harmonic_map(residual, tol)
}
pub fn map_energy(dirichlet : Double, area : Double) -> Double {
  @harmonic_map.map_energy(dirichlet, area)
}
pub fn hm_laplacian_smooth(values : Array[Double], laplacian : Array[Double], lambda : Double) -> Array[Double] {
  @harmonic_map.laplacian_smooth(values, laplacian, lambda)
}

// ========== conformal_map ==========
pub fn conformal_factor(scale_x : Double, scale_y : Double) -> Double {
  @conformal_map.conformal_factor(scale_x, scale_y)
}
pub fn is_conformal(j11 : Double, j12 : Double, j21 : Double, j22 : Double, tol : Double) -> Bool {
  @conformal_map.is_conformal(j11, j12, j21, j22, tol)
}
pub fn conformal_energy(stretch_u : Double, stretch_v : Double) -> Double {
  @conformal_map.conformal_energy(stretch_u, stretch_v)
}
pub fn angle_distortion(theta_before : Double, theta_after : Double) -> Double {
  @conformal_map.angle_distortion(theta_before, theta_after)
}
pub fn cm_area_distortion(area_before : Double, area_after : Double) -> Double {
  @conformal_map.area_distortion(area_before, area_after)
}

// ========== surface_ricci ==========
pub fn ricci_flow_step(curvatures : Array[Double], target_curvatures : Array[Double], dt : Double) -> Array[Double] {
  @surface_ricci.ricci_flow_step(curvatures, target_curvatures, dt)
}
pub fn ricci_energy(curvatures : Array[Double], target : Array[Double]) -> Double {
  @surface_ricci.ricci_energy(curvatures, target)
}
pub fn target_curvature_uniform(n : Int, total_curv : Double) -> Array[Double] {
  @surface_ricci.target_curvature_uniform(n, total_curv)
}
pub fn target_curvature_gaussian(n : Int, euler_char : Int) -> Array[Double] {
  @surface_ricci.target_curvature_gaussian(n, euler_char)
}
pub fn ricci_converged(energy : Double, tol : Double) -> Bool {
  @surface_ricci.ricci_converged(energy, tol)
}

// ========== discrete_yamabe ==========
pub fn yamabe_energy(curvatures : Array[Double], target : Double) -> Double {
  @discrete_yamabe.yamabe_energy(curvatures, target)
}
pub fn yamabe_gradient(curvatures : Array[Double], target : Double) -> Array[Double] {
  @discrete_yamabe.yamabe_gradient(curvatures, target)
}
pub fn constant_curvature_target(total_curv : Double, n : Int) -> Double {
  @discrete_yamabe.constant_curvature_target(total_curv, n)
}
pub fn yamabe_flow_step(conformal_factors : Array[Double], gradient : Array[Double], dt : Double) -> Array[Double] {
  @discrete_yamabe.yamabe_flow_step(conformal_factors, gradient, dt)
}
pub fn yamabe_converged(energy : Double, tol : Double) -> Bool {
  @discrete_yamabe.yamabe_converged(energy, tol)
}

// ========== willmore_energy ==========
pub fn willmore_energy(mean_curvatures : Array[Double], areas : Array[Double]) -> Double {
  @willmore_energy.willmore_energy(mean_curvatures, areas)
}
pub fn willmore_gradient(h : Double, area : Double) -> Double {
  @willmore_energy.willmore_gradient(h, area)
}
pub fn willmore_of_sphere(radius : Double) -> Double {
  @willmore_energy.willmore_of_sphere(radius)
}
pub fn willmore_flow_step(curvatures : Array[Double], gradient : Array[Double], dt : Double) -> Array[Double] {
  @willmore_energy.willmore_flow_step(curvatures, gradient, dt)
}
pub fn is_willmore_minimal(gradient_norm : Double, tol : Double) -> Bool {
  @willmore_energy.is_willmore_minimal(gradient_norm, tol)
}

// ========== minimal_surface ==========
pub fn is_minimal(mean_curvature : Double, tol : Double) -> Bool {
  @minimal_surface.is_minimal(mean_curvature, tol)
}
pub fn minimal_surface_energy(area : Double) -> Double {
  @minimal_surface.minimal_surface_energy(area)
}
pub fn area_gradient(mean_curvatures : Array[Double], areas : Array[Double]) -> Array[Double] {
  @minimal_surface.area_gradient(mean_curvatures, areas)
}
pub fn mean_curvature_flow_step(positions : Array[Double], laplacian : Array[Double], dt : Double) -> Array[Double] {
  @minimal_surface.mean_curvature_flow_step(positions, laplacian, dt)
}
pub fn plateau_energy(boundary_length : Double, area : Double) -> Double {
  @minimal_surface.plateau_energy(boundary_length, area)
}

// ========== persistence_diagram ==========
pub type PersistencePoint = @persistence_diagram.PersistencePoint
pub fn persistence(p : PersistencePoint) -> Double {
  @persistence_diagram.persistence(p)
}
pub fn is_essential(p : PersistencePoint) -> Bool {
  @persistence_diagram.is_essential(p)
}
pub fn diagram_dimension(diagram : Array[PersistencePoint]) -> Int {
  @persistence_diagram.diagram_dimension(diagram)
}
pub fn max_persistence(diagram : Array[PersistencePoint]) -> Double {
  @persistence_diagram.max_persistence(diagram)
}

// ========== bottleneck_dist ==========
pub fn bd_bottleneck_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @bottleneck_dist.bottleneck_distance(d1, d2)
}
pub fn bottleneck_upper_bound(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @bottleneck_dist.bottleneck_upper_bound(d1, d2)
}
pub fn bottleneck_lower_bound(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @bottleneck_dist.bottleneck_lower_bound(d1, d2)
}

// ========== wasserstein_dist ==========
pub fn wasserstein_1_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @wasserstein_dist.wasserstein_1_distance(d1, d2)
}
pub fn wasserstein_inf_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @wasserstein_dist.wasserstein_inf_distance(d1, d2)
}
pub fn wasserstein_p_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint], p : Double) -> Double {
  @wasserstein_dist.wasserstein_p_distance(d1, d2, p)
}

// ========== persistence_landscape ==========
pub fn landscape_k(point : @persistence_diagram.PersistencePoint, k : Int, t : Double) -> Double {
  @persistence_landscape.landscape_k(point, k, t)
}
pub fn landscape_sup(point : @persistence_diagram.PersistencePoint) -> Double {
  @persistence_landscape.landscape_sup(point)
}
pub fn landscape_norm_1(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @persistence_landscape.landscape_norm_1(diagram)
}
pub fn landscape_norm_inf(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @persistence_landscape.landscape_norm_inf(diagram)
}

// ========== persistence_image ==========
pub fn gaussian_kernel_2d(x : Double, y : Double, mu_x : Double, mu_y : Double, sigma : Double) -> Double {
  @persistence_image.gaussian_kernel_2d(x, y, mu_x, mu_y, sigma)
}
pub fn persistence_image_pixel(point : @persistence_diagram.PersistencePoint, mu_x : Double, mu_y : Double, sigma : Double, weight : Double) -> Double {
  @persistence_image.persistence_image_pixel(point, mu_x, mu_y, sigma, weight)
}
pub fn persistence_image_vector(diagram : Array[@persistence_diagram.PersistencePoint], pixels : Array[(Double, Double)], sigma : Double) -> Array[Double] {
  @persistence_image.persistence_image_vector(diagram, pixels, sigma)
}
pub fn image_norm(image : Array[Double]) -> Double {
  @persistence_image.image_norm(image)
}

// ========== mapper_algo ==========
pub fn mapper_cover(values : Array[Double], n_intervals : Int, overlap : Double) -> Array[(Double, Double)] {
  @mapper_algo.mapper_cover(values, n_intervals, overlap)
}
pub fn mapper_cluster(points : Array[Double], interval : (Double, Double)) -> Array[Int] {
  @mapper_algo.mapper_cluster(points, interval)
}
pub fn mapper_graph_nodes(cover : Array[(Double, Double)], points : Array[Double]) -> Int {
  @mapper_algo.mapper_graph_nodes(cover, points)
}

// ========== zigzag_persistence ==========
pub fn zigzag_intervals(births : Array[Int], deaths : Array[Int]) -> Array[(Int, Int)] {
  @zigzag_persistence.zigzag_intervals(births, deaths)
}
pub fn zigzag_length(interval : (Int, Int)) -> Int {
  @zigzag_persistence.zigzag_length(interval)
}
pub fn zigzag_max_length(intervals : Array[(Int, Int)]) -> Int {
  @zigzag_persistence.zigzag_max_length(intervals)
}
pub fn zigzag_total_betti(intervals : Array[(Int, Int)]) -> Int {
  @zigzag_persistence.zigzag_total_betti(intervals)
}

// ========== multidim_persistence ==========
pub fn multidim_barcode(births : Array[(Double, Double)], deaths : Array[(Double, Double)]) -> Array[((Double, Double), (Double, Double))] {
  @multidim_persistence.multidim_barcode(births, deaths)
}
pub fn multidim_persistence(barcode : Array[((Double, Double), (Double, Double))]) -> Array[Double] {
  @multidim_persistence.multidim_persistence(barcode)
}
pub fn hilbert_function_md(grades : Array[(Int, Int)]) -> Int {
  @multidim_persistence.hilbert_function_md(grades)
}
pub fn rank_invariant(birth : (Int, Int), death : (Int, Int)) -> Int {
  @multidim_persistence.rank_invariant(birth, death)
}

// ========== sheaf_theory ==========
pub fn sheaf_rank(stalk_ranks : Array[Int]) -> Int {
  @sheaf_theory.sheaf_rank(stalk_ranks)
}
pub fn sheaf_cohomology_dim(c0_dim : Int, c1_dim : Int, c2_dim : Int) -> (Int, Int) {
  @sheaf_theory.sheaf_cohomology_dim(c0_dim, c1_dim, c2_dim)
}
pub fn euler_characteristic_sheaf(h0 : Int, h1 : Int, h2 : Int) -> Int {
  @sheaf_theory.euler_characteristic_sheaf(h0, h1, h2)
}
pub fn is_locally_constant(restriction_ranks : Array[Int]) -> Bool {
  @sheaf_theory.is_locally_constant(restriction_ranks)
}
pub fn sheaf_pushforward_rank(original_rank : Int, map_degree : Int) -> Int {
  @sheaf_theory.sheaf_pushforward_rank(original_rank, map_degree)
}

// ========== tda_features ==========
pub fn tda_total_persistence(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @tda_features.tda_total_persistence(diagram)
}
pub fn tda_max_persistence(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @tda_features.tda_max_persistence(diagram)
}
pub fn tda_feature_vector(diagram : Array[@persistence_diagram.PersistencePoint]) -> Array[Double] {
  @tda_features.tda_feature_vector(diagram)
}
pub fn tda_amplitude(diagram : Array[@persistence_diagram.PersistencePoint], p : Double) -> Double {
  @tda_features.tda_amplitude(diagram, p)
}

// ========== spectral_method ==========
pub fn chebyshev_node(n : Int, i : Int) -> Double {
  @spectral_method.chebyshev_node(n, i)
}
pub fn chebyshev_weight(n : Int, i : Int) -> Double {
  @spectral_method.chebyshev_weight(n, i)
}
pub fn fourier_coeff(f_values : Array[Double], k : Int) -> Double {
  @spectral_method.fourier_coeff(f_values, k)
}
pub fn spectral_derivative(coeffs : Array[Double], x : Double) -> Double {
  @spectral_method.spectral_derivative(coeffs, x)
}
pub fn spectral_interp(coeffs : Array[Double], x : Double) -> Double {
  @spectral_method.spectral_interp(coeffs, x)
}

// ========== finite_element ==========
pub fn element_stiffness(grad_u : (Double, Double), grad_v : (Double, Double), area : Double) -> Double {
  @finite_element.element_stiffness(grad_u, grad_v, area)
}
pub fn element_mass(u_val : Double, v_val : Double, area : Double) -> Double {
  @finite_element.element_mass(u_val, v_val, area)
}
pub fn assemble_stiffness(n : Int, elements : Array[(Int, Int, Int, Double)]) -> Array[Array[Double]] {
  @finite_element.assemble_stiffness(n, elements)
}
pub fn apply_dirichlet(k : Array[Array[Double]], boundary_nodes : Array[Int]) -> Array[Array[Double]] {
  @finite_element.apply_dirichlet(k, boundary_nodes)
}
pub fn fem_l2_error(exact : Array[Double], approx : Array[Double]) -> Double {
  @finite_element.fem_l2_error(exact, approx)
}

// ========== boundary_element ==========
pub fn fundamental_solution_2d(r : Double) -> Double {
  @boundary_element.fundamental_solution_2d(r)
}
pub fn boundary_integral_kernel(r : Double, normal_dist : Double) -> Double {
  @boundary_element.boundary_integral_kernel(r, normal_dist)
}
pub fn bem_matrix_entry(r : Double, weight : Double) -> Double {
  @boundary_element.bem_matrix_entry(r, weight)
}
pub fn bem_solve(matrix : Array[Array[Double]], rhs : Array[Double]) -> Array[Double] {
  @boundary_element.bem_solve(matrix, rhs)
}
pub fn bem_error(exact : Array[Double], approx : Array[Double]) -> Double {
  @boundary_element.bem_error(exact, approx)
}

// ========== meshfree_method ==========
pub fn sph_kernel(r : Double, h : Double) -> Double {
  @meshfree_method.sph_kernel(r, h)
}
pub fn sph_kernel_gradient(r : Double, h : Double) -> Double {
  @meshfree_method.sph_kernel_gradient(r, h)
}
pub fn rbf_gaussian(r : Double, eps : Double) -> Double {
  @meshfree_method.rbf_gaussian(r, eps)
}
pub fn rbf_multiquadric(r : Double, eps : Double) -> Double {
  @meshfree_method.rbf_multiquadric(r, eps)
}
pub fn rbf_thin_plate_spline(r : Double) -> Double {
  @meshfree_method.rbf_thin_plate_spline(r)
}

// ========== level_set ==========
pub fn level_set_sign(phi : Double) -> Int {
  @level_set.level_set_sign(phi)
}
pub fn level_set_normal(grad_phi : (Double, Double)) -> (Double, Double) {
  @level_set.level_set_normal(grad_phi)
}
pub fn level_set_curvature(grad : (Double, Double), hessian : (Double, Double, Double)) -> Double {
  @level_set.level_set_curvature(grad, hessian)
}
pub fn reinitialize_step(phi : Double, dt : Double, s0 : Int) -> Double {
  @level_set.reinitialize_step(phi, dt, s0)
}
pub fn level_set_area(phi : Array[Double], dx : Double) -> Double {
  @level_set.level_set_area(phi, dx)
}

// ========== fast_marching ==========
pub fn solve_eikonal_2d(u_left : Double, u_down : Double, f : Double, h : Double) -> Double {
  @fast_marching.solve_eikonal_2d(u_left, u_down, f, h)
}
pub fn fast_marching_step(narrow_band : Array[(Int, Double)], f : Double, h : Double) -> Array[(Int, Double)] {
  @fast_marching.fast_marching_step(narrow_band, f, h)
}
pub fn is_far(value : Double) -> Bool {
  @fast_marching.is_far(value)
}
pub fn is_frozen(value : Double) -> Bool {
  @fast_marching.is_frozen(value)
}

// ========== fast_sweeping ==========
pub fn sweep_update(u_center : Double, u_neighbor1 : Double, u_neighbor2 : Double, f : Double, h : Double) -> Double {
  @fast_sweeping.sweep_update(u_center, u_neighbor1, u_neighbor2, f, h)
}
pub fn fast_sweeping_iterate(u : Array[Double], f : Array[Double], h : Double, nx : Int, ny : Int) -> Array[Double] {
  @fast_sweeping.fast_sweeping_iterate(u, f, h, nx, ny)
}
pub fn sweeping_converged(u_old : Array[Double], u_new : Array[Double], tol : Double) -> Bool {
  @fast_sweeping.sweeping_converged(u_old, u_new, tol)
}

// ========== lattice_boltzmann ==========
pub fn equilibrium_dist(rho : Double, u : Double, w : Double, cx : Double) -> Double {
  @lattice_boltzmann.equilibrium_dist(rho, u, w, cx)
}
pub fn collide(f : Double, f_eq : Double, tau : Double) -> Double {
  @lattice_boltzmann.collide(f, f_eq, tau)
}
pub fn compute_density(dists : Array[Double]) -> Double {
  @lattice_boltzmann.compute_density(dists)
}
pub fn compute_velocity(dists : Array[Double], velocities : Array[Double]) -> Double {
  @lattice_boltzmann.compute_velocity(dists, velocities)
}
pub fn relaxation_time(nu : Double, dt : Double, dx : Double) -> Double {
  @lattice_boltzmann.relaxation_time(nu, dt, dx)
}

// ========== discontinuous_galerkin ==========
pub fn dg_mass_matrix(h : Double, p : Int) -> Double {
  @discontinuous_galerkin.dg_mass_matrix(h, p)
}
pub fn dg_stiffness_matrix(h : Double, p : Int) -> Double {
  @discontinuous_galerkin.dg_stiffness_matrix(h, p)
}
pub fn dg_numerical_flux(u_left : Double, u_right : Double, alpha : Double) -> Double {
  @discontinuous_galerkin.dg_numerical_flux(u_left, u_right, alpha)
}
pub fn dg_lax_friedrichs_flux(f_left : Double, f_right : Double, u_left : Double, u_right : Double, alpha : Double) -> Double {
  @discontinuous_galerkin.dg_lax_friedrichs_flux(f_left, f_right, u_left, u_right, alpha)
}
pub fn dg_error_estimate(element_error : Double, h : Double, p : Int) -> Double {
  @discontinuous_galerkin.dg_error_estimate(element_error, h, p)
}

// ========== radial_basis ==========
pub fn rbf_interpolate_gaussian(r : Double, eps : Double) -> Double {
  @radial_basis.rbf_interpolate_gaussian(r, eps)
}
pub fn rbf_interpolate_multiquadric(r : Double, eps : Double) -> Double {
  @radial_basis.rbf_interpolate_multiquadric(r, eps)
}
pub fn rbf_interpolate_inverse_multiquadric(r : Double, eps : Double) -> Double {
  @radial_basis.rbf_interpolate_inverse_multiquadric(r, eps)
}
pub fn rbf_interpolate_polyharmonic(r : Double, k : Int) -> Double {
  @radial_basis.rbf_interpolate_polyharmonic(r, k)
}
pub fn rbf_condition_number_estimate(centers : Array[(Double, Double)], eps : Double) -> Double {
  @radial_basis.rbf_condition_number_estimate(centers, eps)
}

// ========== kernel_density ==========
pub fn kd_gaussian_kernel(x : Double, h : Double) -> Double {
  @kernel_density.gaussian_kernel(x, h)
}
pub fn kde_estimate(points : Array[Double], x : Double, h : Double) -> Double {
  @kernel_density.kde_estimate(points, x, h)
}
pub fn silverman_bandwidth(n : Int, std_dev : Double) -> Double {
  @kernel_density.silverman_bandwidth(n, std_dev)
}
pub fn epanechnikov_kernel(x : Double, h : Double) -> Double {
  @kernel_density.epanechnikov_kernel(x, h)
}

// ========== gaussian_process ==========
pub fn gp_squared_exp_kernel(x1 : Double, x2 : Double, l : Double, sigma : Double) -> Double {
  @gaussian_process.squared_exp_kernel(x1, x2, l, sigma)
}
pub fn matern_kernel(x1 : Double, x2 : Double, l : Double, nu : Double) -> Double {
  @gaussian_process.matern_kernel(x1, x2, l, nu)
}
pub fn rational_quad_kernel(x1 : Double, x2 : Double, l : Double, alpha : Double) -> Double {
  @gaussian_process.rational_quad_kernel(x1, x2, l, alpha)
}
pub fn gp_predict_mean(k_train : Array[Double], k_test : Array[Double], y : Array[Double], noise : Double) -> Double {
  @gaussian_process.gp_predict_mean(k_train, k_test, y, noise)
}

// ========== svm_geometry ==========
pub fn linear_kernel(x1 : Array[Double], x2 : Array[Double]) -> Double {
  @svm_geometry.linear_kernel(x1, x2)
}
pub fn poly_kernel(x1 : Array[Double], x2 : Array[Double], degree : Int, c : Double) -> Double {
  @svm_geometry.poly_kernel(x1, x2, degree, c)
}
pub fn rbf_kernel(x1 : Array[Double], x2 : Array[Double], gamma : Double) -> Double {
  @svm_geometry.rbf_kernel(x1, x2, gamma)
}
pub fn margin_distance(w : Array[Double], b : Double, x : Array[Double], y : Double) -> Double {
  @svm_geometry.margin_distance(w, b, x, y)
}

// ========== decision_boundary ==========
pub fn linear_boundary(w : Array[Double], b : Double, x : Array[Double]) -> Double {
  @decision_boundary.linear_boundary(w, b, x)
}
pub fn boundary_distance(w : Array[Double], b : Double, x : Array[Double]) -> Double {
  @decision_boundary.boundary_distance(w, b, x)
}
pub fn boundary_classify(w : Array[Double], b : Double, x : Array[Double]) -> Int {
  @decision_boundary.boundary_classify(w, b, x)
}
pub fn quadratic_boundary(a : Double, b : Double, c : Double, x : Double) -> Double {
  @decision_boundary.quadratic_boundary(a, b, c, x)
}

// ========== feature_projection ==========
pub fn project_onto_line(point : (Double, Double), dir : (Double, Double)) -> Double {
  @feature_projection.project_onto_line(point, dir)
}
pub fn pca_1d_variance(projections : Array[Double]) -> Double {
  @feature_projection.pca_1d_variance(projections)
}
pub fn explained_variance_ratio(eigenvalues : Array[Double], k : Int) -> Double {
  @feature_projection.explained_variance_ratio(eigenvalues, k)
}
pub fn projection_residual(point : (Double, Double), proj : (Double, Double)) -> Double {
  @feature_projection.projection_residual(point, proj)
}

// ========== manifold_learning ==========
pub fn isomap_dist(dists : Array[Array[Double]], i : Int, j : Int) -> Double {
  @manifold_learning.isomap_dist(dists, i, j)
}
pub fn lle_weight(neighbors : Array[(Double, Double)], point_ : (Double, Double)) -> Array[Double] {
  @manifold_learning.lle_weight(neighbors, point_)
}
pub fn ml_laplacian_weight(x1 : (Double, Double), x2 : (Double, Double), sigma : Double) -> Double {
  @manifold_learning.laplacian_weight(x1, x2, sigma)
}

// ========== dimension_reduction ==========
pub fn tsne_similarity(d_ij : Double, sigma : Double) -> Double {
  @dimension_reduction.tsne_similarity(d_ij, sigma)
}
pub fn tsne_normalize(sim : Array[Array[Double]]) -> Array[Array[Double]] {
  @dimension_reduction.tsne_normalize(sim)
}
pub fn umap_cross_entropy(p : Double, q : Double) -> Double {
  @dimension_reduction.umap_cross_entropy(p, q)
}
pub fn kl_divergence(p : Array[Double], q : Array[Double]) -> Double {
  @dimension_reduction.kl_divergence(p, q)
}

// ========== clustering_geom ==========
pub fn cg_kmeans_assign(point : (Double, Double), centroids : Array[(Double, Double)]) -> Int {
  @clustering_geom.kmeans_assign(point, centroids)
}
pub fn kmeans_update(points : Array[(Double, Double)], assignments : Array[Int], k : Int) -> Array[(Double, Double)] {
  @clustering_geom.kmeans_update(points, assignments, k)
}
pub fn dbscan_eps_neighbors(points : Array[(Double, Double)], idx : Int, eps : Double) -> Array[Int] {
  @clustering_geom.dbscan_eps_neighbors(points, idx, eps)
}
pub fn silhouette_score(a : Double, b : Double) -> Double {
  @clustering_geom.silhouette_score(a, b)
}

// ========== regression_geom ==========
pub fn linear_regression(xs : Array[Double], ys : Array[Double]) -> (Double, Double) {
  @regression_geom.linear_regression(xs, ys)
}
pub fn polynomial_fit(xs : Array[Double], ys : Array[Double], degree : Int) -> Array[Double] {
  @regression_geom.polynomial_fit(xs, ys, degree)
}
pub fn r_squared(xs : Array[Double], ys : Array[Double], slope : Double, intercept : Double) -> Double {
  @regression_geom.r_squared(xs, ys, slope, intercept)
}
pub fn residual_norm(xs : Array[Double], ys : Array[Double], slope : Double, intercept : Double) -> Double {
  @regression_geom.residual_norm(xs, ys, slope, intercept)
}

// ========== bayesian_geom ==========
pub fn gaussian_log_likelihood(x : Double, mean : Double, std : Double) -> Double {
  @bayesian_geom.gaussian_log_likelihood(x, mean, std)
}
pub fn posterior_mean(prior_mean : Double, prior_var : Double, data_mean : Double, data_var : Double) -> Double {
  @bayesian_geom.posterior_mean(prior_mean, prior_var, data_mean, data_var)
}
pub fn posterior_var(prior_var : Double, data_var : Double) -> Double {
  @bayesian_geom.posterior_var(prior_var, data_var)
}
pub fn bayes_update(prior : Double, likelihood : Double, evidence : Double) -> Double {
  @bayesian_geom.bayes_update(prior, likelihood, evidence)
}

// ========== rrt_star ==========
pub fn rrt_distance(p1 : (Double, Double), p2 : (Double, Double)) -> Double {
  @rrt_star.rrt_distance(p1, p2)
}
pub fn rrt_nearest(tree : Array[(Double, Double)], sample : (Double, Double)) -> Int {
  @rrt_star.rrt_nearest(tree, sample)
}
pub fn rrt_steer(from : (Double, Double), to : (Double, Double), step : Double) -> (Double, Double) {
  @rrt_star.rrt_steer(from, to, step)
}
pub fn rrt_cost(parent_cost : Double, parent : (Double, Double), node : (Double, Double)) -> Double {
  @rrt_star.rrt_cost(parent_cost, parent, node)
}
pub fn rrt_rewire_radius(n : Int, d : Int, area : Double) -> Double {
  @rrt_star.rrt_rewire_radius(n, d, area)
}

// ========== prm_planner ==========
pub fn prm_sample_free(x_min : Double, x_max : Double, y_min : Double, y_max : Double) -> (Double, Double) {
  @prm_planner.prm_sample_free(x_min, x_max, y_min, y_max)
}
pub fn prm_connection_radius(n : Int, d : Int, volume : Double) -> Double {
  @prm_planner.prm_connection_radius(n, d, volume)
}
pub fn prm_edge_valid(p1 : (Double, Double), p2 : (Double, Double), obstacles : Array[(Double, Double, Double)]) -> Bool {
  @prm_planner.prm_edge_valid(p1, p2, obstacles)
}
pub fn prm_shortest_path(adj : Array[Array[Double]], start : Int, goal : Int) -> Double {
  @prm_planner.prm_shortest_path(adj, start, goal)
}

// ========== potential_field ==========
pub fn attractive_force(pos : (Double, Double), goal : (Double, Double), k_att : Double) -> (Double, Double) {
  @potential_field.attractive_force(pos, goal, k_att)
}
pub fn repulsive_force(pos : (Double, Double), obstacle : (Double, Double), k_rep : Double, d0 : Double) -> (Double, Double) {
  @potential_field.repulsive_force(pos, obstacle, k_rep, d0)
}
pub fn total_force(att : (Double, Double), rep : (Double, Double)) -> (Double, Double) {
  @potential_field.total_force(att, rep)
}
pub fn force_magnitude(f : (Double, Double)) -> Double {
  @potential_field.force_magnitude(f)
}

// ========== trajectory_opt ==========
pub fn trajectory_length(waypoints : Array[(Double, Double)]) -> Double {
  @trajectory_opt.trajectory_length(waypoints)
}
pub fn trajectory_smoothness(waypoints : Array[(Double, Double)]) -> Double {
  @trajectory_opt.trajectory_smoothness(waypoints)
}
pub fn trajectory_cost(waypoints : Array[(Double, Double)], w_len : Double, w_smooth : Double) -> Double {
  @trajectory_opt.trajectory_cost(waypoints, w_len, w_smooth)
}
pub fn bezier_point(p0 : (Double, Double), p1 : (Double, Double), p2 : (Double, Double), t : Double) -> (Double, Double) {
  @trajectory_opt.bezier_point(p0, p1, p2, t)
}

// ========== motion_planner_3d ==========
pub fn dist_3d(p1 : (Double, Double, Double), p2 : (Double, Double, Double)) -> Double {
  @motion_planner_3d.dist_3d(p1, p2)
}
pub fn interpolate_3d(p1 : (Double, Double, Double), p2 : (Double, Double, Double), t : Double) -> (Double, Double, Double) {
  @motion_planner_3d.interpolate_3d(p1, p2, t)
}
pub fn sphere_collision(pos : (Double, Double, Double), center : (Double, Double, Double), radius : Double) -> Bool {
  @motion_planner_3d.sphere_collision(pos, center, radius)
}
pub fn aabb_collision(min1 : (Double, Double, Double), max1 : (Double, Double, Double), min2 : (Double, Double, Double), max2 : (Double, Double, Double)) -> Bool {
  @motion_planner_3d.aabb_collision(min1, max1, min2, max2)
}
pub fn path_length_3d(path : Array[(Double, Double, Double)]) -> Double {
  @motion_planner_3d.path_length_3d(path)
}

// ========== kinematics ==========
pub fn forward_kin_2d(theta1 : Double, theta2 : Double, l1 : Double, l2 : Double) -> (Double, Double) {
  @kinematics.forward_kin_2d(theta1, theta2, l1, l2)
}
pub fn jacobian_2d(theta1 : Double, theta2 : Double, l1 : Double, l2 : Double) -> (Double, Double, Double, Double) {
  @kinematics.jacobian_2d(theta1, theta2, l1, l2)
}
pub fn inverse_kin_2d(x : Double, y : Double, l1 : Double, l2 : Double) -> (Double, Double) {
  @kinematics.inverse_kin_2d(x, y, l1, l2)
}
pub fn manipulability(j11 : Double, j12 : Double, j21 : Double, j22 : Double) -> Double {
  @kinematics.manipulability(j11, j12, j21, j22)
}

// ========== dynamics_geom ==========
pub fn inertia_tensor_rect(mass : Double, width : Double, height : Double, depth : Double) -> (Double, Double, Double) {
  @dynamics_geom.inertia_tensor_rect(mass, width, height, depth)
}
pub fn inertia_tensor_sphere(mass : Double, r : Double) -> Double {
  @dynamics_geom.inertia_tensor_sphere(mass, r)
}
pub fn dg_angular_momentum(i_val : Double, omega : Double) -> Double {
  @dynamics_geom.angular_momentum(i_val, omega)
}
pub fn dg_torque(i_val : Double, alpha : Double) -> Double {
  @dynamics_geom.torque(i_val, alpha)
}
pub fn dg_kinetic_energy_rot(i_val : Double, omega : Double) -> Double {
  @dynamics_geom.kinetic_energy_rot(i_val, omega)
}

// ========== collision_detect_3d ==========
pub fn sphere_sphere_dist(c1 : (Double, Double, Double), r1 : Double, c2 : (Double, Double, Double), r2 : Double) -> Double {
  @collision_detect_3d.sphere_sphere_dist(c1, r1, c2, r2)
}
pub fn cd_ray_sphere_intersect(origin : (Double, Double, Double), dir : (Double, Double, Double), center : (Double, Double, Double), radius : Double) -> Double {
  @collision_detect_3d.ray_sphere_intersect(origin, dir, center, radius)
}
pub fn point_in_tetrahedron(p : (Double, Double, Double), v0 : (Double, Double, Double), v1 : (Double, Double, Double), v2 : (Double, Double, Double), v3 : (Double, Double, Double)) -> Bool {
  @collision_detect_3d.point_in_tetrahedron(p, v0, v1, v2, v3)
}

// ========== grasp_planning ==========
pub fn grasp_contact_normal(object_center : (Double, Double, Double), contact_point : (Double, Double, Double)) -> (Double, Double, Double) {
  @grasp_planning.grasp_contact_normal(object_center, contact_point)
}
pub fn grasp_force_closure(forces : Array[(Double, Double, Double)], normals_ : Array[(Double, Double, Double)]) -> Bool {
  @grasp_planning.grasp_force_closure(forces, normals_)
}
pub fn gp_grasp_quality(forces : Array[(Double, Double, Double)], center_ : (Double, Double, Double)) -> Double {
  @grasp_planning.grasp_quality(forces, center_)
}

// ========== workspace_analysis ==========
pub fn reachability_map(joint_limits : Array[(Double, Double)], n_samples : Int) -> Int {
  @workspace_analysis.reachability_map(joint_limits, n_samples)
}
pub fn workspace_volume(bounds : (Double, Double, Double, Double, Double, Double)) -> Double {
  @workspace_analysis.workspace_volume(bounds)
}
pub fn dexterity_index(jacobian_det : Double, max_det : Double) -> Double {
  @workspace_analysis.dexterity_index(jacobian_det, max_det)
}
pub fn wa_condition_number(j11 : Double, j12 : Double, j21 : Double, j22 : Double) -> Double {
  @workspace_analysis.condition_number(j11, j12, j21, j22)
}

// ========== ray_trace_ops ==========
pub fn reflect(incident : (Double, Double, Double), normal : (Double, Double, Double)) -> (Double, Double, Double) {
  @ray_trace_ops.reflect(incident, normal)
}
pub fn refract(incident : (Double, Double, Double), normal : (Double, Double, Double), eta : Double) -> (Double, Double, Double) {
  @ray_trace_ops.refract(incident, normal, eta)
}
pub fn fresnel_schlick(cos_theta : Double, f0 : Double) -> Double {
  @ray_trace_ops.fresnel_schlick(cos_theta, f0)
}
pub fn ray_plane_t(origin : (Double, Double, Double), dir : (Double, Double, Double), point : (Double, Double, Double), normal : (Double, Double, Double)) -> Double {
  @ray_trace_ops.ray_plane_t(origin, dir, point, normal)
}

// ========== raster_2d ==========
pub fn bresenham_line(x0 : Int, y0 : Int, x1 : Int, y1 : Int) -> Array[(Int, Int)] {
  @raster_2d.bresenham_line(x0, y0, x1, y1)
}
pub fn edge_function(a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> Double {
  @raster_2d.edge_function(a, b, c)
}
pub fn barycentric_coord(p : (Double, Double), a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> (Double, Double, Double) {
  @raster_2d.barycentric_coord(p, a, b, c)
}
pub fn point_in_triangle(p : (Double, Double), a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> Bool {
  @raster_2d.point_in_triangle(p, a, b, c)
}

// ========== shading_model ==========
pub fn sm_lambertian(normal : (Double, Double, Double), light_dir : (Double, Double, Double)) -> Double {
  @shading_model.lambertian(normal, light_dir)
}
pub fn phong(normal : (Double, Double, Double), light_dir : (Double, Double, Double), view_dir : (Double, Double, Double), shininess : Double) -> Double {
  @shading_model.phong(normal, light_dir, view_dir, shininess)
}
pub fn blinn_phong(normal : (Double, Double, Double), light_dir : (Double, Double, Double), view_dir : (Double, Double, Double), shininess : Double) -> Double {
  @shading_model.blinn_phong(normal, light_dir, view_dir, shininess)
}
pub fn cook_torrance(ndotl : Double, ndotv : Double, ndoth : Double, vdoth : Double, roughness : Double, f0 : Double) -> Double {
  @shading_model.cook_torrance(ndotl, ndotv, ndoth, vdoth, roughness, f0)
}

// ========== texture_mapping ==========
pub fn spherical_mapping(point : (Double, Double, Double)) -> (Double, Double) {
  @texture_mapping.spherical_mapping(point)
}
pub fn cylindrical_mapping(point : (Double, Double, Double)) -> (Double, Double) {
  @texture_mapping.cylindrical_mapping(point)
}
pub fn planar_mapping(point : (Double, Double, Double), u_axis : (Double, Double), v_axis : (Double, Double)) -> (Double, Double) {
  @texture_mapping.planar_mapping(point, u_axis, v_axis)
}
pub fn tri_planar_mapping(point : (Double, Double, Double), normal : (Double, Double, Double)) -> (Double, Double) {
  @texture_mapping.tri_planar_mapping(point, normal)
}

// ========== bump_mapping ==========
pub fn perturb_normal(normal : (Double, Double, Double), bump : Double) -> (Double, Double, Double) {
  @bump_mapping.perturb_normal(normal, bump)
}
pub fn normal_from_height(h00 : Double, h10 : Double, h01 : Double, scale : Double) -> (Double, Double, Double) {
  @bump_mapping.normal_from_height(h00, h10, h01, scale)
}
pub fn tangent_space_normal(tangent : (Double, Double, Double), bitangent : (Double, Double, Double), normal : (Double, Double, Double), ts_normal : (Double, Double, Double)) -> (Double, Double, Double) {
  @bump_mapping.tangent_space_normal(tangent, bitangent, normal, ts_normal)
}

// ========== env_mapping ==========
pub fn cube_map_face(dir : (Double, Double, Double)) -> Int {
  @env_mapping.cube_map_face(dir)
}
pub fn cube_map_uv(dir : (Double, Double, Double), face : Int) -> (Double, Double) {
  @env_mapping.cube_map_uv(dir, face)
}
pub fn sphere_map_uv(normal : (Double, Double, Double), view : (Double, Double, Double)) -> (Double, Double) {
  @env_mapping.sphere_map_uv(normal, view)
}

// ========== shadow_mapping ==========
pub fn shadow_factor(depth : Double, shadow_map_depth : Double, bias : Double) -> Double {
  @shadow_mapping.shadow_factor(depth, shadow_map_depth, bias)
}
pub fn pcf_3x3(depths : Array[Array[Double]], ref_depth : Double, bias : Double) -> Double {
  @shadow_mapping.pcf_3x3(depths, ref_depth, bias)
}
pub fn vsm_variance(depths : Array[Double]) -> Double {
  @shadow_mapping.vsm_variance(depths)
}
pub fn vsm_chebyshev(t : Double, mean : Double, variance : Double) -> Double {
  @shadow_mapping.vsm_chebyshev(t, mean, variance)
}

// ========== anti_aliasing ==========
pub fn fxaa_luma(rgb : (Double, Double, Double)) -> Double {
  @anti_aliasing.fxaa_luma(rgb)
}
pub fn msaa_average(samples : Array[(Double, Double, Double)]) -> (Double, Double, Double) {
  @anti_aliasing.msaa_average(samples)
}
pub fn ssaa_weight_blend(c1 : (Double, Double, Double), c2 : (Double, Double, Double), w : Double) -> (Double, Double, Double) {
  @anti_aliasing.ssaa_weight_blend(c1, c2, w)
}
pub fn taa_resolve(history : (Double, Double, Double), current : (Double, Double, Double), alpha : Double) -> (Double, Double, Double) {
  @anti_aliasing.taa_resolve(history, current, alpha)
}

// ========== splatting ==========
pub fn gaussian_splat(x : Double, y : Double, sigma : Double) -> Double {
  @splatting.gaussian_splat(x, y, sigma)
}
pub fn splat_radius(screen_space_size : Double, depth : Double) -> Double {
  @splatting.splat_radius(screen_space_size, depth)
}
pub fn splat_coverage(px : Double, py : Double, cx : Double, cy : Double, r : Double) -> Double {
  @splatting.splat_coverage(px, py, cx, cy, r)
}
pub fn splat_alpha_blend(src_alpha : Double, dst_alpha : Double) -> Double {
  @splatting.splat_alpha_blend(src_alpha, dst_alpha)
}

// ========== gpu_geometry ==========
pub fn morton_code_2d(x : Int, y : Int) -> Int {
  @gpu_geometry.morton_code_2d(x, y)
}
pub fn hilbert_d2xy(d : Int, i : Int) -> (Int, Int) {
  @gpu_geometry.hilbert_d2xy(d, i)
}
pub fn vertex_cache_optimize(indices : Array[Int], cache_size_ : Int) -> Array[Int] {
  @gpu_geometry.vertex_cache_optimize(indices, cache_size_)
}
pub fn meshlet_bounds(verts : Array[(Double, Double, Double)]) -> ((Double, Double, Double), Double) {
  @gpu_geometry.meshlet_bounds(verts)
}

// ========== heat_equation ==========
pub fn he_heat_explicit_step(u : Array[Double], alpha : Double, dt : Double, dx : Double) -> Array[Double] {
  @heat_equation.heat_explicit_step(u, alpha, dt, dx)
}
pub fn heat_steady_state_1d(boundary_left : Double, boundary_right : Double, n : Int) -> Array[Double] {
  @heat_equation.heat_steady_state_1d(boundary_left, boundary_right, n)
}
pub fn heat_analytical_1d(x : Double, t : Double, alpha : Double, length : Double) -> Double {
  @heat_equation.heat_analytical_1d(x, t, alpha, length)
}

// ========== wave_equation ==========
pub fn we_wave_explicit_step(u_prev : Array[Double], u_curr : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  @wave_equation.wave_explicit_step(u_prev, u_curr, c, dt, dx)
}
pub fn we_wave_damping(u : Double, damping : Double, dt : Double) -> Double {
  @wave_equation.wave_damping(u, damping, dt)
}
pub fn we_wave_energy(u : Array[Double], u_prev : Array[Double], dt : Double) -> Double {
  @wave_equation.wave_energy(u, u_prev, dt)
}

// ========== poisson_solver ==========
pub fn ps_poisson_jacobi(u : Array[Double], f : Array[Double], h : Double) -> Array[Double] {
  @poisson_solver.poisson_jacobi(u, f, h)
}
pub fn poisson_gauss_seidel(u : Array[Double], f : Array[Double], h : Double) -> Array[Double] {
  @poisson_solver.poisson_gauss_seidel(u, f, h)
}
pub fn ps_poisson_residual(u : Array[Double], f : Array[Double], h : Double) -> Double {
  @poisson_solver.poisson_residual(u, f, h)
}

// ========== navier_stokes ==========
pub fn ns_ns_advection(u : Array[Double], v : Array[Double], dx : Double, dy : Double) -> Array[Double] {
  @navier_stokes.ns_advection(u, v, dx, dy)
}
pub fn ns_diffusion(u : Array[Double], nu : Double, dx : Double) -> Array[Double] {
  @navier_stokes.ns_diffusion(u, nu, dx)
}
pub fn ns_pressure_gradient(p : Array[Double], dx : Double) -> Array[Double] {
  @navier_stokes.ns_pressure_gradient(p, dx)
}
pub fn ns_reynolds_number(rho : Double, v : Double, length : Double, mu : Double) -> Double {
  @navier_stokes.ns_reynolds_number(rho, v, length, mu)
}

// ========== maxwell_solver ==========
pub fn ms_fdtd_update_e(e : Array[Double], h : Array[Double], dt : Double, dx : Double, eps : Double) -> Array[Double] {
  @maxwell_solver.fdtd_update_e(e, h, dt, dx, eps)
}
pub fn ms_fdtd_update_h(e : Array[Double], h : Array[Double], dt : Double, dx : Double, mu : Double) -> Array[Double] {
  @maxwell_solver.fdtd_update_h(e, h, dt, dx, mu)
}
pub fn courant_condition(dx : Double, dy : Double, dz : Double, c : Double) -> Double {
  @maxwell_solver.courant_condition(dx, dy, dz, c)
}

// ========== schrodinger_solver ==========
pub fn schrodinger_kinetic(psi_real : Array[Double], psi_imag : Array[Double], hbar : Double, m : Double, dx : Double, dt : Double) -> (Array[Double], Array[Double]) {
  @schrodinger_solver.schrodinger_kinetic(psi_real, psi_imag, hbar, m, dx, dt)
}
pub fn probability_density(psi_real : Double, psi_imag : Double) -> Double {
  @schrodinger_solver.probability_density(psi_real, psi_imag)
}
pub fn normalize_wavefunction(psi_real : Array[Double], psi_imag : Array[Double], dx : Double) -> (Array[Double], Array[Double]) {
  @schrodinger_solver.normalize_wavefunction(psi_real, psi_imag, dx)
}

// ========== reaction_diffusion ==========
pub fn gray_scott(u : Double, v : Double, f : Double, k : Double) -> (Double, Double) {
  @reaction_diffusion.gray_scott(u, v, f, k)
}
pub fn diffusion_step(field : Array[Double], d : Double, dt : Double, dx : Double) -> Array[Double] {
  @reaction_diffusion.diffusion_step(field, d, dt, dx)
}
pub fn turing_pattern_step(u : Array[Double], v : Array[Double], du : Double, dv : Double, f : Double, k : Double, dt : Double, dx : Double) -> (Array[Double], Array[Double]) {
  @reaction_diffusion.turing_pattern_step(u, v, du, dv, f, k, dt, dx)
}

// ========== advection_solver ==========
pub fn as_upwind_advection(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  @advection_solver.upwind_advection(u, c, dt, dx)
}
pub fn lax_friedrichs(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  @advection_solver.lax_friedrichs(u, c, dt, dx)
}
pub fn lax_wendroff(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  @advection_solver.lax_wendroff(u, c, dt, dx)
}

// ========== diffusion_solver ==========
pub fn crank_nicolson_coef(d : Double, dt : Double, dx : Double) -> Double {
  @diffusion_solver.crank_nicolson_coef(d, dt, dx)
}
pub fn ds_diffusion_2d_step(field : Array[Array[Double]], d : Double, dt : Double, dx : Double, dy : Double) -> Array[Array[Double]] {
  @diffusion_solver.diffusion_2d_step(field, d, dt, dx, dy)
}
pub fn ds_diffusion_stability_check(d : Double, dt : Double, dx : Double) -> Bool {
  @diffusion_solver.diffusion_stability_check(d, dt, dx)
}

// ========== eigenvalue_solver ==========
pub fn ev_power_iteration(a : Array[Array[Double]], v : Array[Double], n_iter : Int) -> (Double, Array[Double]) {
  @eigenvalue_solver.power_iteration(a, v, n_iter)
}
pub fn rayleigh_quotient(a : Array[Array[Double]], v : Array[Double]) -> Double {
  @eigenvalue_solver.rayleigh_quotient(a, v)
}
pub fn gershgorin_bounds(a : Array[Array[Double]]) -> (Double, Double) {
  @eigenvalue_solver.gershgorin_bounds(a)
}
