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
