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













// ---------------------------------------------------------------------------
// l_system: L-systems / L 系统
// ---------------------------------------------------------------------------











// ---------------------------------------------------------------------------
// fractal_dimension: Fractal dimension / 分形维数
// ---------------------------------------------------------------------------







// ---------------------------------------------------------------------------
// hausdorff_dimension: Hausdorff dimension / Hausdorff 维数
// ---------------------------------------------------------------------------










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
